import SwiftUI
import Parintins

struct HorizontalScrollView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State var menuViewModel: MenuViewModel
    @State var viewModel: HorizontalScrollViewModel
    @State var menuController = MenuController.shared

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(menuController.categories, id: \.self) {category in
                    ZStack(alignment: .top) {
                        Button {
                            viewModel.scrollToCategory(named: category)
                            menuViewModel.currentShownCategory = category
                            menuViewModel.willScrollToCategory = true
                            disableScrollActions(types: [.scrollPosition])
                        } label: {
                            VStack {
                                ZStack {
                                    if menuViewModel.currentShownCategory == category {
                                        Circle()
                                            .foregroundStyle(themeManager.selectedTheme.primary.swiftUIColor)
                                    } else {
                                        Circle()
                                            .foregroundStyle(.black)
                                    }
                                    if let image = viewModel.getImage(for: category) {
                                        image
                                            .resizable()
                                            .renderingMode(.template)
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundStyle(.white)
                                            .padding(10)
                                    }
                                }
                                .frame(width: getWidth() * 0.15, height: getWidth() * 0.15)
                                Text(category)
                                    .font(.caption)
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: getWidth() * 0.2)
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 4)
        }
    }
}
