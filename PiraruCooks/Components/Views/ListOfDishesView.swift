import SwiftUI
import Parintins

struct ListOfDishesView: View {
    @State var menuController = MenuController.shared
    @State private var selectedDish: MenuItem?
    @Binding var isHomePresented: Bool
    @Binding var currentShownCategory: String

    var body: some View {
        LazyVStack {
            ForEach(menuController.categories, id: \.self) { category in
                HStack {
                    Text(category)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .id("\(category)Id")
                .onScrollPosition(0.7) {
                    currentShownCategory = category
                }
                ForEach(menuController.dishes.filter({ dish in dish.category == category
                }), id: \.self) { dish in
                    Button {
                        selectedDish = dish
                        isHomePresented.toggle()
                    } label: {
                        VStack {
                            HStack {
                                if dish.image != nil {
                                    Image(uiImage: dish.image!)
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
                                    Text(dish.name)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                    Text(dish.detailText)
                                        .font(.subheadline)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                    Text("R$ \(replaceDotWithComma(String(format: "%.2f", dish.price)))")
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
            }
        }
        .fullScreenCover(isPresented: $isHomePresented) {
            ZStack {
                VStack {
                    MenuDetailView(selectedDish: $selectedDish)
                        .presentationCornerRadius(0)
                }
                .presentationBackgroundInteraction(.enabled)
                .bottomMaskForSheet()
            }
            .presentationBackground(Shared.Colors.darkGray.swiftUIColor.opacity(0.6))
        }
    }
}
