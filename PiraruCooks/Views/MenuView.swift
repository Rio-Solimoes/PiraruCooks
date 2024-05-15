import SwiftUI
import Parintins

struct MenuView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var cloudKit = CloudKitModel()
    @State var viewModel = MenuViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { value in
                ScrollView {
                    LazyVStack {
                        HStack {
                            Text("Cardápio")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            themeManager.selectedTheme.profileDefault.swiftUIImage
                                .resizable()
                                .frame(width: getWidth() * 0.1, height: getWidth() * 0.1)
                        }
                        .padding(.horizontal, 20)
                        VStack {
                            NavigationLink {
                                Text("Endereços")
                                    .font(.body)
                            } label: {
                                AddressCardView()
                            }
                            .padding(.bottom, 16)
                            HStack {
                                Text("Destaques")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            CarouselView()
                                .frame(height: getHeight() * 0.23)
                            HorizontalScrollView(
                                viewModel: HorizontalScrollViewModel(
                                    value: value)
                            )
                        }
                        ListOfDishesView()
                            .padding(.horizontal, 16)
                    }
                    .onScroll(coordinateSpace: "scroll", upTriggerOffset: 50, downTriggerOffset: 5,
                              upAction: { viewModel.showNavigationBar = false },
                              downAction: { viewModel.showNavigationBar = true }
                    )
                    ListOfDishesView()
                        .padding(.horizontal, 20)
                }
                .coordinateSpace(name: "scroll")
                .background {
                    LinearGradient(gradient: Gradient(colors:
                        [themeManager.selectedTheme.primary.swiftUIColor,
                        themeManager.selectedTheme.secondary.swiftUIColor]),
                                   startPoint: .topLeading, endPoint: .init(x: 1.0, y: 0.5))
                    .frame(width: 445, height: 153)
                    .offset(x: 0, y: -400)
                    .blur(radius: 120)
                }
            }
            .navigationTitle("Cardápio")
            .toolbarTitleDisplayMode(.inline)
            .toolbar(viewModel.showNavigationBar ? .visible : .hidden, for: .navigationBar)
        }
        .refreshable {
            viewModel.refreshData()
            viewModel.showNavigationBar = false
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    MenuView()
}
