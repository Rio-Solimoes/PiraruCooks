//
//  SearchViewModel.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 22/05/24.
//

import Foundation

@Observable
class SearchViewModel {
    let menuController = MenuController.shared
    var searchTerm = ""
    
    var filteredDishes: [MenuItem] {
        guard !searchTerm.isEmpty else { return Array(menuController.dishes.prefix(3)) }
        let normalizedSearchTerm = searchTerm.normalized()
        return Array(
            menuController.dishes.filter {
                $0.name.normalized().localizedCaseInsensitiveContains(normalizedSearchTerm)
            }
        )
    }
    
    var sectionHeaderTitle: String {
        return searchTerm.isEmpty ? "Descubra" : "Principais Resultados"
    }
}
