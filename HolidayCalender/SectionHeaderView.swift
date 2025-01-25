import SwiftUI

struct SectionHeaderView: View {
    let title: String

    var body: some View {
        HStack {
            // Section Title
            Text(title)
                .font(AppTheme.titleFont())
                .foregroundColor(AppTheme.textPrimary)
                .fontWeight(.bold)

            Spacer()

            // Navigation Button
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
        .padding(25)
    }
}

#Preview {
    MainTabView()
}
