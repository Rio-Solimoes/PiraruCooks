import SwiftUI
import Parintins

struct MenuView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var cloudKit = CloudKitModel()
    @State var menuController = MenuController.shared
    @State var showNavigationBar = false
    @State var previousScrollOffset: CGFloat = 0
    let minimumOffset: CGFloat = 16
    
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
                            Divider()
                                .padding(.top, 8)
                            NavigationLink {
                                Text("Endereços")
                                    .font(.body)
                            } label: {
                                HStack {
                                    Shared.home.swiftUIImage
                                        .padding(.horizontal, 8)
                                    VStack(alignment: .leading) {
                                        Text("Casa")
                                            .font(.body)
                                        Text("Av. Alan Turing, 275")
                                            .font(.body)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing)
                                }
                                .foregroundStyle(.black)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                            }
                            Divider()
                                .padding(.bottom, 16)
                            HStack {
                                Text("Destaques")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            CarouselView()
                                .frame(height: getHeight() * 0.35)
                            HorizontalScrollView(
                                viewModel: HorizontalScrollViewModel(
                                    value: value)
                            )
                        }
                        ListOfDishesView()
                            .padding(.horizontal, 20)
                    }
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                    }).onPreferenceChange(ViewOffsetKey.self) { currentOffset in
                        let offsetDifference: CGFloat = self.previousScrollOffset - currentOffset
                        if abs(offsetDifference) > minimumOffset {
                            if offsetDifference > 0 {
                                print("Is scrolling up toward top.")
                                if currentOffset < 50 {
                                    showNavigationBar = false
                                }
                            } else {
                                print("Is scrolling down toward bottom.")
                                if currentOffset > 5 {
                                    showNavigationBar = true
                                }
                            }
                            self.previousScrollOffset = currentOffset
                        }
                    }
                }.coordinateSpace(name: "scroll")
            }
            .navigationTitle("Cardápio")
            .toolbarTitleDisplayMode(.inline)
            .toolbar(showNavigationBar ? .visible : .hidden, for: .navigationBar)
        }
        .refreshable {
            menuController.fetchInitialData()
            showNavigationBar = false
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    MenuView()
}
