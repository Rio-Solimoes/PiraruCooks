import SwiftUI
import Parintins

struct TabBarView: View {
    @Environment(ThemeService.self) private var themeService
    @State var viewModel = TabBarViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Cardápio")
                    .font(.custom("KulimPark-SemiBold", size: 34, relativeTo: .largeTitle))
                    .frame(maxWidth: .infinity, alignment: .leading)
                themeService.selectedTheme.profileDefault.swiftUIImage
                    .resizable()
                    .frame(width: getWidth() * 0.1, height: getWidth() * 0.1)                
            }
            .padding(.horizontal, 20)

            Spacer()

            TabView(selection: $viewModel.selectedTab) {
                MenuView()
                    .tabItem {
                        if viewModel.selectedTab == "Cardápio" {
                            themeService.selectedTheme.menu.swiftUIImage
                        } else {
                            Shared.menu.swiftUIImage
                        }
                        Text("Cardápio")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                    }
                    .onTapGesture {
                        viewModel.selectedTab = "Cardápio"
                    }
                    .tag("Cardápio")
                Text("Buscar")
                    .tabItem {
                        if viewModel.selectedTab == "Buscar" {
                            themeService.selectedTheme.search.swiftUIImage
                        } else {
                            Shared.search.swiftUIImage
                        }
                        Text("Buscar")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                    }
                    .onTapGesture {
                        viewModel.selectedTab = "Buscar"
                    }
                    .tag("Buscar")
                Text("Pedidos")
                    .tabItem {
                        if viewModel.selectedTab == "Pedidos" {
                            themeService.selectedTheme.orders.swiftUIImage
                        } else {
                            Shared.orders.swiftUIImage
                        }
                        Text("Pedidos")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                    }
                    .onTapGesture {
                        viewModel.selectedTab = "Pedidos"
                    }
                    .tag("Pedidos")
            }
//            .accentColor(Color("Pink"))
        }
    }
}

#Preview {
    TabBarView()
}
