//
//  PiraruCooksApp.swift
//  PiraruCooks
//
//  Created by João Vitor Gonçalves Oliveira on 26/04/24.
//

import SwiftUI

@main
struct PiraruCooksApp: App {
    @State private var themeService = ThemeService()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(themeService)
                .tint(themeService.selectedTheme.primary.swiftUIColor)
        }
    }
}
