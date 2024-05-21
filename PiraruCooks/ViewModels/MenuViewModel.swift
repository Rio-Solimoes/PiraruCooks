import Foundation
import SwiftUI

@Observable
class MenuViewModel {
    let menuController = MenuController.shared
    var showNavigationBar = false
    var currentShownCategory: String = "Entradas"
    
    func refreshData() {
        menuController.fetchInitialData()
    }
}
