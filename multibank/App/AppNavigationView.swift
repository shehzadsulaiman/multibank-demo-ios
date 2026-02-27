//
//  AppNavigationView.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import SwiftUI

struct AppNavigationView: View {
    @State private var goToMarket = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Spacer()

                Text("Welcome")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)

                Text("This view is to showcase skill for app navigation.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                List {
                    NavigationLink("enter from swift ui list - shehzads live demo market place") {
                        MarketView()
                    }
                }
                .listStyle(.insetGrouped)
                .frame(maxWidth: .infinity, maxHeight: 200)

                Button {
                    goToMarket = true
                } label: {
                    Text("enter via button click")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.9))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)

                NavigationLink(destination: MarketView()) {
                    Text("enter from navigation link - show case button navigation")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor.opacity(0.85))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationDestination(isPresented: $goToMarket) {
                MarketView()
            }
            .navigationTitle("multibank")
        }
    }
}

#Preview {
    AppNavigationView()
}
