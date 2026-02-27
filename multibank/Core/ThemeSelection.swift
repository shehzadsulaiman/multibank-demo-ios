//
//  ThemeSelection.swift
//  multibank
//
//  Created by shehzad on 27/02/2026.
//

import Foundation
import Combine

final class ThemeSelection: ObservableObject {
    private enum Keys {
        static let isDarkMode = "isDarkMode"
    }

    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: Keys.isDarkMode)
        }
    }

    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: Keys.isDarkMode)
    }
}

