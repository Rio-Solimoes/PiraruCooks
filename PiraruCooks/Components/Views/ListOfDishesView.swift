import SwiftUI
import Parintins

struct ListOfDishesView: View {
    @State var menuController = MenuController.shared
    @State private var selectedDish: MenuItem?
    @Binding var isHomePresented: Bool

    var body: some View {
        VStack {
            ForEach(menuController.categories, id: \.self) { category in
                HStack {
                    Text(category)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .id("\(category)Id")
                
                ForEach(menuController.dishes.filter({dish in dish.category == category}), id: \.self) {dish in
                    Button {
                        selectedDish = dish
                        isHomePresented.toggle()
                    } label: {
                        DishCardView(viewModel: DishCardViewModel(dish: dish))
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
