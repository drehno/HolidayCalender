import SwiftUI

struct OptionsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("isDarkModeEnabled") public var isDarkModeEnabled = true
    //TODO: Boolean wert ob das tor von einem kalender bereits geöffnet wurde und diesen in zeile 41 anstelle von isConditionMet einsetzen
    
    var body: some View {
        NavigationStack{
            ZStack{
                AppTheme.layeredGradient
                
                VStack(alignment: .leading){
                    Text("Settings")
                        .font(AppTheme.titleFont())
                        .foregroundColor(AppTheme.textPrimary)
                        .padding(.leading, 30)
                        .padding(.top, 40)
                    
                    Button(action: {
                        scheduleDailyNotification(hour: 20, minute: 0, isConditionMet: false)
                    }) {
                        HStack {
                            Text("Schedule Notifications")
                                .font(AppTheme.secondTitleFont())
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Spacer()
                        }
                        .padding()
                        .background(AppTheme.accentDark.opacity(0.3))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    HStack{
                        NavigationLink(destination: ExplanationView()
                            .toolbar(.hidden, for: .tabBar)) {
                                Text("Tarot Card Explanation")
                                    .font(AppTheme.secondTitleFont())
                                    .foregroundColor(AppTheme.textPrimary)
                            }
                            .padding()
                            .background(AppTheme.accentDark.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    HStack {
                        Text("Dark Mode")
                            .font(AppTheme.secondTitleFont())
                            .foregroundColor(AppTheme.textPrimary)
                                            
                        Spacer()
                                            
                        Toggle("", isOn: $isDarkModeEnabled)
                            .labelsHidden()
                            .onChange(of: isDarkModeEnabled) { oldValue, newValue in
                                updateColorScheme(newValue)
                            }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

func requestNotificationPermission() {
    let hasRequestedPermission = UserDefaults.standard.bool(forKey: "hasRequestedNotificationPermission")
    
    if !hasRequestedPermission {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if success {
                print("Permission granted")
            } else if let error = error {
                print("Permission denied: \(error.localizedDescription)")
            }
            
            UserDefaults.standard.set(true, forKey: "hasRequestedNotificationPermission")
        }
    }
}

func scheduleDailyNotification(hour: Int, minute: Int, isConditionMet: Bool) {
    //check if condition (opened door) is false
    if isConditionMet { return }

    //what does the notification say
    let content = UNMutableNotificationContent()
    content.sound = .default
    content.title = "Dont't forget"
    content.body = "You still have to open your calendar door!"
    
    //specifying when the notification pops up
    var dateComponents = DateComponents()
    dateComponents.hour = hour
    dateComponents.minute = minute

    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

    //create request
    let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)

    //create notification
    UNUserNotificationCenter.current().add(request)
}

public func updateColorScheme(_ isDarkModeEnabled: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let userInterfaceStyle: UIUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = userInterfaceStyle
            }
        }
    }

#Preview {
    OptionsView()
}
