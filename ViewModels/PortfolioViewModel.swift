import Foundation
import Combine

class PortfolioViewModel: ObservableObject {
    @Published var portfolio: UserPortfolio
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let dataPersistence = DataPersistence.shared
    private let stockAPI = StockAPI()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.portfolio = dataPersistence.loadPortfolio() ?? UserPortfolio.mockPortfolio
        updatePrices()
    }
    
    func updatePrices() {
        isLoading = true
        
        let symbols = portfolio.holdings.map { $0.symbol }
        guard !symbols.isEmpty else {
            isLoading = false
            return
        }
        
        stockAPI.fetchStocks(for: symbols)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] stocks in
                self?.updateHoldingsPrices(with: stocks)
                self?.savePortfolio()
            }
            .store(in: &cancellables)
    }
    
    private func updateHoldingsPrices(with stocks: [Stock]) {
        for (index, holding) in portfolio.holdings.enumerated() {
            if let stock = stocks.first(where: { $0.symbol == holding.symbol }) {
                portfolio.holdings[index].currentPrice = stock.price
            }
        }
    }
    
    func addHolding(symbol: String, shares: Double, averagePrice: Double) {
        let holding = Holding(symbol: symbol, shares: shares, averagePrice: averagePrice, currentPrice: averagePrice)
        portfolio.holdings.append(holding)
        savePortfolio()
        updatePrices()
    }
    
    func removeHolding(at index: Int) {
        guard index < portfolio.holdings.count else { return }
        portfolio.holdings.remove(at: index)
        savePortfolio()
    }
    
    func savePortfolio() {
        dataPersistence.savePortfolio(portfolio)
    }
}
