import Foundation
import Combine

class AIAPI {
    private let client = APIClient.shared
    
    func analyzeStock(symbol: String) -> AnyPublisher<AIInsight, Error> {
        let endpoint = APIEndpoints.AnalyzeStock(symbol: symbol, includeNews: true)
        
        return client.request(endpoint)
            .map { (response: AIAnalysisResponse) -> AIInsight in
                return AIInsight(
                    symbol: response.symbol,
                    signal: AIInsight.TradeSignal(rawValue: response.signal) ?? .hold,
                    confidence: response.confidence,
                    summary: response.summary,
                    keyPoints: response.keyPoints,
                    riskLevel: AIInsight.RiskLevel(rawValue: response.riskLevel) ?? .medium,
                    targetPrice: response.targetPrice,
                    stopLoss: response.stopLoss,
                    timestamp: Date()
                )
            }
            .eraseToAnyPublisher()
    }
}
