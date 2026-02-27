//
//  multibankApp.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//


import SwiftUI

@main
struct multibankApp: App {
    @StateObject private var themeSelection = ThemeSelection()

    var body: some Scene {
        WindowGroup {
            AppNavigationView()
                .environmentObject(themeSelection)
                .preferredColorScheme(themeSelection.isDarkMode ? ColorScheme.dark : ColorScheme.light)
        }
    }
}
