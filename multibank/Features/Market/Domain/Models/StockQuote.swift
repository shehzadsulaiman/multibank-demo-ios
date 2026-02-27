import Foundation

struct StockQuote: Identifiable, Equatable {
    let id: String
    let symbol: String
    let companyName: String
    let price: Double
    let change: Double
    let changePercent: Double
    let updatedAt: Date

    // quick helper for simple ui formatting
    var formattedPrice: String {
        String(format: "%.2f", price)
    }
}
