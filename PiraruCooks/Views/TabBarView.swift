import SwiftUI
import Parintins

struct TabBarView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        if networkMonitor.isConnected {                
            TabView(selection: $tabBarViewModel.selectedTab) {
                MenuView()
                    .tabItem {
                        if tabBarViewModel.selectedTab == "Cardápio" {
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
                        if tabBarViewModel.selectedTab == "Buscar" {
                            themeManager.selectedTheme.search.swiftUIImage
                        } else {
                            Shared.Images.search.swiftUIImage
                        }
                        Text("Buscar")
                            .font(.body)
                    }
                    .tag("Buscar")
                Text("Pedidos")
                    .tabItem {
                        if tabBarViewModel.selectedTab == "Pedidos" {
                            themeManager.selectedTheme.orders.swiftUIImage
                        } else {
                            Shared.Images.orders.swiftUIImage
                        }
                        Text("Pedidos")
                            .font(.body)
                    }
                    .tag("Pedidos")
            }
            .onChange(of: tabBarViewModel.selectedTab) {
                tabBarViewModel.isDishesDetailPresented = false
                presentationMode.wrappedValue.dismiss()
            }
            .sheet(isPresented: $tabBarViewModel.showSelectTheme) {
                SelectThemeView()
                    .presentationDetents([.medium])
            }
            .onAppear {
                if tabBarViewModel.dismissThemeSelection {
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
