import Foundation

enum APIEndpoints {
    // MARK: - Stock Endpoints
    struct FetchStocks: APIEndpoint {
        let path = "/stocks"
        let method: HTTPMethod = .get
        
        let symbols: [String]?
        
        var queryItems: [URLQueryItem]? {
            guard let symbols = symbols, !symbols.isEmpty else { return nil }
            return [URLQueryItem(name: "symbols", value: symbols.joined(separator: ","))]
        }
    }
    
    struct FetchStockDetails: APIEndpoint {
        let path: String
        let method: HTTPMethod = .get
        
        init(symbol: String) {
            self.path = "/stocks/\(symbol)"
        }
    }
    
    struct FetchHistoricalData: APIEndpoint {
        let path: String
        let method: HTTPMethod = .get
        
        init(symbol: String, period: String) {
            self.path = "/stocks/\(symbol)/history?period=\(period)"
        }
    }
    
    // MARK: - AI Endpoints
    struct AnalyzeStock: APIEndpoint {
        let path = "/ai/analyze"
        let method: HTTPMethod = .post
        
        let symbol: String
        let includeNews: Bool
        
        var body: Data? {
            let params: [String: Any] = [
                "symbol": symbol,
                "includeNews": includeNews
            ]
            return try? JSONSerialization.data(withJSONObject: params)
        }
    }
    
    struct BatchAnalysis: APIEndpoint {
        let path = "/ai/batch-analyze"
        let method: HTTPMethod = .post
        
        let symbols: [String]
        
        var body: Data? {
            let params: [String: Any] = ["symbols": symbols]
            return try? JSONSerialization.data(withJSONObject: params)
        }
    }
}
