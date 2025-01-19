import SwiftUI

struct CalendarCreateView: View {
    @State private var calendarTitle: String = ""
   // @State private var dailyDoors = false
   // @State private var howManyDoors: Int = 1
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var navigateToContentSelection = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.layeredGradient
                
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Calendar Title
                            Text("Calendar Title")
                                .font(AppTheme.secondTitleFont())
                                .foregroundColor(AppTheme.textPrimary)
                                .padding(.leading, 30)
                                .padding(.top, 40)
                            
                            TextField("Calendar title", text: $calendarTitle)
                                .padding(10)
                                .background(AppTheme.accentDark.opacity(0.3))
                                .cornerRadius(10)
                                .padding(.horizontal, 30)
                                .font(AppTheme.bodyFont())
                            
                            // Daily Doors Toggle
                            /*
                             HStack {
                             Text("Daily Doors")
                             .font(AppTheme.secondTitleFont())
                             .foregroundColor(AppTheme.textPrimary)
                             
                             Spacer()
                             
                             Toggle("", isOn: $dailyDoors)
                             .labelsHidden()
                             }
                             .padding(.horizontal, 30)
                             .padding(.top, 40)
                             */
                            
                            /*
                             // Number of Doors Picker
                             HStack {
                             Text("Number of Doors")
                             .font(AppTheme.secondTitleFont())
                             .foregroundColor(AppTheme.textPrimary)
                             
                             Spacer()
                             
                             Picker("Choose a number", selection: $howManyDoors) {
                             ForEach(1...365, id: \.self) { number in
                             Text("\(number)")
                             .font(AppTheme.bodyFont())
                             .tag(number)
                             }
                             }
                             .pickerStyle(.menu)
                             .padding(10)
                             .background(AppTheme.accentDark.opacity(0.3))
                             .cornerRadius(10)
                             .accessibilityLabel("Select number of doors")
                             }
                             .padding(.horizontal, 30)
                             .padding(.top, 30)
                             */
                            
                            // Starting Date
                            HStack {
                                Text("Start Date")
                                    .font(AppTheme.secondTitleFont())
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Spacer()
                                
                                DatePicker("", selection: $startDate, displayedComponents: [.date])
                                    .datePickerStyle(.compact)
                                    .cornerRadius(10)
                                    .accessibilityLabel("Select start date")
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 30)
                            
                            // Ending Date
                            HStack {
                                Text("End Date")
                                    .font(AppTheme.secondTitleFont())
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Spacer()
                                
                                DatePicker("", selection: $endDate, displayedComponents: [.date])
                                    .datePickerStyle(.compact)
                                    .cornerRadius(10)
                                    .accessibilityLabel("Select end date")
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 30)
                        }
                    }
                    
                    Spacer()
                    
                    // Next Button
                    HStack {
                        Spacer()
                        NavigationLink(destination: CalenderContentSelectionView(
                            calendarTitle: calendarTitle, startDate: startDate, endDate: endDate
                        )) {
                            HStack {
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.white)
                            .font(AppTheme.bodyFontBold())
                            .padding()
                            .background(AppTheme.accentDark)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .disabled(calendarTitle.isEmpty || startDate > endDate)
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Create Your Calendar")
        }
    }
}
