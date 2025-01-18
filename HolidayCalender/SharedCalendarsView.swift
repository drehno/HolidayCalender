//
//  SharedCalendarsView.swift
//  HolidayCalender
//
//  Created by iOS on 18.01.25.
//

import SwiftUI

struct SharedCalendarsView: View {
    let sharedCalendars = ["Shared Calendar 1", "Shared Calendar 2", "Shared Calendar 3"]
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("Shared with Me")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                    ForEach(sharedCalendars, id: \.self) { calendar in
                        VStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.green.opacity(0.2))
                                .frame(height: 100)
                                .overlay(Image(systemName: "person.2.fill"))
                            Text(calendar)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    SharedCalendarsView()
}
