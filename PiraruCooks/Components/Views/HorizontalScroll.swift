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
            HStack(alignment: .top, spacing: 0) {
                ForEach(categorias, id: \.self) {categoria in
                    ZStack(alignment: .top) {
                        Color.white
                        Button {
                            withAnimation {
                                value.scrollTo("\(categoria)Id", anchor: .top)
                            }
                        } label: {
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundStyle(Color("Pink"))
                                    Image(categoria)
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundStyle(.white)
                                        .padding(10)
                                }
                                .frame(width: getWidth() * 0.15, height: getWidth() * 0.15)
                                Text(categoria)
                                    .font(.custom("KulimPark-Regular", size: 12, relativeTo: .caption))
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: getWidth() * 0.2)
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 4)
        }
    }
}
