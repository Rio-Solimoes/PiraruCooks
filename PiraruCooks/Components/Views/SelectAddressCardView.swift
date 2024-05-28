//
//  SelectAddressCardView.swift
//  PiraruCooks
//
//  Created by João Vitor Gonçalves Oliveira on 27/05/24.
//

import SwiftUI
import Parintins

struct SelectAddressCardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var reviewOrderViewModel: ReviewOrderViewModel
    @State var address: Address
    
    var body: some View {
        Button {
            reviewOrderViewModel.selectedAddress = address
        } label: {
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
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .foregroundStyle(.black)
        .overlay {
            if reviewOrderViewModel.selectedAddress?.id == address.id {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        themeManager.selectedTheme.primary.swiftUIColor,
                        lineWidth: 2)
            }
        }
    }
}
