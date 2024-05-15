import SwiftUI

struct ListOfDishesView: View {
    @State var menuController = MenuController.shared
    @State private var selectedDish: MenuItem?
    @State private var isHomePresented = false

    var body: some View {
        VStack {
            ForEach(menuController.categories, id: \.self) { category in
                HStack {
                    Text(category)
                        .font(.custom("KulimPark-SemiBold", size: 22, relativeTo: .title2))
                    Spacer()
                }
                .id("\(category)Id")
                
                ForEach(menuController.dishes.filter({dish in dish.category == category}), id: \.self) {dish in
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
                                    Image("tacaca")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: getWidth() * 0.25, height: getWidth() * 0.25)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }

                                VStack(alignment: .leading) {
                                    Text(dish.name)
                                        .font(.custom("KulimPark-SemiBold", size: 17, relativeTo: .body))
                                    Spacer()
                                    Text(dish.detailText)
                                        .font(.custom("KulimPark-Regular", size: 15, relativeTo: .body))
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                    Text("R$ \(String(format: "%.2f", dish.price))")
                                        .font(.custom("KulimPark-Regular", size: 17, relativeTo: .body))
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
        .fullScreenCover(isPresented: $isHomePresented) {
            VStack {
                MenuDetailView(selectedDish: $selectedDish)
                    .presentationCornerRadius(0)
            }
            .presentationBackgroundInteraction(.enabled)
            .bottomMaskForSheet()
        }
    }
}
