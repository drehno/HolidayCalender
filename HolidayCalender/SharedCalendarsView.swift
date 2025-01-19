import SwiftUI

struct SharedCalendarsView: View {
    let sharedCalendars = ["Shared Calendar 1", "Shared Calendar 2", "Shared Calendar 3"]
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionHeaderView(title: "Shared with Me")
            
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
