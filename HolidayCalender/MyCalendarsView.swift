import SwiftUI

struct MyCalendarsView: View {
    private let folderName = "createdCalendars"
    @State private var createdCalendars: [String] = []
    @State private var calendarBackgrounds: [String] = []
    
    init() {
        createFolderIfNeeded(folderName: folderName)
    }
    
    var body: some View {
        ZStack {
            AppTheme.layeredGradient
            
            VStack(alignment: .leading) {
                SectionHeaderView(title: "My Calendars")
                    .font(AppTheme.titleFont())
                    .foregroundStyle(AppTheme.textPrimary)
                    .padding(.bottom, 10)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(Array(zip(createdCalendars, calendarBackgrounds)), id: \.0) { (calendar, background) in
                            NavigationLink(destination: CalendarDetailView(name: calendar)) {
                                ZStack {
                                    // Background image for the calendar
                                    Image(background) // Replace with your actual image name
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 180)
                                        .cornerRadius(12)
                                        .clipped()
                                        .overlay(
                                            Color.black.opacity(0.3) // Add overlay for better text readability
                                                .cornerRadius(12)
                                        )
                                    
                                    // Calendar name overlay
                                    Text(calendar)
                                        .font(AppTheme.titleFont())
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding(10)
                                        .background(
                                            Color.black.opacity(0.5)
                                                .cornerRadius(8)
                                        )
                                        .padding(.horizontal, 10)
                                }
                                .shadow(radius: 4)
                            }
                        }
                    }
                    .padding()
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: CalendarCreateView()
                        .toolbar(.hidden, for: .tabBar)) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .padding(20)
                                .background(AppTheme.accentDark)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 4)
                        }
                        .padding()
                }
            }
        }
        .onAppear {
            createdCalendars = getAllCalendarNames(folderName: folderName)
            calendarBackgrounds = getAllCalendarBackgrounds(folderName: folderName)
        }
    }
}

#Preview {
    MyCalendarsView()
}
