//
//  HorizontalScroll.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 29/04/24.
//

import SwiftUI

struct ScrollHorizontal: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 145, height: 32)
                
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
