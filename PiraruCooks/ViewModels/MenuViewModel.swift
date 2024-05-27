import Foundation
import SwiftUI

@Observable
class MenuViewModel {
    let menuController = MenuController.shared
    var showNavigationBar = false
    var currentShownCategory: String = "Entradas"
    var userIsScrolling: Bool = false
    var willScrollToCategory: Bool = false
    
    func refreshData() {
        menuController.fetchInitialData()
    }
}
