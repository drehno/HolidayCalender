import SwiftUI

struct BackgroundPicker: View {
    @Binding var selectedBackground: String
    var onBackgroundSelected: (() -> Void)?
    
    let availableBackgrounds = ["b1", "b2", "b3", "b4", "b5", "b6"]
    
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
                            onBackgroundSelected?()
                        }
                }
            }
            .padding()
        }
    }
}
