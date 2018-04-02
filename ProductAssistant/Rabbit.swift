//
//  Rabbit.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 02.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

import RMQClient

final class Rabbit {
    
    // MARK: - Публичные свойства
    
    static var shared = Rabbit()
    
    
    // MARK: - Приватные свойства
    
    /// Соединение с RabbitMQ
    private let connection: RMQConnection
    /// Стек сообщений
    private let exchange: RMQExchange
    
    
    // MARK: - Инициализация
    
    private init() {
        let connection = RMQConnection(uri: "amqp://test:Zxvcasfd@51.144.119.126", delegate: RMQConnectionDelegateLogger())
        connection.start()
        
        let channel = connection.createChannel()
        let exchange = channel.fanout("Storages")
        
        self.connection = connection
        self.exchange = exchange
    }
    
    
    // MARK: - Деинициализация
    
    deinit {
        self.connection.close()
    }
    
}


// MARK: - Публичные методы

extension Rabbit {
    
    /// Съесть морковку
    func eatCarrot(_ message: String) {
        let messageData = message.data(using: .utf8)
        self.exchange.publish(messageData)
    }
    
}
