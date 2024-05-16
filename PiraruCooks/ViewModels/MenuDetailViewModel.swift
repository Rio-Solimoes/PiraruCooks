//
//  MenuDetailViewModel.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 14/05/24.
//

import SwiftUI

@Observable
class MenuDetailViewModel {
    var isMenuDetailScrolling = false
    var currentIndex: Int = 0
    var currentSpacing: CGFloat = 12
    var currentTrailingSpace: CGFloat = 66
    var currentPaddingTop: CGFloat = 15
    
    func handleScrollingChange() {
        withAnimation(.easeInOut(duration: 0.5)) {
            if isMenuDetailScrolling {
                currentSpacing = 0
                currentTrailingSpace = 0
                currentPaddingTop = 0
            } else {
                currentSpacing = 12
                currentTrailingSpace = 66
                currentPaddingTop = 15
            }
        }
    }
}
