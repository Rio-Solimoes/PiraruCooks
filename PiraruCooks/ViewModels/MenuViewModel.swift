import Foundation
import SwiftUI

@Observable
class MenuViewModel {
    let menuController = MenuController.shared
    var showNavigationBar = false
    
    func refreshData() {
        menuController.fetchInitialData()
    }
}
