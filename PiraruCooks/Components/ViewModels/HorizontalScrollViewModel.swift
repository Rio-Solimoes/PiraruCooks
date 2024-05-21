import Foundation
import SwiftUI
import Parintins

@Observable
class HorizontalScrollViewModel {
    let value: ScrollViewProxy
    
    init(value: ScrollViewProxy) {
        self.value = value
    }
    
    func getImage(for category: String) -> Image? {
        switch category {
        case "Entradas": return Shared.Images.entrees.swiftUIImage
        case "Caldos e Sopas": return Shared.Images.brothsAndSoups.swiftUIImage
        case "Bebidas": return Shared.Images.drinks.swiftUIImage
        case "Sobremesas": return Shared.Images.desserts.swiftUIImage
        case "Peixes": return Shared.Images.fishes.swiftUIImage
        case "Frutos do Mar": return Shared.Images.seafood.swiftUIImage
        case "Guarnições": return Shared.Images.garnishes.swiftUIImage
        case "Saladas": return Shared.Images.salads.swiftUIImage
        case "Pets": return Shared.Images.pets.swiftUIImage
        default: return nil
        }
    }
    
    func scrollToCategory(named category: String) {
        withAnimation {
            value.scrollTo("\(category)Id", anchor: .top)
        }
    }
}
