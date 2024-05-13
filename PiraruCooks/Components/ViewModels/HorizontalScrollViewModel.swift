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
        case "Entradas": return Shared.entrees.swiftUIImage
        case "Caldos e Sopas": return Shared.brothsAndSoups.swiftUIImage
        case "Bebidas": return Shared.drinks.swiftUIImage
        case "Sobremesas": return Shared.desserts.swiftUIImage
        case "Peixes": return Shared.fishes.swiftUIImage
        case "Frutos do Mar": return Shared.seafood.swiftUIImage
        case "Guarnições": return Shared.garnishes.swiftUIImage
        case "Saladas": return Shared.salads.swiftUIImage
        default: return nil
        }
    }
    
    func scrollToCategory(named category: String) {
        withAnimation {
            value.scrollTo("\(category)Id", anchor: .top)
        }
    }
}
