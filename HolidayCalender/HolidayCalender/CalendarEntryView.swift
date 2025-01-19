import SwiftUI

struct CalendarEntryView: View {
    private let folderName = "createdCalendars"
    @State private var createdCalendars: [String] = []
    private let entry : CalendarDay
    private let backgroundImage: String
    
    init(entry: CalendarDay) {
        self.entry = entry
        switch entry.background {
            case "b1": 
                backgroundImage = "moon-7744608_1920"
            case "b2" : 
                backgroundImage = "mountains-5993080_1920_11zon"
            case "b3" : 
                backgroundImage = "astrology (3)"    
            default: 
                backgroundImage = "astrology (3)"
                
        }
    }
    
    
    var body: some View {
        ZStack {
            // The main box 
            VStack {
                // Top Date text
                Text("\(dateFormatter.string(from: entry.date))")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10) // Rounded corners for the border
                            .stroke(Color.black, lineWidth: 3) // Red border with 3-point thickness
                            .background(Color.black.opacity(0.1))
                    )
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .center) 
                
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
            .cornerRadius(20) 
            .padding(20) 
        }

    }
}

#Preview {
    CalendarEntryView(entry: exampleCalendar[0])
}

