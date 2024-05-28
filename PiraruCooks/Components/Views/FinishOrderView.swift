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
    @State var menuController = MenuController.shared
    
    var body: some View {
        let selectedAddress = reviewOrderViewModel.selectedAddress
        VStack {
            Text("Revisão do pedido")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            HStack(alignment: .center) {
                Image(systemName: "storefront")
                Text("\(selectedAddress != nil ? "Entregar no endereço" : "Retirar na loja")")
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.vertical, 8)
            if selectedAddress != nil {
                HStack(alignment: .center) {
                    Image(systemName: "\(selectedAddress!.category)")
                    Text("\(selectedAddress!.street), \(selectedAddress!.number)")
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            HStack(alignment: .center) {
                Image(systemName: "creditcard")
                Text("Pagamento na entrega")
                    .fontWeight(.medium)
                Spacer()
                Text("\(reviewOrderViewModel.selectedPaymentOption)")
                    .font(.callout)
            }
            .padding(.vertical, 8)
            HStack(alignment: .center) {
                Image(systemName: "dollarsign.circle")
                Text("Valor total")
                    .fontWeight(.medium)
                Spacer()
                Text("R$ \(replaceDotWithComma(String(format: "%.2f", menuController.order.price)))")
                    .font(.callout)
            }
            .padding(.vertical, 8)
            Spacer()
            ButtonView(viewModel: ButtonViewModel(text: "Fazer Pedido", action: {
                menuController.order = Order()
                reviewOrderViewModel.showFinishOrder = false
                dismiss()
            }))
            Button {
                reviewOrderViewModel.showFinishOrder = false
            } label: {
                Text("Alterar pedido")
                    .padding(16)
            }
        }
        .padding()
    }
}
