import SwiftUI
import Parintins

struct AddressCardView: View {
    @State var isThereAdress = false
    @Environment(AddressViewModel.self) var viewModel

    var body: some View {
        HStack {
            if viewModel.addresses.isEmpty || viewModel.addresses[0].category == "Casa" {
                Shared.Images.home.swiftUIImage
                    .padding(.horizontal, 8)
            } else if viewModel.addresses[0].category == "Trabalho" {
                Shared.Images.work.swiftUIImage
                    .padding(.horizontal, 8)
            } else {
                Image(systemName: "mappin.and.ellipse")
                    .padding(.horizontal, 8)
            }
                
            VStack(alignment: .leading) {
                if !viewModel.addresses.isEmpty {
                    Text(viewModel.addresses[0].category)
                        .font(.body)
                    Text("\(viewModel.addresses[0].street), \(viewModel.addresses[0].number)")
                        .font(.footnote)
                        .fontWeight(.light)
                } else {
                    Text("Adicione novo endereço")
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
