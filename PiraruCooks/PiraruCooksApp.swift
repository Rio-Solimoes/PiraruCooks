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

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(networkMonitor)
                .environmentObject(themeManager)
                .tint(themeManager.selectedTheme.primary.swiftUIColor)
        }
    }
}
