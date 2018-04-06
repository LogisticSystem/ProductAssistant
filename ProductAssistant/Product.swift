//
//  Product.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 06.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

final class Product: Codable {
    
    // MARK: - Публичные свойства
    
    /// Идентификатор товара
    var id: String
    /// Идентификатор точки отправления
    var source: String
    /// Идентификатор точки прибытия
    var destination: String
    /// Маршрут
    var route: [String]
    /// Идентификатор владельца
    var ownerId: String?
    
    
    // MARK: - Инициализация
    
    init(id: String, source: String, destination: String, route: [String], ownerId: String?) {
        self.id = id
        self.source = source
        self.destination = destination
        self.route = route
        self.ownerId = ownerId
    }
    
}
