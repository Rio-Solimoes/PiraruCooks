import Foundation
import SwiftUI

@Observable
class MenuViewModel {
    let menuController = MenuController.shared
    var showNavigationBar = false
    var currentShownCategory: String = "Entradas"
    var selectedCategory: String?
    
    func refreshData() {
        menuController.fetchInitialData()
    }
}
