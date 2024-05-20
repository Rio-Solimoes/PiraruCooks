import SwiftUI
import Parintins

struct HighlightCardView: View {
    @State var viewModel: HighlightCardViewModel
    
    var body: some View {
        ZStack {
            viewModel.image
                .resizable()
            VStack {
                Spacer()
                 HStack {
                     VStack(alignment: .leading) {
                        Text(viewModel.title)
                            .font(.caption2)
                            .fontWeight(.medium)
                        Text(viewModel.description)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                }
                 .padding(.horizontal, 16)
                 .padding(.vertical, 8)
                .frame(maxWidth: .infinity, minHeight: getHeight() * 0.085)
                .background {
                    LinearGradient(
                        colors: [
                            Shared.Colors.highlightGradient.swiftUIColor.opacity(0.68),
                            Shared.Colors.highlightGradient.swiftUIColor
                        ],
                        startPoint: .top,
                        endPoint: UnitPoint(x: 0.5, y: 0.3)
                    )
                }
            }
        }
        .frame(width: getWidth() * 0.82, height: getHeight() * 0.23)
        .cornerRadius(16)
    }
}

#Preview {
    HighlightCardView(viewModel: HighlightCardViewModel(
        image: Image("Carrousel2"),
        title: "Clima de festival",
        description: "Escolha seu boi favorito e aproveite o festival no seu estilo!"
    ))
}
