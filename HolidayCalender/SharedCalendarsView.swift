import SwiftUI

struct SharedCalendarsView: View {
    let sharedCalendars = ["Shared Calendar 1", "Shared Calendar 2", "Shared Calendar 3"]
    
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
            .padding()
        }
    }
}

#Preview {
    SharedCalendarsView()
}
