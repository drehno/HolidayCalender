import SwiftUI

struct CalendarCreateView: View {
    @State private var customCalenderTitle: String = ""
    @State private var dailyDoors = false
    @State private var howManyDoors: Int = 1
    @State private var startingDate = Date()
    @State private var endingDate = Date()
    
    var body: some View {
        NavigationStack(){
            ZStack(){
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
                
                //constellation
                //horoscope2
                VStack{
                    ScrollView(){
                        VStack(alignment: .leading){
                            
                            Text("Calendar title")
                                .frame(maxWidth: .infinity, alignment:.topLeading)
                                .padding(.leading, 30)
                                .padding(.top)
                            
                            TextField("Calendar title", text: $customCalenderTitle)
                                .padding(.leading, 30)
                                .frame(width: 300, height: 50)
                                .textFieldStyle(.roundedBorder)
                            
                            Text("Daily doors")
                                .frame(maxWidth: .infinity, alignment:.topLeading)
                                .padding(.leading, 30)
                                .padding(.top)
                            
                            
                            Toggle("", isOn:  $dailyDoors)
                                .labelsHidden()
                                .padding(.leading, 30)
                            
                            Text("How many doors should be created?")
                                .frame(maxWidth: .infinity, alignment:.topLeading)
                                .keyboardType(.numberPad)
                                .padding(.leading, 30)
                                .padding(.top)
                            
                            Picker("Choose a number", selection: $howManyDoors) {
                                ForEach(1...365, id: \.self) { number in
                                    Text("\(number)").tag(number)
                                }
                            }
                            .padding(.leading, 30)
                            .padding(.top)
                            .tint(.white)
                            
                            
                            Text("Starting date")
                                .frame(maxWidth: .infinity, alignment:.topLeading)
                                .padding(.leading, 30)
                                .padding(.top)
                            
                            DatePicker(
                                "",
                                selection: $startingDate,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.compact)
                            .padding(.leading, 30)
                            .labelsHidden()
                            
                            Text("End date")
                                .frame(maxWidth: .infinity, alignment:.topLeading)
                                .padding(.leading, 30)
                                .padding(.top)
                            
                            DatePicker("",
                                selection: $endingDate,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.compact)
                            .padding(.leading, 30)
                            .labelsHidden()
                        }
                        .navigationTitle("Calendar Creator")
                        .preferredColorScheme(.dark)
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CalenderContentSelectionView()) {
                            HStack {
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarCreateView()
}
