import Foundation
import SwiftUI

@Observable
class HighlightCardViewModel {
    var image: Image
    var title: String
    var description: String
    
    init(image: Image, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
}
