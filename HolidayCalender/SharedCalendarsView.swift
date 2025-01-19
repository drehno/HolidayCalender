import SwiftUI

struct SharedCalendarsView: View {
    private let folderName = "sharedCalendars"
    @State private var sharedCalendars: [String] = []
    
    init() {
        createFolderIfNeeded(folderName: folderName)
    }
    
    
    var body: some View {
        ZStack {
            AppTheme.layeredGradient
            
            VStack(alignment: .leading) {
                SectionHeaderView(title: "Shared with Me")
                    .font(AppTheme.titleFont())
                    .foregroundStyle(AppTheme.textPrimary)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 130), spacing: 10)], spacing: 25) {
                        ForEach(sharedCalendars, id: \.self) { calendar in
                            NavigationLink(destination: CalendarDetailView(name: calendar)){
                                VStack(spacing: 1) {
                                    VStack { EmptyView() }
                                        .frame(height: 130)
                                        .calendarWidgetStyle()
                                    
                                    Text(calendar)
                                        .font(AppTheme.bodyFont())
                                        .foregroundColor(AppTheme.textPrimary)
                                        .multilineTextAlignment(.center)
                                        .frame(height: 30)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                sharedCalendars = getAllCalendarNames(folderName: folderName)
            }
            .padding()
        }
    }
}

#Preview {
    SharedCalendarsView()
}
