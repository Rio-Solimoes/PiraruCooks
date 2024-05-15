import SwiftUI
import Parintins

struct AddressCardView: View {
    var body: some View {
        HStack {
            Shared.home.swiftUIImage
                .padding(.horizontal, 8)
            VStack(alignment: .leading) {
                Text("Casa")
                    .font(.body)
                Text("Av. Alan Turing, 275")
                    .font(.footnote)
                    .fontWeight(.light)
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
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    AddressCardView()
}
