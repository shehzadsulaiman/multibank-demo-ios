//
//  MarketViewModel.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import Foundation
import Combine

@MainActor
final class MarketViewModel: ObservableObject {
    @Published private(set) var state = MarketViewState()
    private var timerCancellable: AnyCancellable?

    init() {
        loadInitialQuotes()
    }

    func start() {
        guard !state.isFeedRunning else { return }
        state.isFeedRunning = true
        state.isConnected = true
        startSimulationTimer()
    }

    func stop() {
        state.isFeedRunning = false
        state.isConnected = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    func toggleFeed() {
        state.isFeedRunning ? stop() : start()
    }

    private func loadInitialQuotes() {
        // data for ui live loading
        state.quotes = [
            .init(id: "NVDA", symbol: "NVDA", companyName: "NVIDIA", price: 934.20, change: 14.2, changePercent: 1.54, updatedAt: Date()),
            .init(id: "AAPL", symbol: "AAPL", companyName: "Apple", price: 212.33, change: -1.7, changePercent: -0.79, updatedAt: Date()),
            .init(id: "GOOG", symbol: "GOOG", companyName: "Alphabet", price: 178.91, change: 0.9, changePercent: 0.50, updatedAt: Date()),
            .init(id: "AMZN", symbol: "AMZN", companyName: "Amazon", price: 196.42, change: -0.6, changePercent: -0.30, updatedAt: Date()),
            .init(id: "MSFT", symbol: "MSFT", companyName: "Microsoft", price: 428.10, change: 2.1, changePercent: 0.49, updatedAt: Date()),
            .init(id: "META", symbol: "META", companyName: "Meta Platforms", price: 501.23, change: -3.2, changePercent: -0.63, updatedAt: Date()),
            .init(id: "TSLA", symbol: "TSLA", companyName: "Tesla", price: 198.77, change: 1.1, changePercent: 0.56, updatedAt: Date()),
            .init(id: "NFLX", symbol: "NFLX", companyName: "Netflix", price: 612.44, change: 4.6, changePercent: 0.76, updatedAt: Date()),
            .init(id: "AMD", symbol: "AMD", companyName: "Advanced Micro Devices", price: 176.35, change: -0.9, changePercent: -0.51, updatedAt: Date()),
            .init(id: "AVGO", symbol: "AVGO", companyName: "Broadcom", price: 1388.66, change: 8.2, changePercent: 0.59, updatedAt: Date()),
            .init(id: "ADBE", symbol: "ADBE", companyName: "Adobe", price: 512.03, change: -2.4, changePercent: -0.47, updatedAt: Date()),
            .init(id: "CRM", symbol: "CRM", companyName: "Salesforce", price: 302.18, change: 1.5, changePercent: 0.50, updatedAt: Date()),
            .init(id: "ORCL", symbol: "ORCL", companyName: "Oracle", price: 126.55, change: 0.4, changePercent: 0.32, updatedAt: Date()),
            .init(id: "INTC", symbol: "INTC", companyName: "Intel", price: 42.91, change: -0.2, changePercent: -0.47, updatedAt: Date()),
            .init(id: "CSCO", symbol: "CSCO", companyName: "Cisco Systems", price: 50.73, change: 0.1, changePercent: 0.20, updatedAt: Date()),
            .init(id: "QCOM", symbol: "QCOM", companyName: "Qualcomm", price: 170.84, change: 0.8, changePercent: 0.47, updatedAt: Date()),
            .init(id: "SHOP", symbol: "SHOP", companyName: "Shopify", price: 78.11, change: -0.5, changePercent: -0.64, updatedAt: Date()),
            .init(id: "UBER", symbol: "UBER", companyName: "Uber", price: 74.92, change: 0.6, changePercent: 0.81, updatedAt: Date()),
            .init(id: "ABNB", symbol: "ABNB", companyName: "Airbnb", price: 153.27, change: 1.0, changePercent: 0.66, updatedAt: Date()),
            .init(id: "PYPL", symbol: "PYPL", companyName: "PayPal", price: 60.44, change: -0.3, changePercent: -0.49, updatedAt: Date()),
            .init(id: "SQ", symbol: "SQ", companyName: "Block", price: 79.33, change: 0.7, changePercent: 0.89, updatedAt: Date()),
            .init(id: "NVAX", symbol: "NVAX", companyName: "Novavax", price: 5.92, change: -0.1, changePercent: -1.66, updatedAt: Date()),
            .init(id: "BA", symbol: "BA", companyName: "Boeing", price: 182.71, change: -1.2, changePercent: -0.65, updatedAt: Date()),
            .init(id: "KO", symbol: "KO", companyName: "Coca-Cola", price: 59.88, change: 0.2, changePercent: 0.34, updatedAt: Date()),
            .init(id: "PEP", symbol: "PEP", companyName: "PepsiCo", price: 170.12, change: 0.5, changePercent: 0.29, updatedAt: Date())
        ]
    }

    private func startSimulationTimer() {
        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.simulateTickBatch()
            }
    }

    private func simulateTickBatch() {
        let now = Date()

        state.quotes = state.quotes.map { quote in
            let movePercent = Double.random(in: -1.25...1.25)
            let delta = quote.price * (movePercent / 100)
            let newPrice = max(0.01, quote.price + delta)

            return StockQuote(
                id: quote.id,
                symbol: quote.symbol,
                companyName: quote.companyName,
                price: newPrice,
                change: delta,
                changePercent: movePercent,
                updatedAt: now
            )
        }
    }
}
