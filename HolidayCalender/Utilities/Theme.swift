import SwiftUI

struct AppTheme {
    // Accent Colors
    static var accentLight: Color {
        Color("AccentLight")
    }

    static var accentDark: Color {
        Color("AccentDark")
    }

    static var accentBright: Color {
        Color("AccentBright")
    }
    
    static var backgroundLight: Color {
        Color("BackgroundLight")
    }

    static var backgroundDark: Color {
        Color("BackgroundDark")
    }

    static var textPrimary: Color {
        Color("TextPrimary")
    }

    // Gradient Background
    static var layeredGradient: some View {
        ZStack {
            // First Gradient Layer: Soft pastel blend
            LinearGradient(
                gradient: Gradient(colors: [
                    accentDark.opacity(0.3),
                    accentLight.opacity(0.5),
                    backgroundLight.opacity(0.7),
                    accentDark.opacity(0.5)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Second Layer: Radial glow for depth
            RadialGradient(
                gradient: Gradient(colors: [
                    accentLight.opacity(0.5),
                    Color.clear
                ]),
                center: .center,
                startRadius: 100,
                endRadius: 500
            )
            .blendMode(.overlay)
            .ignoresSafeArea()
        }
    }

    // Fonts
    static func titleFont() -> Font {
        Font.custom("AvenirNext-Bold", size: 28)
    }

    static func bodyFont() -> Font {
        Font.custom("AvenirNext-Regular", size: 18)
    }
}
