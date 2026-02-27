//
//  MarketLogger.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import Foundation

final class MarketLogger {
    static let shared = MarketLogger()
    private let tag = "LiveMarketSocketClient"

    private init() {}

    func info(_ text: String) {
#if DEBUG
        print("[\(tag)] \(text)")
#endif
    }
}
