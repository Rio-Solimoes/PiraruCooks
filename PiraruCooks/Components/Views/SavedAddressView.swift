//
//  SavedAddressView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 23/05/24.
//

import SwiftUI
import Parintins

struct SavedAddressView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Binding var showEditAddressSheet: Bool
    @Binding var addresses: [Address]
    var addressCategory: String
    var addressStreet: String
    var addressNumber: String
    var city: String
    var zipCode: String

    var body: some View {
        Button {
            showEditAddressSheet.toggle()
        } label: {
            HStack(spacing: 24) {
                if addressCategory == "Casa" {
                    Shared.Images.home.swiftUIImage
                        .padding(.leading, 6)
                } else if addressCategory == "Trabalho" {
                    Shared.Images.work.swiftUIImage
                        .padding(.leading, 6)
                } else {
                    Image(systemName: "mappin.and.ellipse")
                        .padding(.leading, 6)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(addressCategory)
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.bottom, 3)
                    
                    Text("\(addressStreet) \(addressNumber)")
                    Text(city)
                    Text(zipCode)
                }
                .font(.subheadline)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Shared.Colors.mediumGray.swiftUIColor)
                    .fontWeight(.semibold)
            }
        }
        .foregroundStyle(.black)
        .sheet(isPresented: $showEditAddressSheet) {
            NavigationStack {
                EditAddressView(addresses: $addresses)
            }
        }
    }
}
