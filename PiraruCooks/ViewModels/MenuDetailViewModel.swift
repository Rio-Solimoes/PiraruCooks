//
//  MenuDetailViewModel.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 14/05/24.
//

import SwiftUI

@Observable
class MenuDetailViewModel {
    var showBackground = false
    var isMenuDetailScrolling = false
    var currentIndex: Int = 0
    var isAnimating = false
    var currentSpacing: CGFloat = 6
    var currentTrailingSpace: CGFloat = 36
    var currentPaddingTop: CGFloat = 15
    
    func handleScrollingChange() {
        withAnimation(.easeInOut(duration: 0.5)) {
            if isMenuDetailScrolling {
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
    
    func animateBackground() {
        withAnimation(.easeInOut(duration: 0.4)) {
            showBackground = true
        }
    }
}
