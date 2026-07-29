import SwiftUI

enum AppConstants {
    // MARK: - API
    static let apiBaseURL = "https://api.example.com/v1"
    static let apiKey = "YOUR_API_KEY_HERE"
    
    // MARK: - Colors
    static let primaryColor = Color("PrimaryColor")
    static let secondaryColor = Color("SecondaryColor")
    static let backgroundColor = Color("BackgroundColor")
    static let cardBackgroundColor = Color("CardBackgroundColor")
    static let textColor = Color("TextColor")
    static let accentGreen = Color("AccentGreen")
    static let accentRed = Color("AccentRed")
    static let accentYellow = Color("AccentYellow")
    
    // MARK: - UI
    static let cornerRadius: CGFloat = 12
    static let padding: CGFloat = 16
    static let smallPadding: CGFloat = 8
    static let animationDuration: Double = 0.3
    
    // MARK: - Market
    static let defaultSymbols = ["AAPL", "GOOGL", "TSLA", "AMZN", "MSFT", "META", "NVDA", "JPM"]
    static let refreshInterval: TimeInterval = 60 // seconds
    
    // MARK: - Fonts
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let titleFont = Font.system(.title, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
