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
                            Shared.menu.swiftUIImage
                        }
                        Text("Cardápio")
                            .font(.body)
                    }
                    .onTapGesture {
                        viewModel.selectedTab = "Cardápio"
                    }
                    .tag("Cardápio")
                Text("Buscar")
                    .tabItem {
                        if viewModel.selectedTab == "Buscar" {
                            themeManager.selectedTheme.search.swiftUIImage
                        } else {
                            Shared.search.swiftUIImage
                        }
                        Text("Buscar")
                            .font(.body)
                    }
                    .onTapGesture {
                        viewModel.selectedTab = "Buscar"
                    }
                    .tag("Buscar")
                Text("Pedidos")
                    .tabItem {
                        if viewModel.selectedTab == "Pedidos" {
                            themeManager.selectedTheme.orders.swiftUIImage
                        } else {
                            Shared.orders.swiftUIImage
                        }
                        Text("Pedidos")
                            .font(.body)
                    }
                    .onTapGesture {
                        viewModel.selectedTab = "Pedidos"
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
