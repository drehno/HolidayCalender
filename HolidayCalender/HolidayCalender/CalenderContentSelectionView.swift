import SwiftUI

struct CalenderContentSelectionView: View {
    let calendarTitle: String
    let startDate: Date
    let endDate: Date
    
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
                            createCalendar(
                                title: calendarTitle,
                                startDate: startDate,
                                endDate: endDate,
                                motivationalQuotes: motivationalQuotes,
                                motivationalPictures: motivationalPictures,
                                zodiacSignFacts: zodiacSignFacts,
                                futureTelling: futureTelling,
                                tarotCards: tarotCards
                            )
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
    func sanitizeFileName(_ name: String) -> String {
        return name.replacingOccurrences(of: " ", with: "")
    }
    func createCalendar(title: String,startDate: Date,endDate: Date,motivationalQuotes: Bool,motivationalPictures: Bool,zodiacSignFacts: Bool,futureTelling: Bool,tarotCards: Bool
    ) {
        let sanitizedFileName = sanitizeFileName(title)
        
        var calendarDays: [CalendarDay] = []
        let calendar = Calendar.current
        var currentDate = startDate
        
        while currentDate <= endDate {
            let background = motivationalPictures ? "motivational_bg" : "default_bg"
            let quote = motivationalQuotes ? "Keep going!" : "default_quote"
            
            let day = CalendarDay(date: currentDate, background: background, quote: quote)
            calendarDays.append(day)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        let csvContent = generateCSVContent(for: calendarDays)
        saveCSVFile(content: csvContent, fileName: sanitizedFileName)
    }
}

