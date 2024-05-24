import Foundation

@Observable
class DishCardViewModel {
    var dish: MenuItem
    
    init(dish: MenuItem) {
        self.dish = dish
    }
}
