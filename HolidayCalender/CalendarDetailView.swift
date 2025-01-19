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
                    Button(action: {shareCalendar()})
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
                           /*.sheet(isPresented: $showingShareSheet) {
                               ShareSheet(activityItems: itemsToShare)
                           }*/
                }
            }
        }
    }
    
    func createTextFile(withContent content: String) -> URL? {
        let fileName = "sharedCalendar.csv"
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
            let shareURL = URL(string: "holidaycalendar://home")!
            itemsToShare = [fileURL, shareURL]
            showingShareSheet = true
            
            
            do {
                // Write the CSV content to the file
                try textContent
                    .write(to: fileURL, atomically: true, encoding: .utf8)
                
                // Construct the custom URL to open your app
                let customURL = URL(string: "holidaycalendar://open?file=\(fileURL.absoluteString)")!
                
                // Share the file via WhatsApp
                let activityViewController = UIActivityViewController(activityItems: [customURL], applicationActivities: nil)
                
                
                // Present the share sheet
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let rootViewController = scene.windows.first?.rootViewController {
                        rootViewController.present(activityViewController, animated: true, completion: nil)
                    }
                }
                
            } catch {
                print("Error writing CSV file: \(error)")
            }
        } else {
            print("Failed to create text file.")
        }
    }
    
    func shareCalendar() {
        // Sample CSV content
        let csvContent = generateCSVContent(for: exampleCalendar)
        
        // Create a temporary file URL for the CSV file
        let fileName = self.name + ".csv"
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent(fileName)
        
        do {
            // Write the CSV content to the file
            try csvContent.write(to: fileURL, atomically: true, encoding: .utf8)
            
            // Construct the custom URL to open your app
            let customURL = "holidaycalendar://open?file=\(fileURL.lastPathComponent)"
            
            // Share the file via WhatsApp
            let activityViewController = UIActivityViewController(activityItems: [fileURL, customURL], applicationActivities: nil)
            
            // Present the share sheet in a safe way
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let rootViewController = scene.windows.first?.rootViewController {
                    rootViewController.present(activityViewController, animated: true, completion: nil)
                }
            }
            
        } catch {
            print("Error writing CSV file: \(error)")
        }
    }
}



#Preview {
    CalendarDetailView(name: "cal1")
}
