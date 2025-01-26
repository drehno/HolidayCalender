import SwiftUI

struct CalendarDetailView: View {
    @State private var showingShareSheet = false
    @State private var itemsToShare: [Any] = []
    @State private var navigateToMyCalendarsView = false
    @State private var calendarDays: [CalendarDay] = []
    @State private var showDeleteConfirmation = false
    
    @State private var tinyURL: String? = nil // State to store the generated TinyURL
    var name: String
    
    init(name: String) {
        self.name = name
        dateFormatterSetup()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.layeredGradient

                VStack(alignment: .leading) {
                    HStack {
                        Text(name)
                            .font(AppTheme.titleFont())
                            .foregroundColor(AppTheme.textPrimary)
                            .fontWeight(.bold)

                        Spacer()

                        Button(action: {
                            showDeleteConfirmation = true
                        }) {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(AppTheme.textPrimary)
                                .padding(8)
                        }
                    }
                    .padding(20)

                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                            ForEach(calendarDays, id: \.date) { entry in
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
                        Button(action: { shareCalendar() }) {
                            Image(systemName: "square.and.arrow.up")
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
                loadCalendarDays()
            }
            .navigationDestination(isPresented: $navigateToMyCalendarsView) {
                MyCalendarsView()
                    .navigationBarBackButtonHidden(true)
            }
            .alert("Delete Calendar", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) {
                }
                Button("Delete", role: .destructive) {
                    deleteCSVFile(fileName: "\(name)")
                    navigateToMyCalendarsView = true
                }
            } message: {
                Text("Are you sure about deleting this calendar? This action is permanent!")
            }
        }
    }
    
    func loadCalendarDays() {
        if let folderURL = getFolderURL(folderName: "createdCalendars") {
            let fileURL = folderURL.appendingPathComponent("\(name).csv")
            calendarDays = getCalender(fileURL: fileURL)
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
    
    func shareCalendar() {
        // Generate CSV content
        let csvContent = generateCSVContent(for: calendarDays)
        
        // Create a temporary file URL for the CSV file
        let fileName = self.name + ".csv"
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent(fileName)
        
        do {
            // Write the CSV content to the file
            try csvContent.write(to: fileURL, atomically: true, encoding: .utf8)
            
            // Construct the custom URL
            let customURL = "holidaycalendar://open?file=\(fileURL.lastPathComponent)"
            
            // Generate a TinyURL for the custom URL
            generateTinyURL(for: customURL) { tinyURL in
                if let tinyURL = tinyURL {
                    // Share the CSV file and the TinyURL
                    let activityViewController = UIActivityViewController(activityItems: [fileURL, tinyURL], applicationActivities: nil)
                    
                    // Present the share sheet in a safe way
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let rootViewController = scene.windows.first?.rootViewController {
                            rootViewController.present(activityViewController, animated: true, completion: nil)
                        }
                    }
                } else {
                    print("Failed to generate TinyURL")
                }
            }
        } catch {
            print("Error writing CSV file: \(error)")
        }
    }
    
    // Function to generate a TinyURL
    func generateTinyURL(for url: String, completion: @escaping (String?) -> Void) {
        let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let tinyURLAPI = "https://tinyurl.com/api-create.php?url=\(encodedURL)"
        
        guard let apiURL = URL(string: tinyURLAPI) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: apiURL) { data, response, error in
            if let error = error {
                print("Error generating TinyURL: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let tinyURL = String(data: data, encoding: .utf8) else {
                print("No data received from TinyURL API")
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(tinyURL)
            }
        }
        
        task.resume()
    }
}

#Preview {
    CalendarDetailView(name: "cal1")
}
