import Foundation
import SwiftUI

// swiftlint:disable identifier_name
enum ScrollDirection {
    case vertical
    case up
    case down
}
// swiftlint:enable identifier_name

struct OnScrollModifier: ViewModifier {
    @State var previousScrollOffset: CGFloat = 0
    
    let coordinateSpace: String
    let minOffset: CGFloat
    let upTriggerOffset: CGFloat?
    let downTriggerOffset: CGFloat?
    let direction: ScrollDirection
    let upAction: (() -> Void)?
    let downAction: (() -> Void)?
    
    init(
        coordinateSpace: String,
        minOffset: CGFloat,
        upTriggerOffset: CGFloat?,
        downTriggerOffset: CGFloat?,
        direction: ScrollDirection,
        upAction: @escaping () -> Void,
        downAction: @escaping () -> Void
    ) {
        self.coordinateSpace = coordinateSpace
        self.minOffset = minOffset
        self.upTriggerOffset = upTriggerOffset
        self.downTriggerOffset = downTriggerOffset
        self.direction = direction
        self.upAction = upAction
        self.downAction = downAction
    }
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named(coordinateSpace)).origin.y)
            }).onPreferenceChange(ViewOffsetKey.self) { currentOffset in
                let offsetDifference: CGFloat = previousScrollOffset - currentOffset
                if abs(offsetDifference) > minOffset {
                    previousScrollOffset = currentOffset
                    if (direction == .vertical || direction == .up) && offsetDifference > 0 {
                        guard let action = upAction else {
                            return
                        }
                        if let triggerOffset = upTriggerOffset {
                            if currentOffset < triggerOffset {
                                action()
                            }
                            return
                        }
                        action()
                    } else if (direction == .vertical || direction == .down) && offsetDifference <= 0 {
                        guard let action = downAction else {
                            return
                        }
                        if let triggerOffset = downTriggerOffset {
                            if currentOffset > triggerOffset {
                                action()
                            }
                            return
                        }
                        action()
                    }
                }
            }
    }
}

extension View {
    func onScroll(
        coordinateSpace: String,
        minOffset: CGFloat = 16,
        triggerOffset: CGFloat? = nil,
        direction: ScrollDirection = .down,
        action: @escaping () -> Void
    ) -> some View {
        modifier(
            OnScrollModifier(
                coordinateSpace: coordinateSpace,
                minOffset: minOffset,
                upTriggerOffset: triggerOffset,
                downTriggerOffset: triggerOffset,
                direction: direction,
                upAction: action,
                downAction: action
            )
        )
    }
    
    func onScroll(
        coordinateSpace: String,
        minOffset: CGFloat = 16,
        upTriggerOffset: CGFloat? = nil,
        downTriggerOffset: CGFloat? = nil,
        action: @escaping () -> Void
    ) -> some View {
        modifier(
            OnScrollModifier(
                coordinateSpace: coordinateSpace,
                minOffset: minOffset,
                upTriggerOffset: upTriggerOffset,
                downTriggerOffset: downTriggerOffset,
                direction: .vertical,
                upAction: action,
                downAction: action
            )
        )
    }
    
    func onScroll(
        coordinateSpace: String,
        minOffset: CGFloat = 16,
        triggerOffset: CGFloat? = nil,
        upAction: @escaping () -> Void,
        downAction: @escaping () -> Void
    ) -> some View {
        modifier(
            OnScrollModifier(
                coordinateSpace: coordinateSpace,
                minOffset: minOffset,
                upTriggerOffset: triggerOffset,
                downTriggerOffset: triggerOffset,
                direction: .vertical,
                upAction: upAction,
                downAction: downAction
            )
        )
    }
    
    func onScroll(
        coordinateSpace: String,
        minOffset: CGFloat = 16,
        upTriggerOffset: CGFloat? = nil,
        downTriggerOffset: CGFloat? = nil,
        upAction: @escaping () -> Void,
        downAction: @escaping () -> Void
    ) -> some View {
        modifier(
            OnScrollModifier(
                coordinateSpace: coordinateSpace,
                minOffset: minOffset,
                upTriggerOffset: upTriggerOffset,
                downTriggerOffset: downTriggerOffset,
                direction: .vertical,
                upAction: upAction,
                downAction: downAction
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
