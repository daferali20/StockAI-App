import Foundation

struct Stock: Identifiable, Codable {
    let id = UUID()
    let symbol: String
    let name: String
    let price: Double
    let change: Double
    let changePercent: Double
    let volume: Int
    let marketCap: Int64
    let lastUpdated: Date
    
    var isPositive: Bool {
        return change >= 0
    }
    
    var formattedPrice: String {
        return String(format: "$%.2f", price)
    }
    
    var formattedChange: String {
        return String(format: "%.2f", change)
    }
    
    var formattedChangePercent: String {
        return String(format: "%.2f%%", changePercent)
    }
}

extension Stock {
    static let mockStock = Stock(
        symbol: "AAPL",
        name: "Apple Inc.",
        price: 178.50,
        change: 2.30,
        changePercent: 1.31,
        volume: 52345678,
        marketCap: 2800000000000,
        lastUpdated: Date()
    )
}
