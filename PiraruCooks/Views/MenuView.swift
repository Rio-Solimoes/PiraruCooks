//
//  Menu.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct MenuView: View {
    @StateObject var datas = MenuViewModel()
    @StateObject var cloudKit = CloudKitModel()
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { value in
                ScrollView {
                    VStack {
                        
                        Text("isSignedInToiCloud: \(cloudKit.isSignedInToiCloud.description)")
                        Text("username: \(cloudKit.userName)")
                        Text("permissionStatus:  \(cloudKit.permissionStatus.description)")
                        
                        Divider()
                            .padding(.top, 16)
                        NavigationLink {
                            Text("Endereços")
                                .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                        } label: {
                            HStack {
                                Image("Casa")
                                    .padding(.horizontal, 8)
                                VStack(alignment: .leading) {
                                    Text("Casa")
                                        .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                                    Text("Av. Alan Turing, 275")
                                        .font(.custom("KulimPark-Light", size: 17, relativeTo: .body))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding(.trailing)
                            }
                            .foregroundStyle(.black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                        }
                        Divider()
                            .padding(.bottom, 16)
                        HStack {
                            Text("Destaques")
                                .font(.custom("KulimPark-SemiBold", size: 22, relativeTo: .title2))
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        Carrousel()
                            .frame(height: getHeight() * 0.35)
                        ScrollHorizontal(categorias: datas.categorias, value: value
                        )
                    }
                    ListOfDishes(datas: datas)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
