//
//  CartViewModel.swift
//  PiraruCooks
//
//  Created by Lucas Francisco on 22/05/24.
//

import Foundation

@Observable
class CartViewModel {
    var isMenuDetailScrolling = false
    var currentIndex: Int = 0
    var currentSpacing: CGFloat = 12
    var currentTrailingSpace: CGFloat = 66
    var currentPaddingTop: CGFloat = 15
    
    func addItemToSet(set: inout Set<MenuItem>, item: MenuItem) {
        set.insert(item)
    }
}

