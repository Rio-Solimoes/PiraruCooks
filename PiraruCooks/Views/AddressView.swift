//
//  AddressView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 22/05/24.
//

import SwiftUI
import Parintins

struct AddressView: View {
    @Environment(AddressViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        List {
            if viewModel.addresses.isEmpty {
                AddNewAddressSection(
                    showEditAddressSheet: $viewModel.showEditAddressSheet, 
                    addresses: $viewModel.addresses
                )
            } else {
                SavedAddressesSection(
                    showEditAddressSheet: $viewModel.showEditAddressSheet, 
                    addresses: $viewModel.addresses
                )
                AddNewAddressSection(
                    showEditAddressSheet: $viewModel.showEditAddressSheet,
                    addresses: $viewModel.addresses
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Endereço")
                    .fontWeight(.semibold)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // editar
                } label: {
                    Text("Editar")
                }
            }
        }
    }
}

struct AddNewAddressSection: View {
    @Binding var showEditAddressSheet: Bool
    @Binding var addresses: [Address]
    
    var body: some View {
        Section(
            header: Text(addresses.isEmpty ? "Endereço de entrega" : ""),
            footer: Text("Este endereço de entrega será utilizado quando você fizer compras no PiraruCooks.")
        ) {
            Button {
                showEditAddressSheet.toggle()
            } label: {
                HStack {
                    Text("Adicionar novo endereço")
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Shared.Colors.mediumGray.swiftUIColor)
                        .fontWeight(.semibold)
                }
            }
            .sheet(isPresented: $showEditAddressSheet) {
                NavigationStack {
                    EditAddressView(addresses: $addresses)
                }
            }
        }
    }
}

struct SavedAddressesSection: View {
    @Environment(AddressViewModel.self) var viewModel
    @Binding var showEditAddressSheet: Bool
    @Binding var addresses: [Address]
    
    var body: some View {
        @Bindable var viewModel = viewModel
        Section(
            header: Text("Endereço de entrega"),
            footer: Text("Seu endereço de entrega padrão encontra-se no topo da lista.") +
            Text(" Toque em Editar para reordenar ou remover um endereço de entrega.")
        ) {
            ForEach(addresses) { address in
                SavedAddressView(
                    showEditAddressSheet: $viewModel.showEditAddressSheet, 
                    addresses: $addresses,
                    addressCategory: address.category,
                    addressStreet: address.street,
                    addressNumber: address.number,
                    city: address.city,
                    zipCode: address.zipCode)
            }
        }
    }
}
