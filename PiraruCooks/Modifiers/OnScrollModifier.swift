import Foundation
import SwiftUI

// swiftlint:disable identifier_name
enum ScrollDirection {
    case up
    case down
}
// swiftlint:enable identifier_name

struct OnScrollModifier: ViewModifier {
    static var onScrollPositionActions: [OnScrollPositionModifier] = []
    static var startedScrolling: Bool = false
    
    @State var previousScrollOffset: CGFloat = 0
    
    let coordinateSpace: String
    let minOffset: CGFloat
    let action: ((ScrollDirection, CGFloat) -> Void)?
    
    init(
        coordinateSpace: String,
        minOffset: CGFloat,
        action: @escaping (ScrollDirection, CGFloat) -> Void
    ) {
        self.coordinateSpace = coordinateSpace
        self.minOffset = minOffset
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: ViewOffsetKey.self,
                        value: -geometry.frame(in: .named(coordinateSpace)).origin.y)
            }).onPreferenceChange(ViewOffsetKey.self) { currentOffset in
                let offsetDifference: CGFloat = previousScrollOffset - currentOffset
                var scrollDirection: ScrollDirection = .down
                if offsetDifference > 0 {
                    scrollDirection = .up
                }
                OnScrollModifier.onScrollPositionActions.forEach({ onScrollPositionModifier in
                    OnScrollModifier.startedScrolling = true
                    guard let action = onScrollPositionModifier.action else {
                        return
                    }
                    var appearingPosition: CGFloat = 1000000000
                    if let position = onScrollPositionModifier.appearingPosition {
                        appearingPosition = position
                    } else {
                        onScrollPositionModifier.appearingPosition = currentOffset
                        appearingPosition = currentOffset
                    }
                    let offsetDifference = currentOffset - appearingPosition
                    if scrollDirection == .down && !onScrollPositionModifier.triggeredGoingDown &&
                        offsetDifference > onScrollPositionModifier.targetPosition {
                        onScrollPositionModifier.triggeredGoingDown = true
                        action()
                    } else if scrollDirection == .up && onScrollPositionModifier.triggeredGoingDown &&
                                offsetDifference < onScrollPositionModifier.targetPosition {
                        onScrollPositionModifier.triggeredGoingDown = false
                        action()
                    }
                })
                guard let action = action else {
                    return
                }
                if abs(offsetDifference) > minOffset {
                    previousScrollOffset = currentOffset
                    action(scrollDirection, currentOffset)
                }
            }
    }
}

extension View {
    func onScroll(
        coordinateSpace: String,
        minOffset: CGFloat = 16,
        action: @escaping (ScrollDirection, CGFloat) -> Void
    ) -> some View {
        modifier(
            OnScrollModifier(
                coordinateSpace: coordinateSpace,
                minOffset: minOffset,
                action: action
            )
        )
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
