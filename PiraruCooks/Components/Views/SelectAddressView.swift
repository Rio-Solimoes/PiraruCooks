//
//  SelectAddressView.swift
//  PiraruCooks
//
//  Created by João Vitor Gonçalves Oliveira on 27/05/24.
//

import SwiftUI
import Parintins

struct SelectAddressView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(AddressViewModel.self) var addressViewModel
    @State var reviewOrderViewModel: ReviewOrderViewModel
    @State var selectedAddress: String = "Entregar no endereço" {
        didSet {
            if selectedAddress == "Retirar na loja" {
                reviewOrderViewModel.selectedAddress = nil
            } else {
                reviewOrderViewModel.selectedAddress = addressViewModel.addresses.first
            }
        }
    }
    
    var body: some View {
        VStack {
            Picker("Opção de Entrega", selection: $selectedAddress) {
                Text("Entregar no endereço").tag("Entregar no endereço")
                Text("Retirar na loja").tag("Retirar na loja")
            }
            .pickerStyle(.segmented)
            .colorMultiply(themeManager.selectedTheme.primary.swiftUIColor)
            .padding()
            if selectedAddress == "Entregar no endereço" {
                List {
                    Section(header: Text("Endereço de entrega")) {
                        ForEach(addressViewModel.addresses) { address in
                            SelectAddressCardView(reviewOrderViewModel: reviewOrderViewModel, address: address)
                        }
                    }
                }
            } else {
                List {
                    Section(header: Text("Endereço da loja")) {
                        Label("Rua Paulo Souza, 987", systemImage: "storefront")
                            .padding()
                    }
                }
            }
            Spacer()
        }
    }
}
