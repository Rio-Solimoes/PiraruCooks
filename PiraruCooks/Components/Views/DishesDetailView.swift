//
//  DishesDetailView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 14/05/24.
//

import SwiftUI

struct DishesDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var viewModel = DishesDetailViewModel()
    @Binding var isMenuDetailScrolling: Bool
    var selectedDish: MenuItem?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 32) {
                closeButton
                dishImage
                dishInformation
                orderInformation
                addOrderButton
            }
            .padding()
            .padding(.bottom)
            .background(scrollOffsetPreference)
            .onPreferenceChange(ViewOffsetKey.self, perform: handlePreferenceChange)
        }
        .modifier(BouncesModifier())
        .coordinateSpace(name: "scroll")
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private var dishImage: some View {
        Image(uiImage: selectedDish?.image ?? UIImage(named: "tacaca")!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: getWidth() * 0.8, height: getWidth() * 0.9)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var dishInformation: some View {
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
    }
    
    private var orderInformation: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Quantidade:")
                    .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                Spacer()
                Stepper(value: $viewModel.stepperValue, in: 0...Int.max) {
                    Text("\(viewModel.stepperValue)")
                }
            }
            Text("Obs:")
            HStack {
                Spacer()

                VStack(spacing: 24) {
                    TextField("Type something here...", text: $viewModel.textFieldText, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: getWidth() * 0.5, height: getWidth() * 0.5)
                }
                Spacer()
            }
        }
    }
    
    private var addOrderButton: some View {
        Button {
            // Action
        } label: {
            Text("Adicionar aos pedidos")
                .font(.custom("KulimPark-Regular", size: 15, relativeTo: .body))
                .foregroundColor(viewModel.stepperValue > 0 ? .white : .black.opacity(0.5))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(viewModel.stepperValue > 0 ? .accentColor : .gray.opacity(0.5))
                )
        }
    }
    
    private var scrollOffsetPreference: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: ViewOffsetKey.self, value: -geometry.frame(in: .named("scroll")).origin.y)
        }
    }
    
    // Identifies the position on which the view is being scrolled
    func handlePreferenceChange(currentOffset: CGFloat) {
        let offsetDifference: CGFloat = viewModel.previousViewOffset - currentOffset
        if abs(offsetDifference) > viewModel.minimumOffset {
            if offsetDifference < 0 {
                isMenuDetailScrolling = true
            } else if offsetDifference > 20 {
                isMenuDetailScrolling = false
            }
            self.viewModel.previousViewOffset = currentOffset
        }
    }
}
