import SwiftUI

struct CalenderContentSelectionView: View {
    @State private var motivationalQuotes = false
    @State private var motivationalPictures = false
    @State private var zodiacSignFacts = false
    @State private var futureTelling = false
    @State private var tarotCards = false
    @State private var navigateToCalendarView = false

    
    var body: some View {
        Group {
            if navigateToCalendarView {
                MyCalendarsView()
            } else {
                ZStack {
                    AppTheme.layeredGradient
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Motivational Quotes")
                                .font(AppTheme.secondTitleFont())
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Spacer()
                            
                            Toggle("", isOn: $motivationalQuotes)
                                .labelsHidden()
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                        
                        HStack {
                            Text("Motivational Pictures")
                                .font(AppTheme.secondTitleFont())
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Spacer()
                            
                            Toggle("", isOn: $motivationalPictures)
                                .labelsHidden()
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                        
                        HStack {
                            Text("Zodiac Sign Facts")
                                .font(AppTheme.secondTitleFont())
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Spacer()
                            
                            Toggle("", isOn: $zodiacSignFacts)
                                .labelsHidden()
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                        
                        HStack {
                            Text("Future Telling")
                                .font(AppTheme.secondTitleFont())
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Spacer()
                            
                            Toggle("", isOn: $futureTelling)
                                .labelsHidden()
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                        
                        HStack {
                            Text("Tarot cards")
                                .font(AppTheme.secondTitleFont())
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Spacer()
                            
                            Toggle("", isOn: $tarotCards)
                                .labelsHidden()
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                        
                        Spacer()
                        
                        Button(action: {
                            createExampleChalendar()
                            navigateToCalendarView = true
                        }) {
                            HStack {
                                Text("Create Calendar")
                                Image(systemName: "calendar.badge.plus")
                            }
                            .font(AppTheme.bodyFontBold())
                            .foregroundColor(.white)
                            .padding()
                            .background(AppTheme.accentDark)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                        }
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .navigationTitle("Calendar Content")
            }
        }
    }
    func createExampleChalendar() {
        let csvFormat = generateCSVContent(for: exampleCalendar)
        saveCSVFile(content: csvFormat, fileName: "HolidayCalendar18")
    }
}

#Preview {
    CalenderContentSelectionView()
}
