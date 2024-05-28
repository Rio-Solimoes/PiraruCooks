//
//  FinishOrderView.swift
//  PiraruCooks
//
//  Created by João Vitor Gonçalves Oliveira on 27/05/24.
//

import SwiftUI

struct FinishOrderView: View {
    @State var dismiss: DismissAction
    @State var reviewOrderViewModel: ReviewOrderViewModel
    
    var body: some View {
        VStack {
            HStack {
                Label("Opção de entrega", systemImage: "")
                Spacer()
            }
            if reviewOrderViewModel.selectedAddress != nil {
                HStack {
                    Label("Endereco de entrega", systemImage: "")
                    Spacer()
                }
            }
            HStack {
                Label("Opção de pagamento", systemImage: "")
                Spacer()
            }
            HStack {
                Label("Valor total", systemImage: "")
                Spacer()
            }
            Spacer()
            ButtonView(viewModel: ButtonViewModel(text: "Fazer Pedido", action: {
                reviewOrderViewModel.showFinishOrder = false
                dismiss()
            }))
            Button {
                reviewOrderViewModel.showFinishOrder = false
                dismiss()
            } label: {
                Text("Alterar pedido")
                    .padding(16)
            }
        }
        .padding()
    }
}
