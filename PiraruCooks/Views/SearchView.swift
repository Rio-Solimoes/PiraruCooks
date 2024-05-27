//
//  SearchView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 20/05/24.
//

import SwiftUI
import Parintins

struct SearchView: View {
    @State var menuViewModel = MenuDetailViewModel()
    @State var searchViewModel = SearchViewModel()
    @State private var selectedDish: MenuItem?
    @Binding var isHomePresented: Bool

    var body: some View {
        NavigationStack {
            if searchViewModel.filteredDishes.isEmpty {
                emptyState
            } else {
                List {
                    Section(header:
                        Text(searchViewModel.sectionHeaderTitle)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .padding(.bottom, 16)
                    ) {
                        ForEach(searchViewModel.filteredDishes, id: \.id) { dish in
                            ZStack {
                                NavigationLink(value: dish) {}
                                Color.white
                                DishCardView(viewModel: DishCardViewModel(dish: dish))
                            }
                            .listRowSeparator(.hidden)
                            .padding(.top, -16)
                        }
                    }
                }
                .navigationTitle("Busca")
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationDestination(for: MenuItem.self) { dish in
                    DishesDetailView(
                        isMenuDetailScrolling: $menuViewModel.isMenuDetailScrolling,
                        selectedDish: dish, 
                        showCloseButton: false
                    )
                }
            }
        }
        .searchable(text: $searchViewModel.searchTerm, prompt: "Pratos & Bebidas")
        .listStyle(.inset)
    }
    
    private var emptyState: some View {
        VStack {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundStyle(Shared.Colors.mediumGray.swiftUIColor)
                .padding(.vertical, 8)
            Text("Nenhum resultado")
                .font(.title2)
            Spacer()
        }
        .fontWeight(.semibold)
    }
}
