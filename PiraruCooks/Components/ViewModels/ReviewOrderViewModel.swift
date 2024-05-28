//
//  ReviewOrderViewModel.swift
//  PiraruCooks
//
//  Created by João Vitor Gonçalves Oliveira on 27/05/24.
//

import Foundation

@Observable
class ReviewOrderViewModel {
    let priceOptions = ["Crédito", "Débito", "Pix", "Dinheiro"]
    
    var selectedAddress: Address?
    var selectedPaymentOption: String = "Crédito"
    var showFinishOrder: Bool = false
}
