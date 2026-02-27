//
//  AppNavigationView.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import SwiftUI

struct AppNavigationView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("shehzads demo marketplace") {
                    MarketView()
                }
            }
            .navigationTitle("multibank")
        }
    }
}

#Preview {
    AppNavigationView()
}
