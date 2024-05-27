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
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        HStack {
                            Text("Cardápio")
                                .font(.largeTitle)
                                .fontWeight(.bold)
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
                        }
                        Section {
                            ListOfDishesView(
                                isHomePresented: $isHomePresented,
                                currentShownCategory: $viewModel.currentShownCategory
                            )
                                .padding(.horizontal, 16)
                        } header: {
                            HorizontalScrollView(
                                menuViewModel: viewModel,
                                viewModel: HorizontalScrollViewModel(
                                    value: value)
                            )
                            .background {
                                Color.white
                            }
                        }
                    }
                    .onScroll(coordinateSpace: "scroll") { direction, offset in
                        if direction == .up {
                            if offset < 50 {
                                viewModel.showNavigationBar = false
                            }
                        } else {
                            if offset > 5 {
                                viewModel.showNavigationBar = true
                            }
                        }
                    }
                    .onWillScroll { offset in
                        if viewModel.scrollToStartOffset == offset && viewModel.willScrollToCategory {
                            viewModel.willScrollToCategory = false
                            enableScrollAction(types: [.scrollPosition])
                        }
                        viewModel.scrollToStartOffset = offset
                    }
                    .onDidScroll { _ in
                        if viewModel.willScrollToCategory {
                            viewModel.willScrollToCategory = false
                            enableScrollAction(types: [.scrollPosition])
                        }
                    }
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
