import Foundation
import Combine

class StockViewModel: ObservableObject {
    @Published var watchlist: [Stock] = []
    @Published var topMovers: [Stock] = []
    @Published var recommendations: [Recommendation] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService()
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        watchlist = [
            Stock(symbol: "AAPL", name: "Apple Inc.", price: 175.34, change: 2.5),
            Stock(symbol: "GOOGL", name: "Alphabet Inc.", price: 141.23, change: -1.2),
            Stock(symbol: "MSFT", name: "Microsoft", price: 378.92, change: 0.8)
        ]
        
        topMovers = [
            Stock(symbol: "NVDA", name: "NVIDIA", price: 825.12, change: 5.6),
            Stock(symbol: "AMD", name: "AMD", price: 162.45, change: 3.8),
            Stock(symbol: "TSLA", name: "Tesla", price: 245.67, change: -2.3)
        ]
        
        recommendations = [
            Recommendation(symbol: "AAPL", action: "Buy", confidence: 85, reason: "Strong earnings"),
            Recommendation(symbol: "GOOGL", action: "Hold", confidence: 70, reason: "Market uncertainty"),
            Recommendation(symbol: "NVDA", action: "Buy", confidence: 92, reason: "AI growth potential")
        ]
    }
    
    @MainActor
    func refreshData() async {
        isLoading = true
        defer { isLoading = false }
        
        // Simulate network call
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        // Update with new mock data
        watchlist = watchlist.map { stock in
            var updated = stock
            updated.price += Double.random(in: -5...5)
            updated.change += Double.random(in: -2...2)
            return updated
        }
    }
    
    func searchStock(query: String) async -> [Stock] {
        // Mock search
        return watchlist.filter { 
            $0.symbol.localizedCaseInsensitiveContains(query) || 
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
    
    func getAIAnalysis(symbol: String) async -> String? {
        // Mock AI analysis
        return "Based on recent performance and market trends, \(symbol) shows strong potential for growth in the next quarter."
    }
}

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    var price: Double
    var change: Double
}

struct Recommendation: Identifiable {
    let id = UUID()
    let symbol: String
    let action: String
    let confidence: Int
    let reason: String
}
