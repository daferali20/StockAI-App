import Foundation
import Combine

class AlertViewModel: ObservableObject {
    @Published var alerts: [Alert] = []
    @Published var isNotificationAuthorized: Bool = false
    
    private let notificationManager = NotificationManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        checkNotificationAuthorization()
    }
    
    func checkNotificationAuthorization() {
        notificationManager.requestAuthorization { [weak self] granted in
            DispatchQueue.main.async {
                self?.isNotificationAuthorized = granted
            }
        }
    }
    
    func addAlert(symbol: String, targetPrice: Double, condition: AlertCondition) {
        let alert = Alert(
            id: UUID(),
            symbol: symbol,
            targetPrice: targetPrice,
            condition: condition,
            isActive: true,
            createdAt: Date()
        )
        alerts.append(alert)
        scheduleAlert(alert)
    }
    
    func removeAlert(at index: Int) {
        guard index < alerts.count else { return }
        let alert = alerts[index]
        alerts.remove(at: index)
        notificationManager.cancelNotification(for: alert.id.uuidString)
    }
    
    func toggleAlert(at index: Int) {
        guard index < alerts.count else { return }
        alerts[index].isActive.toggle()
        
        if alerts[index].isActive {
            scheduleAlert(alerts[index])
        } else {
            notificationManager.cancelNotification(for: alerts[index].id.uuidString)
        }
    }
    
    private func scheduleAlert(_ alert: Alert) {
        let title = "تنبيه سهم \(alert.symbol)"
        let body = "السهم \(alert.symbol) \(alert.condition.rawValue) \(alert.targetPrice)"
        
        notificationManager.scheduleNotification(
            id: alert.id.uuidString,
            title: title,
            body: body,
            timeInterval: 10 // For testing, replace with actual logic
        )
    }
}

struct Alert: Identifiable {
    let id: UUID
    let symbol: String
    let targetPrice: Double
    let condition: AlertCondition
    var isActive: Bool
    let createdAt: Date
}

enum AlertCondition: String {
    case above = "تجاوز"
    case below = "انخفض عن"
    
    func check(price: Double, target: Double) -> Bool {
        switch self {
        case .above: return price >= target
        case .below: return price <= target
        }
    }
}
