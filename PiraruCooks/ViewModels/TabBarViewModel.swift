import Foundation
import Parintins

@Observable
class TabBarViewModel: ObservableObject {
    private let daysBeforeFestivalToSelectTheme = 15
    private let daysAfterFestivalToSelectTheme = 5
    var selectedTab = "Cardápio"
    var showSelectTheme: Bool = false
    var dismissThemeSelection: Bool = false
    var isDishesDetailPresented: Bool = false
    
    init() {
        guard let parintinsFestivalDate = TabBarViewModel.getParintinsFestivalDate(),
              let distanceFromFestivalDate = Calendar.current.dateComponents(
                [.day],
                from: parintinsFestivalDate,
                to: Date.now).day else {
            return
        }
        if distanceFromFestivalDate > -daysBeforeFestivalToSelectTheme 
            && distanceFromFestivalDate < daysAfterFestivalToSelectTheme + 2 {
            if ThemeManager.shared.selectedTheme.userDefaultsValue == "Parintins" {
                showSelectTheme = true
            }
        } else {
            dismissThemeSelection = true
        }
    }
    
    private static func getParintinsFestivalDate() -> Date? {
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: Date.now)
        components.month = 6
        components.day = 28
        return Calendar.current.date(from: components)
    }
}
