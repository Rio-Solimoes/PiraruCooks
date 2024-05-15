//
//  SnapCarouselView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 14/05/24.
//

import SwiftUI

struct SnapCarouselView<Content: View, T: Identifiable>: View {
    @Binding var index: Int
    var content: (T) -> Content
    var list: [T]
    var spacing: CGFloat
    var trailingSpace: CGFloat
    var initialIndex: Int

    @GestureState private var offset: CGFloat = 0
    @State private var currentIndex: Int = 0

    init(spacing: CGFloat = 15,
         trailingSpace: CGFloat = 100,
         index: Binding<Int>,
         initialIndex: Int,
         items: [T],
         @ViewBuilder content: @escaping (T) -> Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.initialIndex = initialIndex
        self.content = content
    }

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustmentWidth = (trailingSpace / 2) - spacing

            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: calculateOffset(width: width, adjustmentWidth: adjustmentWidth))
            .gesture(dragGesture(width: width))
            .onAppear {
                currentIndex = initialIndex
                index = initialIndex
            }
        }
        .animation(.easeInOut, value: offset == 0)
    }

    private func calculateOffset(width: CGFloat, adjustmentWidth: CGFloat) -> CGFloat {
        return (CGFloat(currentIndex) * -width) + adjustmentWidth + offset
    }

    private func dragGesture(width: CGFloat) -> some Gesture {
        DragGesture()
            .updating($offset) { value, out, _ in
                out = value.translation.width
            }
            .onEnded { value in
                updateIndex(onEnd: value, width: width)
            }
            .onChanged { value in
                updateIndex(onChange: value, width: width)
            }
    }

    private func updateIndex(onEnd value: DragGesture.Value, width: CGFloat) {
        let offsetX = value.translation.width
        let progress = -offsetX / width
        let roundIndex = progress.rounded()
        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
        index = currentIndex
    }

    private func updateIndex(onChange value: DragGesture.Value, width: CGFloat) {
        let offsetX = value.translation.width
        let progress = -offsetX / width
        let roundIndex = progress.rounded()
        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
    }
}
