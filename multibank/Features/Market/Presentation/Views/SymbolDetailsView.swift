//
//  SymbolDetailsView.swift
//  multibank
//
//  Created by shehzad on 27/02/2026.
//

import SwiftUI

struct SymbolDetailsView: View {
    let quote: StockQuote

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(quote.symbol)
                .font(.largeTitle.bold())

            HStack(spacing: 8) {
                Text("$\(quote.formattedPrice)")
                    .font(.title2.weight(.semibold))

                Text(changeLabel(for: quote))
                    .font(.headline)
                    .foregroundStyle(changeColor(for: quote))
            }

            Text(descriptionText(for: quote.symbol))
                .font(.body)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding()
        .navigationTitle(quote.symbol)
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
        SymbolDetailsView(
            quote: StockQuote(
                id: "NVDA",
                symbol: "NVDA",
                companyName: "NVIDIA",
                price: 900.00,
                change: 10.0,
                changePercent: 1.12,
                updatedAt: .now
            )
        )
    }
}
