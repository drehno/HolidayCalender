import SwiftUI

struct SectionHeaderView: View {
    let title: String

    var body: some View {
        HStack {
            // Section Title
            Text(title)
                .font(AppTheme.titleFont()) // Title font from theme
                .foregroundColor(AppTheme.textPrimary) // Theme color for text
                .fontWeight(.bold)

            Spacer()

            // Navigation Button with Smaller Settings Icon
            NavigationLink(destination: OptionsView()
                .toolbar(.hidden, for: .tabBar)) {
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(AppTheme.textPrimary)
                    .padding(8)
            }
        }
        .padding(20)
    }
}


