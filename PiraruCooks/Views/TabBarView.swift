import SwiftUI
import Parintins

struct TabBarView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.presentationMode) var presentationMode
    @Environment(TabBarViewModel.self) var tabBarViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var isHomePresented = false
    @State var menuController = MenuController.shared
    
    var body: some View {
        @Bindable var tabBarViewModel = tabBarViewModel
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
                SearchView(isHomePresented: $isHomePresented)
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
                if menuController.order.menuItems.count == 0 {
                    EmptyCartView()
                        .tabItem {
                            Image(systemName: "bag")
                            Text("Sacola")
                                .font(.body)
                        }
                        .tag("Sacola")
                } else {
                    CartView()
                        .tabItem {
                            Image(systemName: "bag")
                            Text("Sacola")
                                .font(.body)
                        }
                        .tag("Sacola")
                }
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
