//
//  RabbitsHolder.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 07.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

import Foundation

final class RabbitsHolder {
    
    // MARK: - Публичные свойства
    
    /// Очередь для доступа к элементам
    static let accessQueue = DispatchQueue(label: "accessQueue", qos: .userInitiated)
    
    /// Канал для модуля "Товар"
    static let productsRabbit = Rabbit(exchange: "Products")
    /// Канал для модуля "Склад"
    static let storagesRabbit = Rabbit(exchange: "Storages")
    
}
