import SwiftUI
import Parintins

struct TabBarView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State var viewModel = TabBarViewModel()
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        if networkMonitor.isConnected {                
            TabView(selection: $viewModel.selectedTab) {
                MenuView()
                    .tabItem {
                        if viewModel.selectedTab == "Cardápio" {
                            themeManager.selectedTheme.menu.swiftUIImage
                        } else {
                            Shared.Images.menu.swiftUIImage
                        }
                        Text("Cardápio")
                            .font(.body)
                    }
                    .tag("Cardápio")
                Text("Buscar")
                    .tabItem {
                        if viewModel.selectedTab == "Buscar" {
                            themeManager.selectedTheme.search.swiftUIImage
                        } else {
                            Shared.Images.search.swiftUIImage
                        }
                        Text("Buscar")
                            .font(.body)
                    }
                    .tag("Buscar")
                CartView()
                    .tabItem {
                        if viewModel.selectedTab == "Pedidos" {
                            themeManager.selectedTheme.orders.swiftUIImage
                        } else {
                            Shared.Images.orders.swiftUIImage
                        }
                        Text("Pedidos")
                            .font(.body)
                    }
                    .tag("Pedidos")
            }
            .sheet(isPresented: $viewModel.showSelectTheme) {
                SelectThemeView()
            }
            .onAppear {
                if viewModel.dismissThemeSelection {
                    themeManager.selectedTheme = Themes.Parintins.shared
                }
            }
        } else {
            NoNetworkView()
        }
    }
}

    /*
     #Preview {
     TabBarView().environmentObject(NetworkMonitor())
     }
     */
