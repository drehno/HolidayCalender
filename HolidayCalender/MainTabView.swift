import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                MyCalendarsView()
            }
            .tabItem {
                Label("My Calendars", systemImage: "calendar")
            }
            
            NavigationStack {
                SharedCalendarsView()
            }
            .tabItem {
                Label("Shared with Me", systemImage: "person.2.fill")
            }
        }
    }
}

#Preview {
    MainTabView()
}
