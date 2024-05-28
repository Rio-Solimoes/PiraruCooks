import SwiftUI
import Parintins

struct ReviewOrderView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AddressViewModel.self) var addressViewModel
    @State var menuController = MenuController.shared
    @State var viewModel = ReviewOrderViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Endereço de \(viewModel.selectedAddress != nil ? "Entrega" : "Retirada")")) {
                    ZStack {
                        NavigationLink("", destination: SelectAddressView(reviewOrderViewModel: viewModel))
                        Color.white
                        if let address = viewModel.selectedAddress {
                            HStack(spacing: 24) {
                                if address.category == "Casa" {
                                    Shared.Images.home.swiftUIImage
                                        .padding(.leading, 6)
                                } else if address.category == "Trabalho" {
                                    Shared.Images.work.swiftUIImage
                                        .padding(.leading, 6)
                                } else {
                                    Image(systemName: "mappin.and.ellipse")
                                        .padding(.leading, 6)
                                }
                                
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(address.category)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 3)
                                    
                                    Text("\(address.street) \(address.number)")
                                    Text(address.city)
                                    Text(address.zipCode)
                                }
                                .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Shared.Colors.mediumGray.swiftUIColor)
                                .fontWeight(.semibold)
                        } else {
                            HStack {
                                Label("Rua Paulo Souza, 987", systemImage: "storefront")
                                    .padding()
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Shared.Colors.mediumGray.swiftUIColor)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                Picker("Opção de Pagamento", selection: $viewModel.selectedPaymentOption) {
                    ForEach(viewModel.priceOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
            }
            HStack {
                Text("Total com a entrega")
                    .font(.headline)
                Spacer()
                Text("R$ \(replaceDotWithComma(String(format: "%.2f", menuController.order.price)))")
                    .font(.headline)
            }
            .padding(.horizontal)
            ButtonView(viewModel: ButtonViewModel(text: "Revisar Pedido", action: {
                viewModel.showFinishOrder = true
            }))
            .padding()
            .navigationTitle("Confirmar Itens")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }
                }
            }
        }
        .onAppear {
            viewModel.selectedAddress = addressViewModel.addresses.first
        }
        .sheet(isPresented: $viewModel.showFinishOrder) {
            FinishOrderView(dismiss: dismiss, reviewOrderViewModel: viewModel)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    ReviewOrderView()
}
