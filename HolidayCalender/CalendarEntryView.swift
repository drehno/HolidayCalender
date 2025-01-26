import SwiftUI

struct CalendarEntryView: View {
    private let folderName = "createdCalendars"
    @State private var createdCalendars: [String] = []
    private let entry: CalendarDay
    private let backgroundImage: String
    
    @State private var shareImage: UIImage? = nil
    @State private var isSharing = false
    
    init(entry: CalendarDay) {
        self.entry = entry
        switch entry.background {
            case "b1":
                backgroundImage = "moon-7744608_1920"
            case "b2":
                backgroundImage = "mountains-5993080_1920_11zon"
            case "b3":
                backgroundImage = "astrology (3)"
            default:
                backgroundImage = "astrology (3)"
        }
    }
    
    var body: some View {
        ZStack {
            // The main box
            mainContentView
                .cornerRadius(20)
                .padding(20)
            
            // Share button (not included in the rendered image)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        shareEntry()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 30)
                    .padding(.bottom, 20)
                }
            }
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
                Image("\(backgroundImage)")
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
        
        // Define the target size explicitly (without padding)
        let targetSize = CGSize(
            width: UIScreen.main.bounds.width - 40, // Subtract padding
            height: UIScreen.main.bounds.height - 40 // Subtract padding
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

// ActivityView to share the image
struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    CalendarEntryView(entry: exampleCalendar[0])
}
