import Foundation
import SwiftUI

struct OnScrollPositionModifier: ViewModifier {
    @State var id: String = UUID().uuidString
    @State var currentPosition: CGFloat = 0
    @State var triggeredGoingDown: Bool = false
    @State var appearingPosition: CGFloat?
    
    let targetPosition: CGFloat
    let action: (() -> Void)?
    
    init(targetPosition: CGFloat, action: @escaping () -> Void) {
        self.targetPosition = targetPosition
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        if !OnScrollModifier.startedScrolling {
                            appearingPosition = geometry.frame(in: .global).maxY - content.getHeight()
                        }
                    }
            })
            .onAppear {
                OnScrollModifier.onScrollPositionActions.append(self)
            }
            .onDisappear {
//                appearingPosition = nil
                OnScrollModifier.onScrollPositionActions.removeAll(
                    where: { onScrollPositionModifier in
                        onScrollPositionModifier.id == self.id
                    })
            }
    }
}

extension View {
    func onScrollPosition(_ targetPosition: CGFloat, action: @escaping () -> Void) -> some View {
        modifier(OnScrollPositionModifier(targetPosition: targetPosition * getHeight(), action: action))
    }
}
