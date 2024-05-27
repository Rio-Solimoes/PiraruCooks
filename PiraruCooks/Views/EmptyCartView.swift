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
        NavigationStack {
            VStack {
                Spacer()
                Image(systemName: "bag")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Shared.Colors.mediumGray.swiftUIColor)
                    .padding()
                Text("Sua sacola está vazia")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(alignment: .center)
                    .padding(.bottom, 8)
                Text("Continue explorando o cardápio para encontrar o melhor da culinária Manauara")
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                Spacer()
                Spacer()
            }
            .foregroundStyle(.black)
            .padding(.horizontal, 20)
            .navigationTitle("Sacola")
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}
