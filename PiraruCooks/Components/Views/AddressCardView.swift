import SwiftUI
import Parintins

struct AddressCardView: View {
    @State var isThereAdress = false
    var body: some View {
        HStack {
            Shared.Images.home.swiftUIImage
                .padding(.horizontal, 8)
            
            VStack(alignment: .leading) {
                if isThereAdress {
                    Text("Casa")
                        .font(.body)
                    Text("Av. Alan Turing, 275")
                        .font(.footnote)
                        .fontWeight(.light)
                } else {
                    Text("Adicione um endereço")
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .padding(.trailing)
        }
        .foregroundStyle(.black)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 0.5)
        )
        .background {
            Color.white
                .clipShape(
                    RoundedRectangle(cornerRadius: 8)
                )
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    AddressCardView()
}
