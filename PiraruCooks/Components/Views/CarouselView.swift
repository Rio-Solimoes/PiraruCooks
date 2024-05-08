import SwiftUI

struct CarouselView: View {
    @State var viewModel = CarouselViewModel()

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(0..<3) { index in
                Image("Carrousel\(index + 1)")
                    .resizable()
                    .frame(width: getWidth(), height: getHeight() * 0.35)
                    .cornerRadius(3)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle()) // Add PageTabViewStyle for the carousel effect
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    CarouselView()
}
