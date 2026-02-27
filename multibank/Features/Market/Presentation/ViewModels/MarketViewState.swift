//
//  MarketViewState.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import Foundation

struct MarketViewState: Equatable {
    var quotes: [StockQuote] = []
    var isConnected = false
    var isFeedRunning = false

    var sortedQuotes: [StockQuote] {
        quotes.sorted { $0.price > $1.price }
    }
}
