import Foundation
import Combine

class StockAPI {
    private let client = APIClient.shared
    
    func fetchStocks() -> AnyPublisher<[Stock], Error> {
        let endpoint = APIEndpoints.FetchStocks(symbols: nil)
        
        return client.request(endpoint)
            .map { (response: StockListResponse) -> [Stock] in
                return response.stocks.map { stockResponse in
                    Stock(
                        symbol: stockResponse.symbol,
                        name: stockResponse.name,
                        price: stockResponse.price,
                        change: stockResponse.change,
                        changePercent: stockResponse.changePercent,
                        volume: stockResponse.volume,
                        marketCap: stockResponse.marketCap,
                        lastUpdated: Date()
                    )
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchStocks(for symbols: [String]) -> AnyPublisher<[Stock], Error> {
        let endpoint = APIEndpoints.FetchStocks(symbols: symbols)
        
        return client.request(endpoint)
            .map { (response: StockListResponse) -> [Stock] in
                return response.stocks.map { stockResponse in
                    Stock(
                        symbol: stockResponse.symbol,
                        name: stockResponse.name,
                        price: stockResponse.price,
                        change: stockResponse.change,
                        changePercent: stockResponse.changePercent,
                        volume: stockResponse.volume,
                        marketCap: stockResponse.marketCap,
                        lastUpdated: Date()
                    )
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchHistoricalData(symbol: String, period: String = "1m") -> AnyPublisher<[HistoricalPrice], Error> {
        let endpoint = APIEndpoints.FetchHistoricalData(symbol: symbol, period: period)
        
        return client.request(endpoint)
            .map { (response: HistoricalDataResponse) -> [HistoricalPrice] in
                return response.data
            }
            .eraseToAnyPublisher()
    }
}
