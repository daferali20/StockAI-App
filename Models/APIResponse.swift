import Foundation

// MARK: - Stock API Response
struct StockAPIResponse: Codable {
    let symbol: String
    let name: String
    let price: Double
    let change: Double
    let changePercent: Double
    let volume: Int
    let marketCap: Int64
    let lastUpdated: String
}

struct StockListResponse: Codable {
    let stocks: [StockAPIResponse]
    let lastUpdated: String
}

// MARK: - AI API Response
struct AIAnalysisResponse: Codable {
    let symbol: String
    let signal: String
    let confidence: Double
    let summary: String
    let keyPoints: [String]
    let riskLevel: String
    let targetPrice: Double?
    let stopLoss: Double?
    let timestamp: String
}

// MARK: - Error Response
struct APIErrorResponse: Codable {
    let code: Int
    let message: String
    let details: String?
}

// MARK: - Historical Data
struct HistoricalDataResponse: Codable {
    let symbol: String
    let data: [HistoricalPrice]
}

struct HistoricalPrice: Codable, Identifiable {
    let id = UUID()
    let date: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Int
}
