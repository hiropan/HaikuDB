//
//  ContentView.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

//struct ContentView: View {
//    var body: some View {
//        TabView {
//            HaikuListView(contests: $contests)
//                .tabItem {
//                    Label("Haikus", systemImage: "book")
//                }
//
//            ContestListView(contests: $contests)
//                .tabItem {
//                    Label("Contests", systemImage: "flag.filled.and.flag.crossed")
//                }
//
//            SettingsView()
//                .tabItem {
//                    Label("Settings", systemImage: "gear")
//                }
//        }
//    }
//}

//
