//
//  StoragesMessage.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 06.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

final class StoragesMessage: Codable {
    
    // MARK: - Публичные свойства
    
    /// Действие
    var action: String
    /// Товары
    var products: [Product]
    /// Идентификатор склада
    var storageId: String
    /// Идентификатор транспорта
    var transportId: String
    
    
    // MARK: - Инициализация
    
    init(action: String, products: [Product], storageId: String, transportId: String) {
        self.action = action
        self.products = products
        self.storageId = storageId
        self.transportId = transportId
    }
    
}
