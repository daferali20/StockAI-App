import Foundation

struct Formatters {
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    static let percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    static let volumeFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    static let marketCapFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ar_SA")
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ar_SA")
        return formatter
    }()
    
    // MARK: - Formatting Functions
    static func formatPrice(_ price: Double) -> String {
        return priceFormatter.string(from: NSNumber(value: price)) ?? "$\(price)"
    }
    
    static func formatPercent(_ percent: Double) -> String {
        return percentFormatter.string(from: NSNumber(value: percent / 100)) ?? "\(percent)%"
    }
    
    static func formatVolume(_ volume: Int) -> String {
        if volume >= 1_000_000 {
            return "\(String(format: "%.1f", Double(volume) / 1_000_000))M"
        } else if volume >= 1_000 {
            return "\(String(format: "%.1f", Double(volume) / 1_000))K"
        }
        return "\(volume)"
    }
    
    static func formatMarketCap(_ marketCap: Int64) -> String {
        if marketCap >= 1_000_000_000_000 {
            return "\(String(format: "%.1f", Double(marketCap) / 1_000_000_000_000))T"
        } else if marketCap >= 1_000_000_000 {
            return "\(String(format: "%.1f", Double(marketCap) / 1_000_000_000))B"
        } else if marketCap >= 1_000_000 {
            return "\(String(format: "%.1f", Double(marketCap) / 1_000_000))M"
        }
        return "\(marketCap)"
    }
}
