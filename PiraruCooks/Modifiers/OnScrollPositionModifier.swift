import Foundation
import SwiftUI

struct OnScrollPositionModifier: ViewModifier {
    @State var id: String = UUID().uuidString
    @State var currentPosition: CGFloat = 0
    @State var triggeredGoingDown: Bool = false
    @State var appearingPosition: CGFloat?
    @State var isAppearing: Bool = false
    
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
                            print(geometry.frame(in: .global).maxY)
                            print(content.getHeight())
                            print(appearingPosition)
                            print()
                        }
                    }
                    .onReceive(OnScrollModifier.previousScrollOffsetPublished
                        .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
                        .eraseToAnyPublisher()
                    ) { _ in
                        OnScrollModifier.updateOnScrollPositionModifier(self, viewHeight: content.getHeight(), geometry: geometry)
//                        if isAppearing && OnScrollModifier.isScrollingTo {
//                            appearingPosition = geometry.frame(in: .global).maxY + OnScrollModifier.previousScrollOffsetPublished.value - content.getHeight()
//                        }
                    }
//                    .onChange(of: OnScrollModifier.updateAppearingPosition) {
//                        //print(OnScrollModifier.updateAppearingPosition)
//                        appearingPosition = geometry.frame(in: .global).maxY - content.getHeight()
//                        print(geometry.frame(in: .global).maxY)
//                        print(content.getHeight())
//                        print(appearingPosition)
//                        print()
//                    }
            })
            .onAppear {
                isAppearing = true
                OnScrollModifier.onScrollPositionActions.append(self)
            }
            .onDisappear {
                isAppearing = false
                appearingPosition = nil
                OnScrollModifier.onScrollPositionActions.removeAll(
                    where: { onScrollPositionModifier in
                        onScrollPositionModifier.id == self.id
                    })
                OnScrollModifier.updateTriggeredGoingDown(for: self)
            }
    }
}

extension View {
    func onScrollPosition(_ targetPosition: CGFloat, action: @escaping () -> Void) -> some View {
        modifier(OnScrollPositionModifier(targetPosition: targetPosition * getHeight(), action: action))
    }
}

extension ScrollViewProxy {
    func scrollTo(_ id: any Hashable, anchor: UnitPoint?, updateOnScroll: Bool?) {
        scrollTo(id, anchor: anchor)
        if let update = updateOnScroll, update {
            OnScrollModifier.isScrollingTo = true
        }
    }
}
