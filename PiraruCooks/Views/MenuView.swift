//
//  Menu.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct MenuView: View {
    @StateObject var menuController = MenuController.shared
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                VStack {
                    HStack {
                        Image("Casa")
                            .padding(.leading)
                        VStack(alignment: .leading) {
                            Text("Casa")
                                .fontWeight(.bold)
                            Text("Av. Alan Turing, 275")
                        }
                        Spacer()
                    }
                    HStack {
                        Text("Title")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .padding()
                        Spacer()
                    }
                    Carrousel()
                        .frame(height: 305)
                    ScrollHorizontal(categorias: menuController.categorias, value: value
                    )
                }
                ListOfDishes()
            }
        }
    }
}

#Preview {
    MenuView()
}
