//
//  TabBarView.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Cardápio")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                Circle()
                    .frame(width: 41, height: 41)
                    .foregroundColor(.blue)
                    .padding()
            }

            Spacer()

            TabView {
                MenuView()
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text("Menu")
                    }
                Text("Second Tab")
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Pesquisar")
                    }
                Text("Third Tab")
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text("Pedidos")
                    }
            }
        }
    }
}

#Preview {
    TabBarView()
}
