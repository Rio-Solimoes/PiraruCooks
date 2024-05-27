//
//  ReviewOrderView.swift
//  PiraruCooks
//
//  Created by João Vitor Gonçalves Oliveira on 27/05/24.
//

import SwiftUI

/*
struct PriceOption: Identifiable {
    let id = UUID()
    let title: String
}
*/

struct ReviewOrderView: View {
    @State private var selectedOption = "Crédito"
    @State private var address: String = "R. Luverci Pereira De Souza, 1681\nCidade Universitária - Casa"
    
    let priceOptions = ["Crédito","Débito","Pix"]
    var body: some View {
        NavigationStack{
                List{
                    Section(header: Text("Entregar no endereço")) {
                        HStack {
                            Text(address)
                                .padding(.horizontal)
                                .font(.subheadline)
                            
                            Button(action: {})
                            {
                                Text("Trocar")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    Picker("Opções de pagamento", selection: $selectedOption) {
                        ForEach(priceOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)

                }
            HStack {
                Text("Total com a entrega")
                    .font(.headline)
                Spacer()
                Text("R$ 22,63 / 1 item")
                    .font(.headline)
                    .foregroundColor(.green)
            }
                .padding(.horizontal)
                Button(action: {}) {
                    Text("Continuar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .navigationTitle("Sacola")
                .navigationBarTitleDisplayMode(.inline)
            }
    }
}

#Preview {
    ReviewOrderView()
}
