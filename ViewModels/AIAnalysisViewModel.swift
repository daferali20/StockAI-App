import Foundation
import Combine

class AIAnalysisViewModel: ObservableObject {
    @Published var insights: [String: AIInsight] = [:]
    @Published var selectedSymbol: String?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let aiAPI = AIAPI()
    private var cancellables = Set<AnyCancellable>()
    
    func analyzeStock(symbol: String) {
        guard !symbol.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        selectedSymbol = symbol
        
        aiAPI.analyzeStock(symbol: symbol)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] insight in
                self?.insights[symbol] = insight
            }
            .store(in: &cancellables)
    }
    
    func getInsight(for symbol: String) -> AIInsight? {
        return insights[symbol]
    }
    
    func getCurrentInsight() -> AIInsight? {
        guard let symbol = selectedSymbol else { return nil }
        return insights[symbol]
    }
}
