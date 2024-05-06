//
//  TabBarView.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = "Cardápio"
    
    var body: some View {
        VStack {
            HStack {
                Text("Cardápio")
                    .font(.custom("KulimPark-SemiBold", size: 34, relativeTo: .largeTitle))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image("Perfil")
                    .frame(width: getWidth() * 0.1, height: getWidth() * 0.1)
            }
            .padding(.horizontal, 20)

            Spacer()

            TabView(selection: $selectedTab) {
                MenuView()
                    .tabItem {
                        Image("Cardápio\(selectedTab == "Cardápio" ? "_Selecionado" : "")")
                        Text("Cardápio")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                    }
                    .onTapGesture {
                        selectedTab = "Cardápio"
                    }
                    .tag("Cardápio")
                Text("Buscar")
                    .tabItem {
                        Image("Buscar\(selectedTab == "Buscar" ? "_Selecionado" : "")")
                        Text("Buscar")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                    }
                    .onTapGesture {
                        selectedTab = "Buscar"
                    }
                    .tag("Buscar")
                Text("Pedidos")
                    .tabItem {
                        Image("Pedidos\(selectedTab == "Pedidos" ? "_Selecionado" : "")")
                        Text("Pedidos")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                    }
                    .onTapGesture {
                        selectedTab = "Pedidos"
                    }
                    .tag("Pedidos")
            }
            .accentColor(Color("Pink"))
        }
    }
}

#Preview {
    TabBarView()
}
