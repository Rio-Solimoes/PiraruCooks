import SwiftUI
import Parintins

struct MenuView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var cloudKit = CloudKitModel()
    @State var menuController = MenuController.shared
    @State var positionHorizontalScroll : CGFloat = 0.0
    @State var scrollViewPosition: CGFloat = 0.0
    @State var isScrollFixed: Bool = false
    @State var previousScrollPosition: CGFloat = 0.0
    var body: some View {
        NavigationStack {
            ScrollViewReader { value in
                ZStack {
                    VStack {
                        if isScrollFixed {
                            HorizontalScrollView(
                                viewModel: HorizontalScrollViewModel(
                                    value: value, initialCategory: "Entradas")
                            )
                        }
                        
                        ScrollView {
                            VStack {
                                Divider()
                                    .padding(.top, 16)
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
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                CarouselView()
                                    .frame(height: getHeight() * 0.35)
                                GeometryReader { geometry in
                                    if !isScrollFixed {
                                        HorizontalScrollView(
                                            viewModel: HorizontalScrollViewModel(
                                                value: value)
                                        )
                                        .id("horizontalScroll")
                                        .onAppear {
                                            self.positionHorizontalScroll = geometry.frame(in: .global).origin.y
                                            print(self.positionHorizontalScroll, "EAI")
                                            // value.scrollTo("horizontalScroll")
                                        }
                                    }
                                    
                                }
                                .onChange(of: scrollViewPosition){
                                    let positionDifference = scrollViewPosition - previousScrollPosition
                                    if positionDifference < 0 {
                                        print("DOWNNN")
                                        if scrollViewPosition < -454.0 {
                                            isScrollFixed = true
                                        }
                                    } else {
                                        print("UPPPP")
                                        if scrollViewPosition > -580 {
                                            isScrollFixed = false
                                        }
                                    }
                                    previousScrollPosition = scrollViewPosition
                                }
                                .frame(height: getHeight() * 0.13) // Garantir que o GeometryReader tenha altura definida
                                
                                
                                ListOfDishesView()
                                    .padding(.horizontal, 20)
                            }
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .named("scrollView")).minY)
                                }
                            )
                            
                        }
                        .onPreferenceChange(ScrollOffsetKey.self) { value in
                            self.scrollViewPosition = value
                            print("Scroll View Position: \(self.scrollViewPosition)")
                        }
                        .coordinateSpace(name: "scrollView")
                    }
                    
                }
                
            }
        }
        .refreshable {
            menuController.fetchInitialData()
        }
    }
}

#Preview {
    MenuView()
}
