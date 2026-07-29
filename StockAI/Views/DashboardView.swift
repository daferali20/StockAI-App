import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: StockViewModel
    @State private var selectedSymbol: String?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    HeaderView()
                    
                    // Market Overview
                    MarketOverviewView()
                    
                    // Top Movers
                    TopMoversView(stocks: viewModel.topMovers)
                    
                    // AI Recommendations
                    AIRecommendationsView(recommendations: viewModel.recommendations)
                    
                    // Watchlist
                    WatchlistView(stocks: viewModel.watchlist)
                }
                .padding()
            }
            .navigationTitle("StockAI")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await viewModel.refreshData()
            }
            .sheet(item: $selectedSymbol) { symbol in
                StockDetailView(symbol: symbol, viewModel: viewModel)
            }
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good Morning")
                    .font(.title2)
                    .fontWeight(.medium)
                Text("Ready to invest?")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "bell.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical)
    }
}

struct MarketOverviewView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Market Overview")
                .font(.headline)
            
            HStack(spacing: 15) {
                MarketCard(title: "S&P 500", value: "5,432.10", change: "+0.8%")
                MarketCard(title: "NASDAQ", value: "18,765.43", change: "+1.2%")
                MarketCard(title: "DOW", value: "39,876.54", change: "+0.5%")
            }
        }
    }
}

struct MarketCard: View {
    let title: String
    let value: String
    let change: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
            Text(change)
                .font(.caption)
                .foregroundColor(.green)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct TopMoversView: View {
    let stocks: [Stock]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Movers")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(stocks, id: \.symbol) { stock in
                        StockCard(stock: stock)
                    }
                }
            }
        }
    }
}

struct StockCard: View {
    let stock: Stock
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stock.symbol)
                .font(.headline)
            Text(stock.name)
                .font(.caption)
                .foregroundColor(.secondary)
            Text("$\(stock.price, specifier: "%.2f")")
                .font(.title3)
                .fontWeight(.bold)
            Text("\(stock.change >= 0 ? "+" : "")\(stock.change, specifier: "%.2f")%")
                .font(.caption)
                .foregroundColor(stock.change >= 0 ? .green : .red)
        }
        .padding()
        .frame(width: 150)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct AIRecommendationsView: View {
    let recommendations: [Recommendation]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("AI Recommendations")
                    .font(.headline)
                Image(systemName: "sparkles")
                    .foregroundColor(.blue)
            }
            
            ForEach(recommendations.prefix(3), id: \.symbol) { rec in
                RecommendationCard(recommendation: rec)
            }
        }
    }
}

struct RecommendationCard: View {
    let recommendation: Recommendation
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recommendation.symbol)
                    .font(.headline)
                Text(recommendation.action)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text("Confidence: \(recommendation.confidence)%")
                .font(.caption)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

struct WatchlistView: View {
    let stocks: [Stock]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Watchlist")
                .font(.headline)
            
            ForEach(stocks.prefix(5), id: \.symbol) { stock in
                HStack {
                    VStack(alignment: .leading) {
                        Text(stock.symbol)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(stock.name)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("$\(stock.price, specifier: "%.2f")")
                            .font(.subheadline)
                        Text("\(stock.change >= 0 ? "+" : "")\(stock.change, specifier: "%.2f")%")
                            .font(.caption)
                            .foregroundColor(stock.change >= 0 ? .green : .red)
                    }
                }
                .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    DashboardView(viewModel: StockViewModel())
}
