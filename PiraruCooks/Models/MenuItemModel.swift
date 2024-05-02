//
//  MenuItemModel.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 02/05/24.
//

import Foundation
import SwiftUI

struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    var image: Image? // Optional image property

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
}

struct MenuItems: Codable {
    let items: [MenuItem]
}

struct MenuResponse: Codable {
    let items: [MenuItem]
}
