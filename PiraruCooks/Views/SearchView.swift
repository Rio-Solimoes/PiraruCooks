//
//  SearchView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 20/05/24.
//

import SwiftUI
import Parintins

struct SearchView: View {
    @State var menuController = MenuController.shared
    @State var viewModel = MenuDetailViewModel()
    @State var searchTerm = ""
    @State private var selectedDish: MenuItem?
    @Binding var isHomePresented: Bool
    
    var filteredDishes: [MenuItem] {
        guard !searchTerm.isEmpty else { return Array(menuController.dishes.prefix(3)) }
        return Array(menuController.dishes
            .filter { $0.name.normalized().localizedCaseInsensitiveContains(searchTerm) })
    }

    var body: some View {
        NavigationStack {
            List {
                Section(header:
                    Text("Descubra")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                ) {
                    ForEach(filteredDishes, id: \.id) { dish in
                        NavigationLink(
                            destination: DishesDetailView(isMenuDetailScrolling: $viewModel.isMenuDetailScrolling,
                                                          selectedDish: dish, showCloseButton: false)) {
                            HStack {
                                if dish.image != nil {
                                    Image(uiImage: dish.image!)
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
            .searchable(text: $searchTerm, prompt: "Pratos & Bebidas")
            .listStyle(.inset)
        }
        .padding()
    }
}
