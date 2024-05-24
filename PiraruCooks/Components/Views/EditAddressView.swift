//
//  EditAddressView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 23/05/24.
//

import SwiftUI
import Parintins

struct EditAddressView: View {
    @State var viewModel = EditAddressViewModel()
    @Binding var addresses: [Address]
    @Binding var showSheet: Bool
    
    var isFormValid: Bool {
        // Check if all required fields are filled
        return !viewModel.zipCode.isEmpty &&
               !viewModel.street.isEmpty &&
               !viewModel.number.isEmpty &&
               !viewModel.city.isEmpty &&
               viewModel.selectedCategory != nil
    }
    
    var body: some View {
        Form {
            Section(header: Text("Endereço")) {
                AddressRow(label: "Cep", text: $viewModel.zipCode)
                AddressRow(label: "Rua", text: $viewModel.street)
                AddressRow(label: "Número", text: $viewModel.number)
                AddressRow(label: "Obs", text: $viewModel.obs)
                AddressRow(label: "Cidade", text: $viewModel.city)
                AddressRow(label: "Telefone", text: $viewModel.telephone)
            }
            
            Section(header: Text("Tipo")) {
                AddressCategory(
                    image: Shared.Images.home.swiftUIImage,
                    category: "Casa",
                    selectedCategory: $viewModel.selectedCategory
                )
                AddressCategory(
                    image: Shared.Images.work.swiftUIImage,
                    category: "Trabalho",
                    selectedCategory: $viewModel.selectedCategory
                )
                AddressCategory(
                    image: Image(systemName: "mappin.and.ellipse"),
                    category: "Outro",
                    selectedCategory: $viewModel.selectedCategory
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showSheet = false
                } label: {
                    Text("Cancel")
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Detalhes")
                    .fontWeight(.semibold)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let newAddress = Address(
                        zipCode: viewModel.zipCode,
                        street: viewModel.street,
                        number: viewModel.number,
                        obs: viewModel.obs,
                        city: viewModel.city,
                        telephone: viewModel.telephone,
                        category: viewModel.selectedCategory ?? ""
                    )
                    addresses.append(newAddress)
                    showSheet = false
                } label: {
                    Text("Done")
                        .fontWeight(.semibold)
                }
                .disabled(!isFormValid)
            }
        }
    }
}

struct AddressCategory: View {
    @EnvironmentObject private var themeManager: ThemeManager
    var image: Image
    var category: String
    @Binding var selectedCategory: String?
    
    var body: some View {
        HStack {
            image
                .padding(.trailing, 8)
            Text(category)
            
            Spacer()
            
            if selectedCategory == category {
                Image(systemName: "checkmark")
                    .foregroundStyle(themeManager.selectedTheme.primary.swiftUIColor)

            }
        }
        .contentShape(Rectangle()) // Make the whole row tappable
        .onTapGesture {
            selectedCategory = category
        }
    }
}

struct AddressRow: View {
    var label: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: getWidth() * 0.25, alignment: .leading)
            if label == "Obs" || label == "Telefone" {
                TextField("Opcional", text: $text)
            } else {
                TextField("Requerido", text: $text)
            }
        }
    }
}
