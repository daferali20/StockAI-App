import Foundation

class APIService {
    private let baseURL = "http://localhost:3000/api"
    private let session = URLSession.shared
    
    func fetchStockData(symbol: String) async throws -> StockData {
        guard let url = URL(string: "\(baseURL)/stock/\(symbol)") else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await session.data(from: url)
        let stockData = try JSONDecoder().decode(StockData.self, from: data)
        return stockData
    }
    
    func getAIAnalysis(symbol: String, data: [String: Any]) async throws -> AIAnalysis {
        guard let url = URL(string: "\(baseURL)/ai/analyze") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "symbol": symbol,
            "data": data
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await session.data(for: request)
        let analysis = try JSONDecoder().decode(AIAnalysis.self, from: data)
        return analysis
    }
}

struct StockData: Codable {
    let symbol: String
    let price: Double
    let change: Double
    let volume: Int
}

struct AIAnalysis: Codable {
    let symbol: String
    let analysis: String
    let timestamp: String
}

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
}
