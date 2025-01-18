//
//  ContentView.swift
//  HolidayCalender
//
//  Created by Max krupa on 12.01.25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                MyCalendarsView()
                    .tabItem {
                        Label("My Calendars", systemImage: "calendar")
                    }
                
                SharedCalendarsView()
                    .tabItem {
                        Label("Shared with Me", systemImage: "person.2.fill")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
