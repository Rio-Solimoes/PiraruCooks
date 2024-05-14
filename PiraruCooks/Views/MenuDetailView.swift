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
    @State var previousViewOffset: CGFloat = 0
    let minimumOffset: CGFloat = 16 // Optional
    @Binding var isMenuDetailScrolling: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
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
                                .frame(width: getWidth() * 0.5, height: getWidth() * 0.5)
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
            .padding(.bottom)
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
            }).onPreferenceChange(ViewOffsetKey.self) { currentOffset in
                let offsetDifference: CGFloat = self.previousViewOffset - currentOffset
                if abs(offsetDifference) > minimumOffset {
                    print("offsetDiference: \(offsetDifference)")
                    print("previousViewOffsset: \(previousViewOffset)")
                    print("currentOffset: \(currentOffset)")
                    if offsetDifference < 0 {
                        isMenuDetailScrolling = true
                    } else if offsetDifference > 20 {
                        isMenuDetailScrolling = false
                    }
                    self.previousViewOffset = currentOffset
                }
            }
        }
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
        .coordinateSpace(name: "scroll")
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
