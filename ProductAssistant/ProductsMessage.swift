//
//  ProductsMessage.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 06.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

final class ProductsMessage: Codable {
    
    // MARK: - Публичные свойства
    
    /// Действие
    var action: String
    /// Товары
    var products: [Product]
    
    
    // MARK: - Инициализация
    
    init(action: String, products: [Product]) {
        self.action = action
        self.products = products
    }
    
}
