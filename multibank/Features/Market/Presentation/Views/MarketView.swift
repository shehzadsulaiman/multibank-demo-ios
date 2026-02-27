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
                HStack(spacing: 6) {
                    Circle()
                        .fill(viewModel.state.isConnected ? .green : .red)
                        .frame(width: 10, height: 10)
                    Text(viewModel.state.isConnected ? "connected" : "disconnected")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button(viewModel.state.isFeedRunning ? "stop" : "start") {
                    viewModel.toggleFeed()
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(viewModel.state.isFeedRunning ? .red : .green)
                .clipShape(Capsule())
            }
            .padding(.horizontal)

            // quote list
            List(viewModel.state.sortedQuotes) { quote in
                NavigationLink(value: quote) {
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
            }
            .listStyle(.plain)
        }
        .navigationTitle("shehzad's live market demo")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: StockQuote.self) { quote in
            SymbolDetailsView(quote: quote)
        }
        .safeAreaInset(edge: .bottom) {
            DeveloperFooterView()
        }
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
