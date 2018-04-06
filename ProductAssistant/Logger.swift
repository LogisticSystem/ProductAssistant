//
//  Logger.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 02.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

import CocoaLumberjack
import Starscream

final class Logger {
    
    // MARK: - Публичные свойства
    
    static var shared = Logger()
    
    
    // MARK: - Приватные свойства
    
    private let webSocket: WebSocket
    
    
    // MARK: - Инициализация
    
    private init() {
        guard let url = URL(string: "\(API.baseUrl)/socket") else { preconditionFailure() }
        self.webSocket = WebSocket(url: url)
        self.webSocket.delegate = self
    }
    
    
    // MARK: - Деинициализация
    
    deinit {
        self.webSocket.disconnect()
    }
    
}


// MARK: - Публичные свойства

extension Logger {
    
    /// Состояние подписки
    var isSubscribed: Bool {
        return self.webSocket.isConnected
    }
    
}


// MARK: - Публичные методы

extension Logger {
    
    /// Подписаться
    func subscribe() {
        self.webSocket.connect()
    }
    
    /// Отписаться
    func unsubscribe() {
        self.webSocket.disconnect()
    }
    
}


// MARK: - Приватные методы

private extension Logger {
    
    /// Проверка сообщения
    func prepareAction(_ action: String) -> [String] {
        let actionInfo = action.split(separator: "|").map { String($0) }
        return actionInfo
    }
    
    /// Проверка сообщения
    func checkAction(_ actionInfo: [String]) -> Bool {
        return actionInfo.contains(where: { $0 == "message" })
    }
    
    /// Отправить сообщение
    func sendData<T : Codable>(_ data: T, rabbit: Rabbit) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(data) else { return }
        
        RabbitsHolder.accessQueue.async {
            rabbit.eatCarrot(data)
        }
    }
    
}


// MARK: - WebSocketDelegate

extension Logger: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        DDLogInfo("websocketDidConnect")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        DDLogError("websocketDidDisconnect \(error?.localizedDescription ?? "")")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        DDLogVerbose("websocketDidReceiveMessage \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        DispatchQueue.global().async {
            let jsonDecoder = JSONDecoder()
            if let storagesMessage = try? jsonDecoder.decode(StoragesMessage.self, from: data) {
                let actionInfo = self.prepareAction(storagesMessage.action)
                if self.checkAction(actionInfo) {
                    storagesMessage.action = actionInfo.first ?? ""
                    self.sendData(storagesMessage, rabbit: RabbitsHolder.storagesRabbit)
                }
            } else if let productsMessage = try? jsonDecoder.decode(ProductsMessage.self, from: data) {
                let actionInfo = self.prepareAction(productsMessage.action)
                if self.checkAction(actionInfo) {
                    productsMessage.action = actionInfo.first ?? ""
                    self.sendData(productsMessage, rabbit: RabbitsHolder.productsRabbit)
                }
            }
            
            guard let string = String.init(data: data, encoding: .utf8) else { return }
            DDLogVerbose(string)
        }
    }
    
}
