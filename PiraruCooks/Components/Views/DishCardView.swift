import SwiftUI
import Parintins

struct DishCardView: View {
    @State var viewModel: DishCardViewModel
    
    var body: some View {
        VStack {
            HStack {
                if viewModel.dish.image != nil {
                    Image(uiImage: viewModel.dish.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Shared.Images.emptyDish.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                VStack(alignment: .leading) {
                    Text(viewModel.dish.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    Text(viewModel.dish.detailText)
                        .font(.subheadline)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    Text("R$ \(replaceDotWithComma(String(format: "%.2f", viewModel.dish.price)))")
                        .font(.subheadline)
                }
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 8)
                .frame(height: getWidth() * 0.25)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Shared.Colors.mediumGray.swiftUIColor)
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 8)
            .foregroundStyle(.black)
            Divider()
                .padding(.vertical, 8)
        }
    }
}
