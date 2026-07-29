import Foundation

struct AIInsight: Identifiable, Codable {
    let id = UUID()
    let symbol: String
    let signal: TradeSignal
    let confidence: Double // 0.0 - 1.0
    let summary: String
    let keyPoints: [String]
    let riskLevel: RiskLevel
    let targetPrice: Double?
    let stopLoss: Double?
    let timestamp: Date
    
    enum TradeSignal: String, Codable {
        case strongBuy = "شراء قوي"
        case buy = "شراء"
        case hold = "انتظار"
        case sell = "بيع"
        case strongSell = "بيع قوي"
        
        var color: String {
            switch self {
            case .strongBuy: return "green"
            case .buy: return "lightGreen"
            case .hold: return "yellow"
            case .sell: return "orange"
            case .strongSell: return "red"
            }
        }
        
        var icon: String {
            switch self {
            case .strongBuy: return "arrow.up.circle.fill"
            case .buy: return "arrow.up.circle"
            case .hold: return "hand.raised.circle"
            case .sell: return "arrow.down.circle"
            case .strongSell: return "arrow.down.circle.fill"
            }
        }
    }
    
    enum RiskLevel: String, Codable {
        case low = "منخفض"
        case medium = "متوسط"
        case high = "مرتفع"
        
        var color: String {
            switch self {
            case .low: return "green"
            case .medium: return "yellow"
            case .high: return "red"
            }
        }
    }
}

extension AIInsight {
    static let mockInsight = AIInsight(
        symbol: "AAPL",
        signal: .strongBuy,
        confidence: 0.85,
        summary: "أبل تظهر إشارات شراء قوية مع تحسن في المؤشرات الفنية والأساسية",
        keyPoints: [
            "نمو قوي في الإيرادات الفصلية",
            "مؤشرات فنية إيجابية",
            "توسع في خدمات الاشتراك"
        ],
        riskLevel: .medium,
        targetPrice: 195.00,
        stopLoss: 165.00,
        timestamp: Date()
    )
}
