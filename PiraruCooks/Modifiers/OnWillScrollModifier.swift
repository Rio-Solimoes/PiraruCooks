import Foundation
import SwiftUI

struct OnWillScrollModifier: ViewModifier {
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                OnScrollModifier.onWillScrollActions.append(self)
            }
    }
}

extension View {
    func onWillScroll(action: @escaping () -> Void) -> some View {
        modifier(OnWillScrollModifier(action: action))
    }
}
