//
//  CartView.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 20/05/24.
//

import SwiftUI
import Parintins

struct CartView: View {
    
    @EnvironmentObject private var themeManager: ThemeManager
    @State var menuController = MenuController.shared
    @State var alreadyInCart: Set<MenuItem> = []
    @State var viewModel = CartViewModel()
    @State private var isCartEditSelected = false
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { value in
                ScrollView {
                    LazyVStack {
                        Text("Itens adicionados")
                            .font(.title2)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(Array(menuController.order.menuItems.keys), id: \.self) { dish in
                            VStack {
                                HStack {
                                    if isCartEditSelected {
                                        Button(action: {
                                            menuController.order.menuItems.removeValue(forKey: dish)
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .resizable()
                                                .frame(width: getWidth() * 0.06, height: getWidth() * 0.06)
                                                .foregroundStyle(.red)
                                        }
                                    }
                                    if dish.image != nil {
                                        Image(uiImage: dish.image!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        Shared.Images.emptyDish.swiftUIImage
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(dish.name)
                                            .font(.body)
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
                                        HStack {
                                            Text("Quantidade: \(menuController.order.menuItems[dish] ?? 0)")
                                                .font(.caption)
                                            if isCartEditSelected {
                                                Stepper("", onIncrement: {
                                                    menuController.order.menuItems[dish]? += 1
                                                    menuController.order.price += dish.price
                                                }, onDecrement: {
                                                    if menuController.order.menuItems[dish] ?? 1 > 1 {
                                                        menuController.order.menuItems[dish]? -= 1
                                                        menuController.order.price -= dish.price
                                                    }
                                                })
                                            }
                                        }
                                    }
                                    
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 8)
                                    .frame(height: getWidth() * 0.25)
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .foregroundStyle(.black)
                                Divider()
                                    .padding(.vertical, 8)
                            }
                            .padding(.top, 16)
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Subtotal do pedido")
                                Spacer()
                                Text("R$ \(replaceDotWithComma(String(format: "%.2f", menuController.order.price)))")
                            }
                            HStack {
                                Text("Frete")
                                Spacer()
                                Text("Grátis")
                            }
                            HStack {
                                Text("Total")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("R$ \(replaceDotWithComma(String(format: "%.2f", menuController.order.price)))")
                                    .fontWeight(.semibold)
                            }
                            
                        }
                        .padding(.top, 32)
                    }
                }
                .padding()
                .coordinateSpace(name: "scroll")
            }
            .navigationTitle("Sacola")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        viewModel.showReviewOrder = true
                    } label: {
                        Text("Confirmar Itens")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(width: 272, height: 36)
                    }
                    .background(themeManager.selectedTheme.primary.swiftUIColor)
                    .cornerRadius(8)
                    .padding(.bottom, 32)
                }
                ToolbarItem(placement: .primaryAction) {
                    if !isCartEditSelected {
                        Button(action: {
                            isCartEditSelected = true
                        }) {
                            Text("Editar")
                        }
                    } else {
                        Button(action: {
                            isCartEditSelected = false
                        }) {
                            Text("Pronto")
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.showReviewOrder) {
                ReviewOrderView()
            }
        }
    }
}

#Preview {
    CartView()
}
