//
//  AddressModel.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 23/05/24.
//

import Foundation

struct Address: Identifiable {
    let id = UUID()
    var zipCode: String
    var street: String
    var number: String
    var obs: String
    var city: String
    var telephone: String
    var category: String
}
