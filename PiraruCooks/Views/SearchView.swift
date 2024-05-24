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
                            .foregroundColor(.black)
                    ) {
                        ForEach(searchViewModel.filteredDishes, id: \.id) { dish in
                            NavigationLink(
                                destination: DishesDetailView(
                                    isMenuDetailScrolling: $menuViewModel.isMenuDetailScrolling,
                                    selectedDish: dish, showCloseButton: false)) {
                                        
                                HStack {
                                    if let dishImage = dish.image {
                                        Image(uiImage: dishImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                    } else {
                                        Shared.Images.emptyDish.swiftUIImage
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                    }
                                    VStack(alignment: .leading) {
                                        Text(dish.name)
                                            .fontWeight(.semibold)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Spacer()
                                        Text(dish.detailText)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Spacer()
                                        Text("R$ \(replaceDotWithComma(String(format: "%.2f", dish.price)))")
                                            .font(.subheadline)
                                    }
                                    .padding(8)
                                    .multilineTextAlignment(.leading)
                                }
                                        
                            }
                        }
                    }
                }
                .navigationTitle("Busca")
                .toolbarTitleDisplayMode(.inlineLarge)
            }
        }
        .searchable(text: $searchViewModel.searchTerm, prompt: "Pratos & Bebidas")
        .listStyle(.inset)
        .padding()
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