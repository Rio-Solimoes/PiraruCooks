//
//  MenuDetailView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 07/05/24.
//

import SwiftUI

struct MenuDetailView: View {
    @State var stepperValue: Int = 0
    @State var textFieldText: String = ""
    var selectedDish: MenuItem?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Botão de fechar
                HStack {
                    Spacer()
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss() 
                    }
                }
                
                // Imagem do prato
                Image(uiImage: selectedDish?.image ?? UIImage(named: "tacaca")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getWidth() * 0.8, height: getWidth() * 0.9)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                // Informações do prato
                VStack(alignment: .leading, spacing: 16) {
                    Text(selectedDish?.name ?? "")
                        .font(.custom("KulimPark-SemiBold", size: 22, relativeTo: .body))
                    Text(selectedDish?.detailText ?? "")
                        .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                        .fixedSize(horizontal: false, vertical: true)
                    Text("R$ \(String(format: "%.2f", selectedDish?.price ?? 00.00))")
                        .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))

                    Divider()
                }
                
                // Informações do pedido
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Quantidade:")
                            .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                        Spacer()
                        Stepper(value: $stepperValue, in: 0...Int.max) {
                            Text("\(stepperValue)")
                        }
                    }
                    Text("Obs:")
                    HStack {
                        Spacer()

                        VStack(spacing: 24) {
                            TextField("Type something here...", text: $textFieldText, axis: .vertical)
                                .textFieldStyle(.roundedBorder)
                        }
                        Spacer()
                    }
                }
                
                // Botão de adicionar aos pedidos
                Button {
                    // Action
                } label: {
                    Text("Adicionar aos pedidos")
                        .font(.custom("KulimPark-Regular", size: 15, relativeTo: .body))
                        .foregroundColor(stepperValue > 0 ? .white : .black.opacity(0.5))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 13)
                                .foregroundColor(stepperValue > 0 ? .accentColor : .gray.opacity(0.5))
                        )
                }
            }
            .padding()
        }
    }
}
