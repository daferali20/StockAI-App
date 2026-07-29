import Foundation

struct UserPortfolio: Codable {
    var holdings: [Holding]
    var cashBalance: Double
    var totalValue: Double {
        return holdings.reduce(cashBalance) { $0 + $1.currentValue }
    }
    
    var totalProfitLoss: Double {
        return holdings.reduce(0) { $0 + $1.profitLoss }
    }
    
    var totalProfitLossPercent: Double {
        guard totalValue - cashBalance > 0 else { return 0 }
        return (totalProfitLoss / (totalValue - cashBalance)) * 100
    }
}

struct Holding: Identifiable, Codable {
    let id = UUID()
    let symbol: String
    let shares: Double
    let averagePrice: Double
    var currentPrice: Double
    var currentValue: Double {
        return shares * currentPrice
    }
    var profitLoss: Double {
        return (currentPrice - averagePrice) * shares
    }
    var profitLossPercent: Double {
        guard averagePrice > 0 else { return 0 }
        return ((currentPrice - averagePrice) / averagePrice) * 100
    }
}

extension UserPortfolio {
    static let mockPortfolio = UserPortfolio(
        holdings: [
            Holding(symbol: "AAPL", shares: 10, averagePrice: 170.00, currentPrice: 178.50),
            Holding(symbol: "GOOGL", shares: 5, averagePrice: 140.00, currentPrice: 145.20),
            Holding(symbol: "TSLA", shares: 3, averagePrice: 250.00, currentPrice: 235.60)
        ],
        cashBalance: 5000.00
    )
}
