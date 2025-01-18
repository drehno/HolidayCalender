import SwiftUI

struct CalenderContentSelectionView: View {
    @State private var motivationalQuotes = false
    @State private var motivationalPictures = false
    @State private var zodiacSignFacts = false
    @State private var futureTelling = false
    @State private var tarotCards = false

    
    var body: some View {
        NavigationStack(){
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.01148428768, blue: 0.469781816, alpha: 1))]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                LinearGradient(gradient: Gradient(colors:  [ Color(#colorLiteral(red: 0, green: 0.01148428768, blue: 0.469781816, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .mask(Image("horoscope2")
                        .resizable()
                        .padding()
                        .aspectRatio(contentMode: .fit))
                
                VStack(alignment: .leading){
                    Text("Motivational Quotes")
                        .frame(maxWidth: .infinity, alignment:.topLeading)
                        .padding(.leading, 30)
                        .padding(.top)
                    
                    
                    Toggle("", isOn:  $motivationalQuotes)
                        .labelsHidden()
                        .padding(.leading, 30)
                    
                    Text("Motivational Pictures")
                        .frame(maxWidth: .infinity, alignment:.topLeading)
                        .padding(.leading, 30)
                        .padding(.top)
                    
                    
                    Toggle("", isOn:  $motivationalPictures)
                        .labelsHidden()
                        .padding(.leading, 30)
                    
                    Text("Zodiac Sign facts")
                        .frame(maxWidth: .infinity, alignment:.topLeading)
                        .padding(.leading, 30)
                        .padding(.top)
                    
                    
                    Toggle("", isOn:  $zodiacSignFacts)
                        .labelsHidden()
                        .padding(.leading, 30)
                    
                    Text("Future telling")
                        .frame(maxWidth: .infinity, alignment:.topLeading)
                        .padding(.leading, 30)
                        .padding(.top)
                    
                    
                    Toggle("", isOn:  $futureTelling)
                        .labelsHidden()
                        .padding(.leading, 30)
                    
                    Text("Tarot cards")
                        .frame(maxWidth: .infinity, alignment:.topLeading)
                        .padding(.leading, 30)
                        .padding(.top)
                    
                    
                    Toggle("", isOn:  $tarotCards)
                        .labelsHidden()
                        .padding(.leading, 30)

                    
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            // Action for creating the calendar
                        }) {
                            Text("Create calendar")
                                .padding()
                                .background(Color.blue.opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .navigationTitle("Calendar content")
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    CalenderContentSelectionView()
}
