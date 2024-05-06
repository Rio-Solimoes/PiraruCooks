//
//  ContentView.swift
//  Pirarucool
//
//  Created by Guilherme Ferreira Lenzolari on 26/04/24.
//

import SwiftUI

struct ListOfDishes: View {
    @StateObject var menuController = MenuController.shared

    var body: some View {
        VStack {
            ForEach(menuController.categorias, id: \.self) { categoria in
                HStack {
                    Text(categoria)
                        .font(.title2)
                    Spacer()
                }
                .padding(.horizontal, 24)
                .id("\(categoria)Id")
                
                ForEach(menuController.pratos.filter({prato in prato.category == categoria}), id: \.self) {prato in
                    Button {
                        print("AAA")
                    } label: {
                        HStack {
                            if let pratoImage = prato.image {
                                Image(uiImage: pratoImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Image("tacaca")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }

                            VStack(alignment: .leading) {
                                Text(prato.name)
                                    .font(.title3)
                                Spacer()
                                Text(prato.detailText)
                                    .font(.caption)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                Text("R$ \(String(format: "%.2f", prato.price))")
                                    .font(.headline)
                            }
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 8)
                            .frame(height: getWidth() * 0.20)
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                    }
                }
            }
        }
    }
}
