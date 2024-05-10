import SwiftUI

struct ListOfDishesView: View {
    @State var menuController = MenuController.shared
    
    var body: some View {
        VStack {
            ForEach(menuController.categories, id: \.self) { category in
                HStack {
                    Text(category)
                        .font(.title2)
                    Spacer()
                }
                .id("\(category)Id")
                
                ForEach(menuController.dishes.filter({dish in dish.category == category}), id: \.self) {dish in
                    Button {
                        print("AAA")
                    } label: {
                        VStack {
                            HStack {
                                if let dishImage = dish.image {
                                    Image(uiImage: dishImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                } else {
                                    Image(systemName: "fork.knife")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }

                                VStack(alignment: .leading) {
                                    Text(dish.name)
                                        .font(.title3)
                                    Spacer()
                                    Text(dish.detailText)
                                        .font(.body)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                    Text("R$ \(String(format: "%.2f", dish.price))")
                                        .font(.body)
                                }
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 8)
                                .frame(height: getWidth() * 0.25)
                                Spacer()
                                Image(systemName: "chevron.right")
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
    }
}
