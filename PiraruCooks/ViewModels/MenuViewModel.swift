import Foundation
import SwiftUI

@Observable
class MenuViewModel {
    let menuController = MenuController.shared
    var showNavigationBar = false
    var currentShownCategory: String = "Entradas"
    var willScrollToCategory: Bool = false
    var scrollToStartOffset: CGFloat = -1000000000
    
    func refreshData() {
        menuController.fetchInitialData()
    }
}
