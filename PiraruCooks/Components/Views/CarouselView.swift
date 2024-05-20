import Foundation
import SwiftUI

struct CarouselView: View {
    @State var viewModel = CarouselViewModel()
    @GestureState var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let trailingSpace: CGFloat = getWidth() * 0.18
            let spacing: CGFloat = 8
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing) {
                ForEach(0..<3) { _ in
                    HighlightCardView(viewModel: HighlightCardViewModel(
                        image: Image("Carrousel2"),
                        title: "Clima de festival",
                        description: "Escolha o seu boi favorito e aproveite o festival no seu estilo!"
                    ))
                }
            }
            .padding(.leading, 2 * spacing)
            .padding(.trailing, spacing)
            .offset(
                x: (CGFloat(viewModel.currentIndex) * -width)
                + (viewModel.currentIndex != 0 ? adjustMentWidth : 0)
                + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        viewModel.currentIndex = max(min(viewModel.currentIndex + Int(roundIndex), 2), 0)
                        viewModel.currentIndex = viewModel.index
                    })
                    .onChanged({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        viewModel.index = max(min(viewModel.currentIndex + Int(roundIndex), 2), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}
