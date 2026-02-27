//
//  SymbolDetailsView.swift
//  multibank
//
//  Created by shehzad on 27/02/2026.
//

import SwiftUI

struct SymbolDetailsView: View {
    let symbol: String
    @EnvironmentObject private var viewModel: MarketViewModel
    @Environment(\.colorScheme) private var colorScheme

    private var quote: StockQuote? {
        viewModel.state.quotes.first(where: { $0.symbol == symbol })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(symbol)
                .font(.largeTitle.bold())
                .foregroundStyle(MarketTheme.primaryText(for: colorScheme))

            if let quote {
                HStack(spacing: 8) {
                    Text("$\(quote.formattedPrice)")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(MarketTheme.primaryText(for: colorScheme))

                    Text(changeLabel(for: quote))
                        .font(.headline)
                        .foregroundStyle(changeColor(for: quote))
                }

                Text(descriptionText(for: quote.symbol))
                    .font(.body)
                    .foregroundStyle(MarketTheme.secondaryText(for: colorScheme))
            } else {
                Text("loading symbol details...")
                    .font(.body)
                    .foregroundStyle(MarketTheme.secondaryText(for: colorScheme))
            }

            Spacer()
        }
        .padding()
        .background(MarketTheme.screenBackground(for: colorScheme))
        .navigationTitle(symbol)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            DeveloperFooterView()
        }
    }

    private func changeLabel(for quote: StockQuote) -> String {
        let arrow = quote.change >= 0 ? "↑" : "↓"
        return "\(arrow) \(String(format: "%.2f", abs(quote.changePercent)))%"
    }

    private func changeColor(for quote: StockQuote) -> Color {
        quote.change >= 0 ? .green : .red
    }

    private func descriptionText(for symbol: String) -> String {
        "\(symbol) is one of the tracked symbols in this live market demo, with simulated and websocket-driven price updates."
    }
}

#Preview {
    NavigationStack {
        SymbolDetailsView(symbol: "NVDA")
            .environmentObject(MarketViewModel())
            .environmentObject(ThemeSelection())
    }
}
