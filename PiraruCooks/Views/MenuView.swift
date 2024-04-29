//
//  Menu.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Circle()
                        .frame(width: 41, height: 41)
                        .padding(.leading, 20)
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
                ScrollHorizontal()
            }
        }
        //.background(Color.green)
    }
}


#Preview {
    MenuView()
}
