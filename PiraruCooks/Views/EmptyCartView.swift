//
//  CartView.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 20/05/24.
//

import SwiftUI
import Parintins

struct EmptyCartView: View {
    
    @EnvironmentObject private var themeManager: ThemeManager
    @State var menuController = MenuController.shared
    @State var alreadyInCart: Set<MenuItem> = []
    @State var viewModel = CartViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "bag")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .padding()
                Text("Sua sacola está vazia")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(alignment: .center)
                Text("Continue explorando o cardápio para encontrar o melhor da culinária Manauara")
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.bottom)
                Spacer()
                    .padding(.bottom, 5)
            }
            .foregroundStyle(.black)
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .navigationTitle("Sacola")
        }
    }
}
