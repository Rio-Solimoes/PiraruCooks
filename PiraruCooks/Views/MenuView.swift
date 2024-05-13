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
                                .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                        } label: {
                            HStack {
                                Shared.home.swiftUIImage
                                    .padding(.horizontal, 8)
                                VStack(alignment: .leading) {
                                    Text("Casa")
                                        .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                                    Text("Av. Alan Turing, 275")
                                        .font(.custom("KulimPark-Light", size: 17, relativeTo: .body))
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
                                .font(.custom("KulimPark-SemiBold", size: 22, relativeTo: .title2))
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
