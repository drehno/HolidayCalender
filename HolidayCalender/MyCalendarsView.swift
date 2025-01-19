import SwiftUI

struct MyCalendarsView: View {
    private let folderName = "createdCalendars"
    @State private var createdCalendars: [String] = []
    
    init() {
        createFolderIfNeeded()
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack{
                    Text("My Calendars")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink{
                        OptionsView()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .padding()
                            .frame(width: 50, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 50).stroke())
                    }
                    
                    
                }
                .padding(25)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(createdCalendars, id: \.self) { calendar in
                            NavigationLink(destination: CalendarDetailView(name: calendar)){
                                VStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(height: 100)
                                        .overlay(Image(systemName: "calendar"))
                                    Text(calendar)
                                        .font(.caption)
                                        .foregroundColor(.primary)
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
                        .toolbar(.hidden, for: .tabBar)) {  // Hide Tab Bar
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.black)
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
