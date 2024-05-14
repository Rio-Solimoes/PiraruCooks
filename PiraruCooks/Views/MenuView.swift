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
