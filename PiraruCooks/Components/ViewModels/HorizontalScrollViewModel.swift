import Foundation
import SwiftUI

@Observable
class HorizontalScrollViewModel {
    let value: ScrollViewProxy
    
    init(value: ScrollViewProxy) {
        self.value = value
    }
    
    func scrollToCategory(named category: String) {
        withAnimation {
            value.scrollTo("\(category)Id", anchor: .top)
        }
    }
}
