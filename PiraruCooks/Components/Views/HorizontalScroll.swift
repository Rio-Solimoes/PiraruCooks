//
//  HorizontalScroll.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct ScrollHorizontal: View {
    var ScrollToSobremesa: (() -> Void)? // Closure para ação do botão
    var ScrollToSalgados: (() -> Void)?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                Button("Sobremesa"){
                    ScrollToSobremesa?()
                }
                Button("Salgados"){
                    ScrollToSalgados?()
                }
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 145, height: 32)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 145, height: 32)
            }
            .padding()
        }
        
    }
}

#Preview {
    ScrollHorizontal()
}
