//
//  ContentView.swift
//  Pirarucool
//
//  Created by Guilherme Ferreira Lenzolari on 26/04/24.
//

import SwiftUI

struct ListOfDishes: View {
    @StateObject var menuController = MenuController.shared
    @ObservedObject var datas: MenuViewModel

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
                            Image("tacaca")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading) {
                                Text(prato.nomeDoPrato)
                                    .font(.title3)
                                Spacer()
                                Text(prato.descriçãoDoPrato)
                                    .font(.caption)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                Text("R$ \(prato.preço)")
                                    .font(.headline)
                            }
                            .foregroundStyle(.black)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 8)
                                .frame(height: getWidth() * 0.20)
                            Spacer()
                        }.padding(.horizontal, 24)
                            .padding(.vertical, 8)
                    }
                }
            }
        }
    }
}

//                    .id("\(categoria)Id")
//                ForEach(datas.pratos.filter({prato in prato.categoria == categoria}), id: \.self) {prato in
//                    Button {
//                        print("AAA")
//                    } label: {
//                        HStack {
//                            Image("tacaca")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
//                                .clipShape(RoundedRectangle(cornerRadius: 10))
//
//                            VStack(alignment: .leading) {
//                                Text(prato.nomeDoPrato)
//                                    .font(.title3)
//                                Spacer()
//                                Text(prato.descriçãoDoPrato)
//                                    .font(.caption)
//                                    .fixedSize(horizontal: false, vertical: true)
//                                Spacer()
//                                Text("R$ \(prato.preço)")
//                                    .font(.headline)
//                            }.foregroundStyle(.black)
//                                .multilineTextAlignment(.leading)
//                                .padding(.leading, 8)
//                                .frame(height: getWidth() * 0.20)
//                            Spacer()
//                        }.padding(.horizontal, 24)
//                            .padding(.vertical, 8)
//                    }
//                }
