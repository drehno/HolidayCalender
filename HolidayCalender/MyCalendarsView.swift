import SwiftUI

struct MyCalendarsView: View {
    let createdCalendars = ["Calendar 1", "Calendar 2", "Calendar 3"]
    @State private var isShowingCreateView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text("My Calendars")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                        .padding(.top)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                            ForEach(createdCalendars, id: \.self) { calendar in
                                VStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(height: 100)
                                        .overlay(Image(systemName: "calendar"))
                                    Text(calendar)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                        .padding()
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CalendarCreateView()) {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 4)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    MyCalendarsView()
}
