//
//  AppNavigationView.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import SwiftUI

struct AppNavigationView: View {
    @StateObject private var viewModel = MarketViewModel()

    var body: some View {
        NavigationStack {
            MarketView()
        }
        .environmentObject(viewModel)
        .onAppear {
            viewModel.start()
        }
        .onDisappear {
            viewModel.stop()
        }
    }
}

#Preview {
    AppNavigationView()
}
