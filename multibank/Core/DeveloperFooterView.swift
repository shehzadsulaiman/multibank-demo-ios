//
//  DeveloperFooterView.swift
//  multibank
//
//  Created by shehzad on 27/02/2026.
//

import SwiftUI

struct DeveloperFooterView: View {
    private let linkedInURL = URL(string: "https://ae.linkedin.com/in/shehzad-sulaiman-8a657815b")!
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var themeSelection: ThemeSelection

    var body: some View {
        VStack(spacing: 12) {
            Toggle(isOn: $themeSelection.isDarkMode) {
                HStack(spacing: 6) {
                    Image(systemName: themeSelection.isDarkMode ? "moon.fill" : "sun.max.fill")
                        .foregroundStyle(MarketTheme.secondaryText(for: colorScheme))
                    Text("Theme: " + (themeSelection.isDarkMode ? "Dark" : "Light"))
                        .font(.footnote)
                        .foregroundStyle(MarketTheme.secondaryText(for: colorScheme))
                }
            }
            .toggleStyle(.switch)
            Divider()
            Link(destination: linkedInURL) {
                Text("developed by shehzadsulaiman")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(MarketTheme.footerLink(for: colorScheme))
                    .underline()
            }
    
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
