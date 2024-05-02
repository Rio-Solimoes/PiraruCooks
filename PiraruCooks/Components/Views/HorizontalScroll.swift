//
//  HorizontalScroll.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct ScrollHorizontal: View {
    var categorias: [String]
    var value: SwiftUI.ScrollViewProxy

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categorias, id: \.self) {categoria in
                    Button(categoria) {
                        withAnimation {
                            value.scrollTo("\(categoria)Id", anchor: .top)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
