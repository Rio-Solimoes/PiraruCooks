//
//  ContentView.swift
//  Pirarucool
//
//  Created by Guilherme Ferreira Lenzolari on 26/04/24.
//

import SwiftUI

struct ListOfDishes: View {
    @ObservedObject var datas: MenuViewModel

    var body: some View {
        VStack {
            ForEach(datas.categorias, id: \.self) {categoria in
                HStack {
                    Text(categoria)
                        .font(.custom("KulimPark-SemiBold", size: 22, relativeTo: .title2))
                    Spacer()
                }
                    .id("\(categoria)Id")
                ForEach(datas.pratos.filter({prato in prato.categoria == categoria}), id: \.self) {prato in
                    Button {
                        print("AAA")
                    } label: {
                        VStack {
                            HStack {
                                Image("tacaca")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                VStack(alignment: .leading) {
                                    Text(prato.nomeDoPrato)
                                        .font(.custom("KulimPark-SemiBold", size: 17, relativeTo: .body))
                                    Spacer()
                                    Text(prato.descriçãoDoPrato)
                                        .font(.custom("KulimPark-Regular", size: 15, relativeTo: .body))
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                    Text("R$ \(prato.preço)")
                                        .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
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
                }
            }
        }
    }
}
