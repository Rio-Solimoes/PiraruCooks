//
//  Home.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 09/05/24.
//

import SwiftUI

struct Home: View {
    @State private var showBackground = false
    @State private var isMenuDetailScrolling = false
    @State private var menuController = MenuController.shared
    @State private var currentIndex: Int = 0
    @State private var isAnimating = false

    var selectedDish: MenuItem?
    var initialIndex: Int {
        if let id = selectedDish?.id {
            return id - 1
        } else {
            return 0
        }
    }

    @State private var currentSpacing: CGFloat = 6
    @State private var currentTrailingSpace: CGFloat = 36
    @State private var currentPaddingTop: CGFloat = 15

    var body: some View {
        ZStack {
            VStack(spacing: currentSpacing) {
                
                SnapCarouselView(spacing: currentSpacing,
                                 trailingSpace: currentTrailingSpace,
                                 index: $currentIndex,
                                 initialIndex: initialIndex,
                                 items: menuController.dishes.sorted(by: { $0.id < $1.id })) { dish in
                    GeometryReader { proxy in
                        let size = proxy.size
                        
                        MenuDetailView(selectedDish: dish, isMenuDetailScrolling: $isMenuDetailScrolling)
                            .background()
                            .frame(width: size.width)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 12,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 12
                                )
                            )
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.top, currentPaddingTop)
                .onChange(of: isMenuDetailScrolling) { newValue in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        print(newValue)
                        if newValue == true {
                            currentSpacing = 0
                            currentTrailingSpace = 0
                            currentPaddingTop = 0
                        } else {
                            currentSpacing = 6
                            currentTrailingSpace = 36
                            currentPaddingTop = 15
                        }
                    }
                }
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
