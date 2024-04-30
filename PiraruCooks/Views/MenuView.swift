//
//  Menu.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct MenuView: View {
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
                    ScrollHorizontal(ScrollToSobremesa: {
                        withAnimation {
                            value.scrollTo("Sobremesa", anchor: .top)
                        }
                    }, ScrollToSalgados: {
                        withAnimation {
                            value.scrollTo("Salgados", anchor: .top)
                        }
                    })
                    HStack {
                        Text("Sobremesa")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .padding()
                            .id("Sobremesa")
                        Spacer()
                    }
                    ForEach(0..<3) { index in
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 382, height: 305)
                            .cornerRadius(10)
                            .tag(index)
                    }
                    HStack {
                        Text("Salgados")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .padding()
                            .id("Salgados")
                        Spacer()
                    }
                    ForEach(0..<3) { index in
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 382, height: 305)
                            .cornerRadius(10)
                            .tag(index)
                    }
                }
            }
            
            ListOfDishes()
        }
        
        //.background(Color.green)
    }
}


#Preview {
    MenuView()
}
