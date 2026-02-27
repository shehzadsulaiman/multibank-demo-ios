//
//  MarketSocketClient.swift
//  multibank
//
//  Created by shehzad on 26/02/2026.
//

import Foundation
import Combine

protocol MarketSocketClient {
    var tickStream: AnyPublisher<MarketTick, Never> { get }
    func connect()
    func disconnect()
    func send(tick: MarketTick)
}

final class DemoMarketSocketClient: MarketSocketClient {
    private let subject = PassthroughSubject<MarketTick, Never>()
    var tickStream: AnyPublisher<MarketTick, Never> { subject.eraseToAnyPublisher() }

    func connect() {}
    func disconnect() {}

    func send(tick: MarketTick) {
        // dummy echo websocket client
        subject.send(tick)
    }
}

final class LiveMarketSocketClient: MarketSocketClient {
    private struct EchoTickPayload: Codable {
        let symbol: String
        let price: Double
        let timestamp: TimeInterval
    }

    private let subject = PassthroughSubject<MarketTick, Never>()
    private let logger = MarketLogger.shared
    private var task: URLSessionWebSocketTask?
    private var isConnected = false
    var tickStream: AnyPublisher<MarketTick, Never> { subject.eraseToAnyPublisher() }

    func connect() {
        guard !isConnected, let url = URL(string: "wss://ws.postman-echo.com/raw") else { return }
        logger.info("connect -> \(url.absoluteString)")
        let session = URLSession(configuration: .default)
        let newTask = session.webSocketTask(with: url)
        task = newTask
        isConnected = true
        newTask.resume()
        logger.info("connected")
        receiveNext()
    }

    func disconnect() {
        logger.info("disconnect requested")
        isConnected = false
        task?.cancel(with: .normalClosure, reason: nil)
        task = nil
        logger.info("disconnected")
    }

    func send(tick: MarketTick) {
        guard isConnected, let task else { return }
        let payload = EchoTickPayload(
            symbol: tick.symbol,
            price: tick.price,
            timestamp: tick.timestamp.timeIntervalSince1970
        )

        guard let data = try? JSONEncoder().encode(payload),
              let text = String(data: data, encoding: .utf8) else { return }

        logger.info("send json -> \(text)")
        task.send(.string(text)) { _ in }
    }

    private func receiveNext() {
        guard isConnected, let task else { return }

        task.receive { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let message):
                self.logger.info("raw response <- \(self.messageDebugText(message))")
                if let tick = self.mapMessageToTick(message) {
                    self.logger.info("decoded tick <- \(tick.symbol) \(tick.price)")
                    self.subject.send(tick)
                } else {
                    self.logger.info("decode failed for response")
                }
                self.receiveNext()
            case .failure:
                self.logger.info("receive failed, marking disconnected")
                self.isConnected = false
            }
        }
    }

    private func mapMessageToTick(_ message: URLSessionWebSocketTask.Message) -> MarketTick? {
        let data: Data?

        switch message {
        case .string(let text):
            data = text.data(using: .utf8)
        case .data(let binary):
            data = binary
        @unknown default:
            data = nil
        }

        guard let data,
              let payload = try? JSONDecoder().decode(EchoTickPayload.self, from: data) else {
            return nil
        }

        return MarketTick(
            symbol: payload.symbol,
            price: payload.price,
            timestamp: Date(timeIntervalSince1970: payload.timestamp)
        )
    }

    private func messageDebugText(_ message: URLSessionWebSocketTask.Message) -> String {
        switch message {
        case .string(let text):
            return text
        case .data(let binary):
            return String(data: binary, encoding: .utf8) ?? "<binary \(binary.count) bytes>"
        @unknown default:
            return "<unknown message>"
        }
    }
}
