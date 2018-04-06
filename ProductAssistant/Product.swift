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
    
}
