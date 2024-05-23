import SwiftUI
import Parintins

struct MenuView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var cloudKit = CloudKitModel()
    @State var viewModel = MenuViewModel()
    @State private var isHomePresented = false
    
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
                        .foregroundStyle(.black)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        VStack {
                            NavigationLink {
                                AddressView()
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
                        ListOfDishesView(isHomePresented: $isHomePresented)
                            .padding(.horizontal, 16)
                    }
                    .onScroll(coordinateSpace: "scroll", upTriggerOffset: 50, downTriggerOffset: 5,
                              upAction: { viewModel.showNavigationBar = false },
                              downAction: { viewModel.showNavigationBar = true }
                    )
                    .background(alignment: .top) {
                        if themeManager.selectedTheme.userDefaultsValue != "Parintins" {
                            LinearGradient(
                                gradient: Gradient(
                                    stops: [
                                        .init(
                                            color: (themeManager.selectedTheme.primary.swiftUIColor)
                                                .opacity(0.3),
                                            location: 0.0
                                        ),
                                        .init(
                                            color: (themeManager.selectedTheme.tertiary.swiftUIColor)
                                                .opacity(0.2),
                                            location: 1.0
                                        )
                                    ]
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: getWidth() * 1.13, height: getHeight() * 0.24)
                            .offset(x: -(getWidth() * 0.025), y: -(getHeight() * 0.1))
                            .blur(radius: 8)
                        }
                    }
                }
                .coordinateSpace(name: "scroll")
            }
            .navigationTitle("Cardápio")
            .toolbarTitleDisplayMode(.inline)
            .toolbar(viewModel.showNavigationBar ? .visible : .hidden, for: .navigationBar)
        }
        .refreshable {
            viewModel.refreshData()
            viewModel.showNavigationBar = false
        }
    }
}
