import SwiftUI



struct CalendarDetailView: View {
    @State private var showingShareSheet = false
    @State private var itemsToShare: [Any] = []
    
    var name: String
    
    init(name: String) {
        self.name = name
        
    }

    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack{
                    Text(name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button{
                        deleteCSVFile(fileName: "\(name)")
                    } label:{
                        Image(systemName: "line.3.horizontal")
                                                    .imageScale(.large)
                                                    .padding()
                                                    .frame(width: 50, height: 50)
                                                    .overlay(RoundedRectangle(cornerRadius: 50).stroke())
                    }
                    .padding(.trailing, 25)
                }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(Array(exampleCalendar.enumerated()), id: \.offset) { index, entry in
                            if isToday(entry.date) {
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
                            } else {
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
