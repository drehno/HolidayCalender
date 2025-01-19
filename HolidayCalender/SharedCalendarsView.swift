import SwiftUI

struct SharedCalendarsView: View {
    private let folderName = "sharedCalendars"
    @State private var sharedCalendars: [String] = []
    
    init() {
        createFolderIfNeeded(folderName: folderName)
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionHeaderView(title: "Shared with Me")
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                    ForEach(sharedCalendars, id: \.self) { calendar in
                        VStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.green.opacity(0.2))
                                .frame(height: 100)
                                .overlay(Image(systemName: "person.2.fill"))
                            Text(calendar)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                sharedCalendars = getAllCalendarNames(folderName: folderName)
            }
        }
    }
}


#Preview {
    SharedCalendarsView()
}
