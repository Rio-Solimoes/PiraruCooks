import SwiftUI

struct HorizontalScrollView: View {
    @State var viewModel: HorizontalScrollViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(viewModel.categories, id: \.self) {category in
                    ZStack(alignment: .top) {
                        Color.white
                        Button {
                            viewModel.scrollToCategory(named: category)
                        } label: {
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundStyle(Color("Pink"))
                                    Image(category)
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundStyle(.white)
                                        .padding(10)
                                }
                                .frame(width: getWidth() * 0.15, height: getWidth() * 0.15)
                                Text(category)
                                    .font(.custom("KulimPark-Regular", size: 12, relativeTo: .caption))
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: getWidth() * 0.2)
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 4)
        }
    }
}
