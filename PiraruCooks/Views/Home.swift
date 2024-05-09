//
//  Home.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 09/05/24.
//

import SwiftUI

struct Home: View {
    @State private var showBackground = false
    @State var menuController = MenuController.shared
    @State var currentIndex: Int = 0
    var selectedDish: MenuItem?
    var initialIndex: Int {
        if let id = selectedDish?.id {
            return id - 1
        } else {
            return 0
        }
    }

    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                
                SnapCarouselView(spacing: 6, trailingSpace: 36, index: $currentIndex, initialIndex: initialIndex, items: menuController.dishes.sorted(by: { $0.id < $1.id })) { dish in
                    GeometryReader { proxy in
                        let size = proxy.size
                        
                        MenuDetailView(selectedDish: dish)
                            .background()
                            .frame(width: size.width)
                            .cornerRadius(12)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.top)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.4)) {
                showBackground = true
            }
        }
        .background(Color.black.opacity(showBackground ? 0.6 : 0))
    }
}

#Preview {
    Home()
}
