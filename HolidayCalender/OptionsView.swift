//
//  OptionsView.swift
//  HolidayCalender
//
//  Created by Max krupa on 17.01.25.
//

import SwiftUI

struct OptionsView: View {
    //TODO: Boolean wert ob das tor von einem kalender bereits geöffnet wurde und diesen in zeile 41 anstelle von isConditionMet einsetzen
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack(alignment: .leading){
                    Text("Settings")
                        .frame(maxWidth: .infinity, alignment:.topLeading)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                        .padding(.top)
                    
                    //TODO: der button kann später entfernt werden und die aktion wird beim bspw starten der App ausgeführt
                    Button("permisson for notifications"){
                        UNUserNotificationCenter
                            .current()
                            .requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                            if success {
                                print("permission granted")
                            } else if let error = error {
                                print("permission denied: \(error.localizedDescription)")
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.top)
                    .buttonStyle(.bordered)
                        
                    Button("Schedule notifications"){
                        scheduleDailyNotification(hour: 20, minute: 0, isConditionMet: false)
                    }
                    .padding(.leading, 30)
                    .padding(.top)
                    .buttonStyle(.bordered)
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
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

#Preview {
    OptionsView()
}
