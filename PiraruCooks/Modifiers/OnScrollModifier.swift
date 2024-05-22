import Foundation
import SwiftUI
import Combine

// swiftlint:disable identifier_name
enum ScrollDirection {
    case up
    case down
}
// swiftlint:enable identifier_name

struct OnScrollModifier: ViewModifier {
    static var onScrollPositionActions: [OnScrollPositionModifier] = []
    static var onDidScrollActions: [OnDidScrollModifier] = []
    static var onWillScrollActions: [OnWillScrollModifier] = []
    static var startedScrolling: Bool = false
    static var isScrollingTo: Bool = false
    
    @State var previousScrollOffset: CGFloat = 0
    @State static var previousScrollOffsetPublished: CurrentValueSubject<CGFloat, Never> = CurrentValueSubject<CGFloat, Never>(0)
    @State var isScrolling = false
    @State var isInitCall = true
    @State static var lastScrollDirection: ScrollDirection = .down
    
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
    
    static func updateOnScrollPositionModifier(_ onScrollPositionModifier: OnScrollPositionModifier,
                                        viewHeight: CGFloat,
                                        geometry: GeometryProxy
    ) {
        if onScrollPositionModifier.isAppearing && OnScrollModifier.isScrollingTo {
            onScrollPositionModifier.appearingPosition = geometry.frame(in: .global).maxY + OnScrollModifier.previousScrollOffsetPublished.value - viewHeight
        }
    }
    
    static func updateTriggeredGoingDown(for onScrollPositionModifier: OnScrollPositionModifier) {
        if lastScrollDirection == .down {
            onScrollPositionModifier.triggeredGoingDown = true
        } else if lastScrollDirection == .up {
            onScrollPositionModifier.triggeredGoingDown = false
        }
    }
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: ViewOffsetKey.self,
                        value: -geometry.frame(in: .named(coordinateSpace)).origin.y)
            }).onPreferenceChange(ViewOffsetKey.self) { currentOffset in
                if isInitCall {
                    return
                }
                OnScrollModifier.startedScrolling = true
                if !isScrolling {
                    isScrolling = true
                    OnScrollModifier.onWillScrollActions.forEach({ onWillScrollModifier in
                        guard let action = onWillScrollModifier.action else {
                            return
                        }
                        action()
                    })
                }
                let offsetDifference: CGFloat = previousScrollOffset - currentOffset
                var scrollDirection: ScrollDirection = .down
                if offsetDifference > 0 {
                    scrollDirection = .up
                    OnScrollModifier.lastScrollDirection = scrollDirection
                }
                OnScrollModifier.onScrollPositionActions.forEach({ onScrollPositionModifier in
                    guard let action = onScrollPositionModifier.action else {
                        return
                    }
                    var appearingPosition: CGFloat = 1000000000
                    if let position = onScrollPositionModifier.appearingPosition {
                        appearingPosition = position
                    } else {
                        let adjustAppearingPosition = scrollDirection == .down ? 0 : content.getHeight()
                        appearingPosition = currentOffset - adjustAppearingPosition
                        onScrollPositionModifier.appearingPosition = appearingPosition
                    }
                    let offsetDifference = currentOffset - appearingPosition
                    print(currentOffset)
                    print(appearingPosition)
                    print(offsetDifference)
                    print(onScrollPositionModifier.targetPosition)
                    print(scrollDirection)
                    print(onScrollPositionModifier.triggeredGoingDown)
                    print()
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
                OnScrollModifier.previousScrollOffsetPublished.send(currentOffset)
            }
            .onReceive(OnScrollModifier.previousScrollOffsetPublished
                .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
            ) { _ in
                if isInitCall {
                    isInitCall = false
                    return
                }
                isScrolling = false
                OnScrollModifier.isScrollingTo = false
                OnScrollModifier.onDidScrollActions.forEach({ onDidScrollModifier in
                    guard let action = onDidScrollModifier.action else {
                        return
                    }
                    action()
                })
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
