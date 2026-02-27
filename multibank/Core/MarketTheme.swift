//
//  MarketTheme.swift
//  multibank
//
//  Created by shehzad on 27/02/2026.
//

import SwiftUI

enum MarketTheme {
    static func screenBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.black : Color(.systemGroupedBackground)
    }

    static func cardBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(.secondarySystemBackground) : .white
    }

    static func primaryText(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .white : .black
    }

    static func secondaryText(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(.lightGray) : Color(.darkGray)
    }

    static func footerLink(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(.systemTeal) : .blue
    }
}
