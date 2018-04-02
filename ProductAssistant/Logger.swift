//
//  Logger.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 02.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

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


// MARK: - WebSocketDelegate

extension Logger: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocketDidConnect")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocketDidDisconnect \(error?.localizedDescription ?? "")")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("websocketDidReceiveMessage \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("websocketDidReceiveData \(data)")
    }
    
}
