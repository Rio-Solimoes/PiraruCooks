import Foundation
import SwiftUI

struct OnDidScrollModifier: ViewModifier {
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                OnScrollModifier.onDidScrollActions.append(self)
            }
    }
}

extension View {
    func onDidScroll(action: @escaping () -> Void) -> some View {
        modifier(OnDidScrollModifier(action: action))
    }
}
