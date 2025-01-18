//
//  CalenderContentSelectionView.swift
//  HolidayCalender
//
//  Created by Max krupa on 17.01.25.
//

import SwiftUI

struct CalenderContentSelectionView: View {
    @State private var motivationalQuotes = false
    @State private var motivationalPictures = false
    @State private var zodiacSignFacts = false
    @State private var futureTelling = false


    
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
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
            .navigationTitle("Calender content")
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    CalenderContentSelectionView()
}
