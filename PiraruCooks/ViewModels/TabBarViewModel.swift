import Foundation
import Parintins

@Observable
class TabBarViewModel {
    // Constantes para limitar período em que app apresenta opção de escolha de tema dos bois
    // Caso sejam nil todo o período antes ou após o festival será considerado respectivamente
    private let daysBeforeFestivalToSelectTheme: Int? = nil // dias antes do dia 28
    private let daysAfterFestivalToSelectTheme: Int? = nil // dias depois do dia 30
    var selectedTab = "Cardápio"
    var showSelectTheme: Bool = false
    var dismissThemeSelection: Bool = false
    
    init() {
        guard let parintinsFestivalStartDate = TabBarViewModel.getParintinsFestivalStartDate(),
              let distanceFromFestivalStartDate = Calendar.current.dateComponents(
                [.day],
                from: parintinsFestivalStartDate,
                to: Date.now).day else {
            return
        }
        let showedSelectTheme = UserDefaults.standard.bool(forKey: "showedSelectTheme")
        if (0...2).contains(distanceFromFestivalStartDate) && !showedSelectTheme {
            showSelectTheme = true
            UserDefaults.standard.set(true, forKey: "showedSelectTheme")
            return
        }
        if distanceFromFestivalStartDate < 0 {
            guard let daysBeforeFestivalToSelectTheme = daysBeforeFestivalToSelectTheme else {
                if !showedSelectTheme {
                    showSelectTheme = true
                    UserDefaults.standard.set(true, forKey: "showedSelectTheme")
                }
                return
            }
            if distanceFromFestivalStartDate >= -daysBeforeFestivalToSelectTheme {
                if !showedSelectTheme {
                    showSelectTheme = true
                    UserDefaults.standard.set(true, forKey: "showedSelectTheme")
                }
                return
            }
            showSelectTheme = false
            UserDefaults.standard.set(false, forKey: "showedSelectTheme")
            dismissThemeSelection = true
        }
        if distanceFromFestivalStartDate > 2 {
            guard let daysAfterFestivalToSelectTheme = daysAfterFestivalToSelectTheme else {
                showSelectTheme = true
                UserDefaults.standard.set(true, forKey: "showedSelectTheme")
                return
            }
            if distanceFromFestivalStartDate <= daysAfterFestivalToSelectTheme {
                showSelectTheme = true
                UserDefaults.standard.set(true, forKey: "showedSelectTheme")
                return
            }
            showSelectTheme = false
            UserDefaults.standard.set(false, forKey: "showedSelectTheme")
            dismissThemeSelection = true
        }
    }
    
    private static func getParintinsFestivalStartDate() -> Date? {
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: Date.now)
        components.month = 6
        components.day = 28
        return Calendar.current.date(from: components)
    }
}
