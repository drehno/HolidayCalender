import SwiftUI



struct CalendarDetailView: View {
    @State private var showingShareSheet = false
    @State private var itemsToShare: [Any] = []
    
    var name: String
    let exampleCalendar: [CalendarDay]
    
    
    init(name: String) {
        self.name = name
        
        let date1 = dateFormatter.date(from: "01.01.2000") ?? Date()
        let date2 = dateFormatter.date(from: "02.01.2000") ?? Date()
        
        self.exampleCalendar = [
            CalendarDay(date: date1, background: "b1", quote: "Deine Mom."),
            CalendarDay(date: date2, background: "b2", quote: "Stay positive.")
        ]
        
        
    }

    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(Array(exampleCalendar.enumerated()), id: \.offset) {
 index,
                            entry in
                            NavigationLink(
                                destination: CalendarEntryView(entry: entry)
                            ) {
                                VStack(spacing: 1) {
                                    VStack { EmptyView() }
                                        .frame(height: 100)
                                        .calendarWidgetStyle()
                                    
                                    Text("\(dateFormatter.string(from: entry.date))")
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
                    Button(action: {shareTextFileAndLink()})
                           {  // Hide Tab Bar
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 4)
                        }
                           .padding()
                           .sheet(isPresented: $showingShareSheet) {
                               ShareSheet(activityItems: [URL(string: "https://google.com")!])
                           }
                }
            }
        }
    }
    
    func createTextFile(withContent content: String) -> URL? {
        let fileName = "sharedText.txt"
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent(fileName)
        
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Error writing text file: \(error)")
            return nil
        }
    }

    
    func shareTextFileAndLink() {
        let textContent = "This is the content of the text file."
        if let fileURL = createTextFile(withContent: textContent) {
            let shareURL = URL(string: "holidaycalendar://content/path?itemID=12345")!
            itemsToShare = [fileURL, shareURL]
            showingShareSheet = true
        } else {
            print("Failed to create text file.")
        }
    }
}

#Preview {
    CalendarDetailView(name: "cal1")
}
