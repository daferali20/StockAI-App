import SwiftUI

@main
struct StockAIApp: App {
    @StateObject private var marketViewModel = MarketViewModel()
    @StateObject private var aiAnalysisViewModel = AIAnalysisViewModel()
    @StateObject private var portfolioViewModel = PortfolioViewModel()
    @StateObject private var alertViewModel = AlertViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(marketViewModel)
                .environmentObject(aiAnalysisViewModel)
                .environmentObject(portfolioViewModel)
                .environmentObject(alertViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
