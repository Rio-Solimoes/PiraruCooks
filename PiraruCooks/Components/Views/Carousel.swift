//
//  Carousel.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct Carrousel: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(0..<3) { index in
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 382, height: 305)
                    .cornerRadius(10)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle()) // Add PageTabViewStyle for the carousel effect
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    Carrousel()
}
