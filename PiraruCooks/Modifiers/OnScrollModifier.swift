import Foundation
import SwiftUI

// swiftlint:disable identifier_name
enum ScrollDirection {
    case up
    case down
}
// swiftlint:enable identifier_name

struct OnScrollModifier: ViewModifier {
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
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named(coordinateSpace)).origin.y)
            }).onPreferenceChange(ViewOffsetKey.self) { currentOffset in
                guard let action = action else {
                    return
                }
                let offsetDifference: CGFloat = previousScrollOffset - currentOffset
                if abs(offsetDifference) > minOffset {
                    previousScrollOffset = currentOffset
                    if offsetDifference > 0 {
                        action(.up, currentOffset)
                    } else {
                        action(.down, currentOffset)
                    }
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
