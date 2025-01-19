import SwiftUI

struct CalendarWidgetModifier: ViewModifier {
    var backgroundImage: Image?

    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(colorScheme == .dark ? Color.black.opacity(0.6) : Color.white)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.25), radius: 10, x: 0, y: 8)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.5), radius: 2, x: -2, y: -2)

            ZStack {
                if let backgroundImage = backgroundImage {
                    backgroundImage
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    AppTheme.accentLight.opacity(0.15),
                                    AppTheme.backgroundLight.opacity(0.2),
                                    AppTheme.accentLight.opacity(0.15)
                                ]),
                                startPoint: .topTrailing,
                                endPoint: .bottomTrailing
                            )
                        )
                }

                // Default Calendar Icon
                if backgroundImage == nil {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(AppTheme.textPrimary)
                }

                // Content inside the widget
                content
                    .padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(10)
    }
}

extension View {
    func calendarWidgetStyle(backgroundImage: Image? = nil) -> some View {
        self.modifier(CalendarWidgetModifier(backgroundImage: backgroundImage))
    }
}
