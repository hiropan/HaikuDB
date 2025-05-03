//
//  HaikuDBApp.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/04/24.
//

import SwiftUI

@main
struct HaikuDBApp: App {
    @AppStorage("colourScheme") private var colourScheme: String = "System"

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(resolveColorScheme(from: colourScheme))
        }
    }

    func resolveColorScheme(from value: String) -> ColorScheme? {
        switch value {
        case "Light":
            return .light
        case "Dark":
            return .dark
        default:
            return nil // System default
        }
    }
}
