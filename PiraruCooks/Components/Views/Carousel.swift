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
                Image("Carrousel\(index + 1)")
                    .resizable()
                    .frame(width: getWidth(), height: getHeight() * 0.35)
                    .cornerRadius(3)
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
