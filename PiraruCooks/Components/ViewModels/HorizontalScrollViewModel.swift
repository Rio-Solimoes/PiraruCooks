import Foundation
import SwiftUI

@Observable
class HorizontalScrollViewModel {
    var categories: [String]
    let value: ScrollViewProxy
    
    init(categories: [String], value: ScrollViewProxy) {
        self.categories = categories
        self.value = value
    }
    
    func scrollToCategory(named category: String) {
        withAnimation {
            value.scrollTo("\(category)Id", anchor: .top)
        }
    }
}
