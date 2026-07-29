import Foundation

class DataPersistence {
    static let shared = DataPersistence()
    private let userDefaults = UserDefaults.standard
    
    private enum Keys {
        static let portfolio = "portfolio_data"
        static let alerts = "alerts_data"
    }
    
    private init() {}
    
    // MARK: - Portfolio
    func savePortfolio(_ portfolio: UserPortfolio) {
        do {
            let data = try JSONEncoder().encode(portfolio)
            userDefaults.set(data, forKey: Keys.portfolio)
        } catch {
            print("Failed to save portfolio: \(error)")
        }
    }
    
    func loadPortfolio() -> UserPortfolio? {
        guard let data = userDefaults.data(forKey: Keys.portfolio) else { return nil }
        
        do {
            return try JSONDecoder().decode(UserPortfolio.self, from: data)
        } catch {
            print("Failed to load portfolio: \(error)")
            return nil
        }
    }
    
    // MARK: - Alerts
    func saveAlerts(_ alerts: [Alert]) {
        do {
            let data = try JSONEncoder().encode(alerts)
            userDefaults.set(data, forKey: Keys.alerts)
        } catch {
            print("Failed to save alerts: \(error)")
        }
    }
    
    func loadAlerts() -> [Alert]? {
        guard let data = userDefaults.data(forKey: Keys.alerts) else { return nil }
        
        do {
            return try JSONDecoder().decode([Alert].self, from: data)
        } catch {
            print("Failed to load alerts: \(error)")
            return nil
        }
    }
    
    // MARK: - Clear Data
    func clearAllData() {
        userDefaults.removeObject(forKey: Keys.portfolio)
        userDefaults.removeObject(forKey: Keys.alerts)
    }
}
