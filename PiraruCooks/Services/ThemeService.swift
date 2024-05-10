import Foundation
import Parintins
import SwiftUI

@Observable
class ThemeService {
//    @AppStorage("selectedTheme") var selectedTheme: Theme =
    
    var selectedTheme: Theme = Themes.Parintins()
}
