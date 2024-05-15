//
//  MenuDetailView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 07/05/24.
//

import SwiftUI

struct MenuDetailView: View {
    @State var viewModel = MenuDetailViewModel()
    @State private var menuController = MenuController.shared
    
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
            VStack(spacing: viewModel.currentSpacing) {
                carouselView()
                .edgesIgnoringSafeArea(.all)
                .padding(.top, viewModel.currentPaddingTop)
                .onChange(of: viewModel.isMenuDetailScrolling) {
                    viewModel.handleScrollingChange()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear(perform: viewModel.animateBackground)
        .background(Color.black.opacity(viewModel.showBackground ? 0.6 : 0))
    }
    
    private func carouselView() -> some View {
        SnapCarouselView(
            spacing: viewModel.currentSpacing,
            trailingSpace: viewModel.currentTrailingSpace,
            index: $viewModel.currentIndex,
            initialIndex: initialIndex,
            items: menuController.dishes.sorted(by: { $0.id < $1.id })
        ) { dish in
            GeometryReader { proxy in
                let size = proxy.size
                DishesDetailView(isMenuDetailScrolling: $viewModel.isMenuDetailScrolling, selectedDish: dish)
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
    }
}

#Preview {
    MenuDetailView()
}
