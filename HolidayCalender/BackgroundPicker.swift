import SwiftUI

struct BackgroundPicker: View {
    @State var selectedBackground: String = ""
    var onBackgroundSelected: ((String) -> Void)?
    
    let calendarName : String
    let dayNumber : Int
    
    let availableBackgrounds = ["b1", "b2", "b3", "b4", "b5", "b6"]
    
    init(name: String, day: Int, onBackgroundSelected: ((String) -> Void)? = nil)
    {
    	calendarName = name + ".csv"
    	dayNumber = day
    	self.onBackgroundSelected = onBackgroundSelected
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(availableBackgrounds, id: \.self) { background in
                    Image(background)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            selectedBackground = background
                            replaceBackgroundInFile(
                                calendarName,
                                atOccurrence: dayNumber,
                                with: selectedBackground
                            )
                            onBackgroundSelected?(background)
                        }
                }
            }
            .padding()
        }
    }
}
