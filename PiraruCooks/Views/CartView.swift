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
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { value in
                ScrollView {
                    LazyVStack {
                        HStack {
                            Text("Carrinho")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            themeManager.selectedTheme.profileDefault.swiftUIImage
                                .resizable()
                                .frame(width: getWidth() * 0.1, height: getWidth() * 0.1)
                        }
                        .foregroundStyle(.black)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        ForEach(Array(menuController.order.menuItems.keys), id: \.self) { dish in
                            VStack {
                                HStack {
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
                                        Text("Quantidade: \(menuController.order.menuItems[dish] ?? -1)")
                                    }
                                    
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 8)
                                    .frame(height: getWidth() * 0.25)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding(.vertical, 8)
                                .foregroundStyle(.black)
                                Divider()
                                    .padding(.vertical, 8)
                            }
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
                    }
                    .background(alignment: .top) {
                        if themeManager.selectedTheme.userDefaultsValue != "Parintins" {
                            LinearGradient(
                                gradient: Gradient(
                                    stops: [
                                        .init(
                                            color: (themeManager.selectedTheme.primary.swiftUIColor)
                                                .opacity(0.3),
                                            location: 0.0
                                        ),
                                        .init(
                                            color: (themeManager.selectedTheme.tertiary.swiftUIColor)
                                                .opacity(0.2),
                                            location: 1.0
                                        )
                                    ]
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: getWidth() * 1.13, height: getHeight() * 0.24)
                            .offset(x: -(getWidth() * 0.025), y: -(getHeight() * 0.1))
                            .blur(radius: 8)
                        }
                    }
                }
                .coordinateSpace(name: "scroll")
            }
            //.navigationTitle("Cardápio")
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CartView()
}
