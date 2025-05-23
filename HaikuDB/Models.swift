//
//  Models.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/04/24.
//
import Foundation
import SwiftUI

struct Contest: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var startDate: Date
    var endDate: Date
    var note: String = ""
}

struct Haiku: Identifiable, Codable, Equatable {
    var id = UUID()
    var upperPhrase: String
    var middlePhrase: String
    var lowerPhrase: String
    var theme: String
    var date: Date
    var writer: String
    var contestID: UUID?
    var note: String = ""
}

struct ColourTheme: Identifiable {
    var id = UUID()
    var name: String
    var lightColours: ThemeColours
    var darkColours: ThemeColours
}

struct ThemeColours {
    var background: Color
    var primary: Color
    var accent: Color
    var secondary: Color
}
