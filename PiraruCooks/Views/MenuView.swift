import SwiftUI
import Parintins

struct MenuView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var cloudKit = CloudKitModel()
    @State var menuController = MenuController.shared
    var body: some View {
        NavigationStack {
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
          //      themeManager.selectedTheme.userDefaultsValue = 
                .background {
                    LinearGradient(gradient: Gradient(
                        stops: [
                            .init(color: (themeManager.selectedTheme.primary.swiftUIColor).opacity(0.3), location: 0.0),
                            .init(color: (themeManager.selectedTheme.secondary.swiftUIColor).opacity(0.2), location: 1.0)]),
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 445, height: 204)
                    .offset(x: -21, y: -370)
                    .blur(radius: 8.0)
                }
            }
        }
        .refreshable {
            menuController.fetchInitialData()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    MenuView()
}
