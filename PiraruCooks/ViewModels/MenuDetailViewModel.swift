//
//  MenuDetailViewModel.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 14/05/24.
//

import SwiftUI

@Observable
class MenuDetailViewModel {
    var previousViewOffset: CGFloat = 0
    var stepperValue: Int = 0
    var textFieldText: String = ""
    let minimumOffset: CGFloat = 16
}

// Collects and pass the total offset of a view
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
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
