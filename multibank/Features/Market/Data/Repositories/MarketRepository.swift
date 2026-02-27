//
//  MarketRepository.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import Foundation
import Combine

protocol MarketRepository {
    var tickStream: AnyPublisher<MarketTick, Never> { get }
    func connect()
    func disconnect()
    func send(tick: MarketTick)
}

final class MarketRepositoryImpl: MarketRepository {
    private let socketClient: MarketSocketClient
    var tickStream: AnyPublisher<MarketTick, Never> { socketClient.tickStream }

    init(socketClient: MarketSocketClient = LiveMarketSocketClient()) {
        self.socketClient = socketClient
    }

    func connect() {
        socketClient.connect()
    }

    func disconnect() {
        socketClient.disconnect()
    }

    func send(tick: MarketTick) {
        socketClient.send(tick: tick)
    }
}
