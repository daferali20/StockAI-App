import Foundation
import Combine

class MarketViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var lastUpdated: Date? = nil
    
    private let stockAPI = StockAPI()
    private var cancellables = Set<AnyCancellable>()
    private var refreshTimer: Timer?
    
    init() {
        fetchMarketData()
        startAutoRefresh()
    }
    
    deinit {
        refreshTimer?.invalidate()
    }
    
    func fetchMarketData() {
        isLoading = true
        errorMessage = nil
        
        stockAPI.fetchStocks()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] stocks in
                self?.stocks = stocks
                self?.lastUpdated = Date()
            }
            .store(in: &cancellables)
    }
    
    func refreshData() {
        fetchMarketData()
    }
    
    func startAutoRefresh() {
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.fetchMarketData()
        }
    }
    
    func stopAutoRefresh() {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }
    
    func getStock(by symbol: String) -> Stock? {
        return stocks.first { $0.symbol == symbol }
    }
}
