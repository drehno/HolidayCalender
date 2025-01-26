import SwiftUI

struct CalendarEntryView: View {
    private let folderName = "createdCalendars"
    private let entry: CalendarDay
    private let calendarName : String
    private let calendarEntryNumber : Int
    @State private var createdCalendars: [String] = []
    @State private var selectedBackground: String 
    @State private var showImagePicker = false
    @State private var shareImage: UIImage? = nil
    @State private var isSharing = false
    
    @State var size: CGSize = .zero
    
    init(entry: CalendarDay, calendarName : String, calendarEntryNumber: Int) {
        self.entry = entry
        selectedBackground = entry.background
        self.calendarName = calendarName
        self.calendarEntryNumber = calendarEntryNumber
    }
    
    var body: some View {
        ZStack {
            Image("\(selectedBackground)")
                .resizable()
                .scaledToFill()
                .clipped()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 10)
            
            // The main box
            GeometryReader { proxy in 
                mainContentView
                    .cornerRadius(20)
                    .padding(20)
                    .onAppear {
                        let padding: CGFloat = 20
                        size = proxy.size
                        size.width -= padding * 2 
                        size.height -= padding * 3
                    }
            }
            
            // Share button (not included in the rendered image)
            VStack {
                HStack {
                    Spacer()
                    
                    // Edit Button
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                    .sheet(isPresented: $showImagePicker) {
                        BackgroundPicker(name: calendarName, day: calendarEntryNumber, onBackgroundSelected: { newBackground in
                            selectedBackground = newBackground
                            showImagePicker = false
                        })
                    }
                    
                    // Share Button
                    Button(action: {
                        shareEntry()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(20)
                            .shadow(radius: 4)
                    }
                }
                
                Spacer()
            }
            .padding([.trailing], 5)
            .padding([.top], 10)
        }
    }
    
    // Main content view (to be rendered as an image)
    private var mainContentView: some View {
            VStack(spacing: 0) { // Set spacing to 0 to avoid extra space
                // Top Date text
                Text("\(dateFormatter.string(from: entry.date))")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 3)
                            .background(Color.black.opacity(0.1))
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10) // Keep padding for visual appearance
                
                Spacer()
                
                // Centered text inside the box
                Text("\(entry.quote)")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 3)
                            .background(Color.black.opacity(0.4))
                    )
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(
                ZStack {
                    // Background image inside the box
                    Image("\(selectedBackground)")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
            )
        
    }
    
    private func shareEntry(){
        shareImage = renderViewToImage()
        if let image = shareImage {
            let activityViewController = UIActivityViewController(
                activityItems: [image],
                applicationActivities: nil
            )
            // Present the share sheet in a safe way
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let rootViewController = scene.windows.first?.rootViewController {
                    rootViewController.present(activityViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    // Render the view to an image
    private func renderViewToImage() -> UIImage {
        // Create a hosting controller for the main content view
        let controller = UIHostingController(rootView: mainContentView)
        let view = controller.view
        
        let targetSize = CGSize(
            width: size.width - 10, // Subtract padding
            height: size.height - 80 // Subtract padding
        )
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        // Render the view to an image
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    // Date formatter
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
