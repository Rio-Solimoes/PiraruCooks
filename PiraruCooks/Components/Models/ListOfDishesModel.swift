//
//  ListOfDishesModel.swift
//  PiraruCooks
//
//  Created by Guilherme Ferreira Lenzolari on 29/04/24.
//

import Foundation

@Observable
class ListOfDishesModel {
    @ObservationIgnored
    var lastCategory = ""
    
    func newCategory(currentCategory: String) -> String {
        print(lastCategory)
        print(currentCategory)
        print(lastCategory == currentCategory)
        print("-")
        if lastCategory == currentCategory {
            print("Entro no vazio")
            return ""
        } else {
            print("criou um novo titulo")
            lastCategory = currentCategory
            return "Bom dia"
        }
    }
}
