//
//  DishesDetailViewModel.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 14/05/24.
//

import SwiftUI

@Observable
class DishesDetailViewModel {
    var previousViewOffset: CGFloat = 0
    var stepperValue: Int = 0
    var textFieldText: String = ""
    var isSaved: Bool = false
    let minimumOffset: CGFloat = 16
    
    var scrollOffsetPreference: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: ViewOffsetKey.self, value: -geometry.frame(in: .named("scroll")).origin.y)
        }
    }
}

struct BouncesModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
            }
    }
}
