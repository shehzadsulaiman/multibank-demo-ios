//
//  MarketView.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import SwiftUI

struct MarketView: View {
    @StateObject private var viewModel = MarketViewModel()

    var body: some View {
        VStack(spacing: 8) {
            // status header
            HStack {
                Spacer()
                HStack(spacing: 6) {
                    Circle()
                        .fill(viewModel.state.isConnected ? .green : .red)
                        .frame(width: 20, height: 20)
                    Text(viewModel.state.isConnected ? "connected" : "disconnected")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
            }

            // quote list
            List(viewModel.state.sortedQuotes) { quote in
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(quote.symbol)
                            .font(.headline)
                        Text(quote.companyName)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("$\(quote.formattedPrice)")
                            .font(.headline)
                        HStack(spacing: 6) {
                            Circle()
                                .fill(changeColor(for: quote))
                                .frame(width: 6, height: 6)
                            Text(changeLabel(for: quote))
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(changeColor(for: quote))
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("live market")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.start()
        }
        .onDisappear {
            viewModel.stop()
        }
    }

    private func changeLabel(for quote: StockQuote) -> String {
        let arrow = quote.change >= 0 ? "↑" : "↓"
        return "\(arrow) \(String(format: "%.2f", abs(quote.changePercent)))%"
    }

    private func changeColor(for quote: StockQuote) -> Color {
        quote.change >= 0 ? .green : .red
    }
}

#Preview {
    NavigationStack {
        MarketView()
    }
}
