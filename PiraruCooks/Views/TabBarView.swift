import SwiftUI

struct TabBarView: View {
    @State var viewModel = TabBarViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Cardápio")
                    .font(.custom("KulimPark-SemiBold", size: 34, relativeTo: .largeTitle))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image("Perfil")
                    .frame(width: getWidth() * 0.1, height: getWidth() * 0.1)
            }
            .padding(.horizontal, 20)

            Spacer()

            TabView(selection: $viewModel.selectedTab) {
                MenuView()
                    .tabItem {
                        Image("Cardápio\(viewModel.selectedTab == "Cardápio" ? "_Selecionado" : "")")
                        Text("Cardápio")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                    }
                    .onTapGesture {
                        viewModel.selectedTab = "Cardápio"
                    }
                    .tag("Cardápio")
                Text("Buscar")
                    .tabItem {
                        Image("Buscar\(viewModel.selectedTab == "Buscar" ? "_Selecionado" : "")")
                        Text("Buscar")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                    }
                    .onTapGesture {
                        viewModel.selectedTab = "Buscar"
                    }
                    .tag("Buscar")
                Text("Pedidos")
                    .tabItem {
                        Image("Pedidos\(viewModel.selectedTab == "Pedidos" ? "_Selecionado" : "")")
                        Text("Pedidos")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                    }
                    .onTapGesture {
                        viewModel.selectedTab = "Pedidos"
                    }
                    .tag("Pedidos")
            }
        }
    }
}

#Preview {
    TabBarView()
}
