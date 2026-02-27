//
//  multibankTests.swift
//  multibankTests
//
//  Created by shehzad on 26/02/2026.
//

import Foundation
import Testing
@testable import multibank

struct multibankTests {

    @Test func marketViewStateSortsByHighestPriceFirst() {
        var state = MarketViewState()
        state.quotes = [
            StockQuote(id: "A", symbol: "A", companyName: "A Inc", price: 10, change: 0, changePercent: 0, updatedAt: .now),
            StockQuote(id: "B", symbol: "B", companyName: "B Inc", price: 30, change: 0, changePercent: 0, updatedAt: .now),
            StockQuote(id: "C", symbol: "C", companyName: "C Inc", price: 20, change: 0, changePercent: 0, updatedAt: .now)
        ]

        let prices = state.sortedQuotes.map(\.price)
        #expect(prices == [30, 20, 10])
    }

    @MainActor
    @Test func marketViewModelStartStopUpdatesConnectionState() {
        let demoClient = DemoMarketSocketClient()
        let repository = MarketRepositoryImpl(socketClient: demoClient)
        let viewModel = MarketViewModel(repository: repository)

        viewModel.start()
        #expect(viewModel.state.isFeedRunning == true)
        #expect(viewModel.state.isConnected == true)

        viewModel.stop()
        #expect(viewModel.state.isFeedRunning == false)
        #expect(viewModel.state.isConnected == false)
    }

    @MainActor
    @Test func marketViewModelAppliesIncomingTickToMatchingSymbol() async throws {
        let demoClient = DemoMarketSocketClient()
        let repository = MarketRepositoryImpl(socketClient: demoClient)
        let viewModel = MarketViewModel(repository: repository)

        viewModel.start()
        demoClient.send(tick: MarketTick(symbol: "AAPL", price: 300.00, timestamp: .now))

        try await Task.sleep(for: .milliseconds(100))

        let updated = viewModel.state.quotes.first(where: { $0.symbol == "AAPL" })
        #expect(updated != nil)
        #expect(updated?.price == 300.00)
        #expect(updated?.change != 0)
        #expect(updated?.changePercent != 0)

        viewModel.stop()
    }
}
