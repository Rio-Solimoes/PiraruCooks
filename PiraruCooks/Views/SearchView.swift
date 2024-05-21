//
//  SearchView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 20/05/24.
//

import SwiftUI

struct SearchView: View {
    @State var menuController = MenuController.shared
    @State var searchTerm = ""
    
    var filteredDishes: [MenuItem] {
        guard !searchTerm.isEmpty else { return menuController.dishes }
        return menuController.dishes.filter { $0.name.normalized().localizedCaseInsensitiveContains(searchTerm) }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDishes, id: \.id) { dish in
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text(dish.name)
                }
            }
            .navigationTitle("Busca")
            .searchable(text: $searchTerm, prompt: "Search")
        }
    }
}

#Preview {
    SearchView()
}
