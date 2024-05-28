//
//  PiraruCooksApp.swift
//  PiraruCooks
//
//  Created by João Vitor Gonçalves Oliveira on 26/04/24.
//

import SwiftUI
import Parintins

@main
struct PiraruCooksApp: App {
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject var networkMonitor = NetworkMonitor()
    @State private var tabBarViewModel = TabBarViewModel()
    @State private var addressViewModel = AddressViewModel()

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(networkMonitor)
                .environmentObject(themeManager)
                .environment(tabBarViewModel)
                .environment(addressViewModel)
                .tint(themeManager.selectedTheme.primary.swiftUIColor)
                .preferredColorScheme(.light)
        }
    }
}
