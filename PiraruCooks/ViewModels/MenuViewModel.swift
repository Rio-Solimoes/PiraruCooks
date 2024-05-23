import Foundation
import SwiftUI

@Observable
class MenuViewModel {
    let menuController = MenuController.shared
    var showNavigationBar = false
    var currentShownCategory: String = "Entradas"
    var willScrollToCategory: Bool = false
    var isScrollingToCategory: Bool = false
    
    func refreshData() {
        menuController.fetchInitialData()
    }
}
