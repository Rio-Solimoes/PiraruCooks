import SwiftUI
import Parintins

struct MenuView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var cloudKit = CloudKitModel()
    @State var menuController = MenuController.shared
    var body: some View {
        
        ScrollViewReader { value in
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
                    HorizontalScrollView(
                        viewModel: HorizontalScrollViewModel(
                            value: value)
                    )
                }
                ListOfDishesView()
                    .padding(.horizontal, 20)
            }
            .background {
                LinearGradient(gradient: Gradient(colors:
                    [themeManager.selectedTheme.primary.swiftUIColor,
                    themeManager.selectedTheme.secondary.swiftUIColor]),
                               startPoint: .topLeading, endPoint: .init(x: 1.0, y: 0.5))
                .frame(width: 445, height: 153)
                .offset(x: 0, y: -400)
                .blur(radius: 120)
            }
            .refreshable {
                menuController.fetchInitialData()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}
