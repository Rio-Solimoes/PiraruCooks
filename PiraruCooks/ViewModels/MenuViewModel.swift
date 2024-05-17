import Foundation
import SwiftUI

@Observable
class MenuViewModel {
    let menuController = MenuController.shared
    var showNavigationBar = false
    var currentShownCategory: String = "" {
        didSet {
            print(currentShownCategory)
        }
    }
    
    func refreshData() {
        menuController.fetchInitialData()
    }
}
