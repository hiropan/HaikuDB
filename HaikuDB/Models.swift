//
//  Models.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/04/24.
//
import Foundation

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
//    var poem: String
    var theme: String
    var date: Date
    var writer: String
    var contestID: UUID?
    var note: String = ""
}
