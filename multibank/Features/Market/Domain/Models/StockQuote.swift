//
//  StockQuote.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import Foundation

struct StockQuote: Identifiable, Equatable {
    let id: String
    let symbol: String
    let companyName: String
    let price: Double
    let change: Double
    let changePercent: Double
    let updatedAt: Date

    // string helper formatting to 0.00
    var formattedPrice: String {
        String(format: "%.2f", price)
    }
}
