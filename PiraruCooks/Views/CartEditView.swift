//
//  CartView.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 20/05/24.
//

import SwiftUI
import Parintins

struct CartEditView: View {
    
    @EnvironmentObject private var themeManager: ThemeManager
    @State var menuController = MenuController.shared
    @State var alreadyInCart: Set<MenuItem> = []
    @State var viewModel = CartViewModel()
    @Environment(\.presentationMode) var presentationMode
    
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
                            Spacer()
                            Button(action: {
                                // Your edit action here
                                presentationMode.wrappedValue.dismiss()
                                print("Edit button tapped")
                            }) {
                                Text("Finalizar")
                            }
                        }
                        .foregroundStyle(.black)
                        .padding()
                        Text("Itens adicionados")
                            .font(.title2)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(Array(menuController.order.menuItems.keys), id: \.self) { dish in
                            VStack {
                                HStack {
                                    Button(action: {
                                        menuController.order.menuItems.removeValue(forKey: dish)
                                        print("to removendo")
                                    }) {
                                        Image(systemName: "trash")
                                            .resizable()
                                            .frame(width: getWidth() * 0.06, height: getWidth() * 0.06)
                                        
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
                                        Stepper(value: Binding(
                                            get: { menuController.order.menuItems[dish] ?? 0 },
                                            set: { menuController.order.menuItems[dish] = $0 }
                                        )) {
                                            Text("Quantidade: \(menuController.order.menuItems[dish] ?? 0)")
                                        }
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
                }
                .padding()
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
