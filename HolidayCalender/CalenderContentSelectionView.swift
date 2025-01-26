import SwiftUI

struct CalenderContentSelectionView: View {
    let calendarTitle: String
    let birthDate: Date
    let startDate: Date
    let endDate: Date
    
    @State private var motivationalQuotes = false
    @State private var motivationalPictures = false
    @State private var zodiacSignFacts = false
    @State private var futureTelling = false
    @State private var tarotCards = false
    @State private var navigateToCalendarView = false
    
    private var zodiacSign: String {
        getZodiacSign(for: birthDate)
    }

    private let backgrounds = ["b1", "b2", "b3"]

    var body: some View {
        NavigationStack {
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
                        createCalendar()
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
            .navigationDestination(isPresented: $navigateToCalendarView) {
                MyCalendarsView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    func sanitizeFileName(_ name: String) -> String {
        return name.replacingOccurrences(of: " ", with: "")
    }

    func createCalendar() {
        let sanitizedFileName = sanitizeFileName(calendarTitle)
        
        var calendarDays: [CalendarDay] = []
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let adjustedStartDate = calendar.startOfDay(for: startDate)
        var currentDate = adjustedStartDate
        
        let content = loadZodiacContent(for: zodiacSign)
        let quotes = motivationalQuotes ? content.quotes : []
        let facts = zodiacSignFacts ? content.facts : []
                
        while currentDate <= endDate {
                var dayContent: String = ""

                if !quotes.isEmpty && Bool.random() {
                    dayContent = quotes.randomElement() ?? ""
                } else if !facts.isEmpty {
                    dayContent = facts.randomElement() ?? ""
                }
            
                let background = ["b1", "b2", "b3"].randomElement() ?? "b1"

                let day = CalendarDay(date: currentDate, background: background, quote: dayContent)
                calendarDays.append(day)

                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
            }
        
        let csvContent = generateCSVContent(for: calendarDays)
        saveCSVFile(content: csvContent, fileName: sanitizedFileName)
    }
}

