//
//  ReviewOrderView.swift
//  PiraruCooks
//
//  Created by João Vitor Gonçalves Oliveira on 27/05/24.
//

import SwiftUI

struct ReviewOrderView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AddressViewModel.self) var addressViewModel
    @State var viewModel = ReviewOrderViewModel()
    
    var body: some View {
        SelectAddressView(reviewOrderViewModel: viewModel)
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
