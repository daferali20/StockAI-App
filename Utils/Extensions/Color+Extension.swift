import SwiftUI

extension Color {
    static let stockGreen = Color(red: 0.0, green: 0.8, blue: 0.0)
    static let stockRed = Color(red: 0.8, green: 0.0, blue: 0.0)
    static let stockYellow = Color(red: 1.0, green: 0.8, blue: 0.0)
    static let stockGray = Color(red: 0.5, green: 0.5, blue: 0.5)
    
    static let darkBackground = Color(red: 0.07, green: 0.07, blue: 0.07)
    static let darkCard = Color(red: 0.12, green: 0.12, blue: 0.12)
    static let darkBorder = Color(red: 0.2, green: 0.2, blue: 0.2)
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
