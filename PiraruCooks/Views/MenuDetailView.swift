//
//  MenuDetailView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 07/05/24.
//

import SwiftUI

struct MenuDetailView: View {
    var selectedDish: MenuItem?
    var onClose: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Spacer()
                Button("Close") {
                    onClose()
                }
            }
            
            Image("tacaca")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getWidth() * 0.8, height: getWidth() * 0.9)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 16) {
                Text(selectedDish?.name ?? "")
                    .font(.custom("KulimPark-SemiBold", size: 22, relativeTo: .body))
                Text(selectedDish?.detailText ?? "")
                    .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
                Text("R$ \(String(format: "%.2f", selectedDish?.price ?? 00.00))")
                    .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
            }
            Spacer()
        }
        .padding()
    }
}

struct ListOfDishes_Previews: PreviewProvider {
    static var previews: some View {
        let sampleDish = "Sample Dish"
        @State var selectedDish: String? = sampleDish

        return ListOfDishesView()
    }
}
