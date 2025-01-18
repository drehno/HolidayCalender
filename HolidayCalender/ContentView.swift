//
//  ContentView.swift
//  HolidayCalender
//
//  Created by Max krupa on 12.01.25.
//

import SwiftUI


struct ContentView: View {
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
                
                /*Image("horoscope2")
                 .resizable()
                 .renderingMode(.template)
                 .foregroundColor(.white)
                 .frame(width: 330, height: 330)*/
                
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
                            
                            Text("Calender title")
                                .frame(maxWidth: .infinity, alignment:.topLeading)
                                .padding(.leading, 30)
                                .padding(.top)
                            
                            TextField("calender title", text: $customCalenderTitle)
                                .padding(.leading, 30)
                                .frame(width: 300, height: 50)
                                .textFieldStyle(.roundedBorder)
                            
                            Text("Daily Doors")
                                .frame(maxWidth: .infinity, alignment:.topLeading)
                                .padding(.leading, 30)
                                .padding(.top)
                            
                            
                            Toggle("", isOn:  $dailyDoors)
                                .labelsHidden()
                                .padding(.leading, 30)
                            
                            Text("how many doors should be created?")
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .navigationTitle("Calender creator")
                        .preferredColorScheme(.dark)
                        
                        
                        
                    }
                    Spacer()
                }
                NavigationLink(destination: CalenderContentSelectionView()){
                    Text("Create calender")
                }
                .buttonStyle(.bordered)
                .padding(.leading, 30)
                .padding(.top)
                .tint(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

#Preview {
    ContentView()
}
