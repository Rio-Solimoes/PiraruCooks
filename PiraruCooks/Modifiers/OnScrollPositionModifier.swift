import Foundation
import SwiftUI

struct OnScrollPositionModifier: ViewModifier {
    @State var id: String = UUID().uuidString
    @State var triggeredGoingDown: Bool = false
    @State var isAppearing: Bool = false
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
                            appearingPosition = geometry.frame(in: .global).origin.y - content.getHeight()
                        }
                    }
                    .onReceive(OnScrollModifier.previousScrollOffsetPublished
                        .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
                        .eraseToAnyPublisher()
                    ) { _ in
                        if isAppearing {
                            appearingPosition = OnScrollModifier.previousScrollOffsetPublished.value +
                            (geometry.frame(in: .global).maxY - content.getHeight())
                        }
                    }
            })
            .onAppear {
                isAppearing = true
                if !OnScrollModifier.onScrollPositionActions.contains(where: { onScrollPositionModifier in
                    onScrollPositionModifier.id == self.id
                }) {
                    OnScrollModifier.onScrollPositionActions.append(self)
                }
            }
            .onDisappear {
                appearingPosition = nil
                isAppearing = false
                if let appearingPosition = appearingPosition {
                    let offsetDifference = OnScrollModifier.previousScrollOffsetPublished.value - appearingPosition
                    if offsetDifference > 0 {
                        triggeredGoingDown = false
                    } else {
                        triggeredGoingDown = true
                    }
                }
            }
    }
}

extension View {
    func onScrollPosition(_ targetPosition: CGFloat, action: @escaping () -> Void) -> some View {
        modifier(OnScrollPositionModifier(targetPosition: targetPosition * getHeight(), action: action))
    }
}
