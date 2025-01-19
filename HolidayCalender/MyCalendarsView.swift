import SwiftUI

struct MyCalendarsView: View {
    private let folderName = "createdCalendars"
    @State private var createdCalendars: [String] = []
    
    init() {
        createFolderIfNeeded()
    }
    
    var body: some View {
        ZStack {
            AppTheme.layeredGradient
            
            VStack(alignment: .leading) {
                SectionHeaderView(title: "My Calendars")
                    .font(AppTheme.titleFont())
                    .foregroundStyle(AppTheme.textPrimary)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 130), spacing: 20)], spacing: 25) {
                        ForEach(createdCalendars, id: \.self) { calendar in
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
            createdCalendars = getAllCalendarNames()
        }
    }
    
    private func getFolderURL() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName)
    }
    
    func getAllCalendarNames() -> [String] {
        guard let folderURL = getFolderURL() else { return [] }
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            let calendarNames = fileURLs.map { $0.deletingPathExtension().lastPathComponent }
            return calendarNames
        } catch {
            print("Failed to retrieve calendar names: \(error)")
            return []
        }
    }
    
    private func createFolderIfNeeded() {
        guard let folderURL = getFolderURL() else { return }
        
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
                print("Folder created at: \(folderURL.path)")
            } catch {
                print("Failed to create folder: \(error)")
            }
        }
    }
}

#Preview {
    MyCalendarsView()
}
