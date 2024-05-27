//
//  OrderModel.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 02/05/24.
//

import Foundation

struct Order: Codable, Hashable {
    var menuItems: [MenuItem: Int]
    var price: Double

    init(menuItems: [MenuItem: Int] = [:]) {
        self.menuItems = menuItems
        self.price = 0
    }
}

struct OrderResponse: Codable {
    let prepTime: Int

    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
