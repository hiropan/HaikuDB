import SwiftUI

struct MainTabView: View {
    @State private var contests: [Contest] = []
    //追加
//    @State private var themes: [Theme] = []
    
    var body: some View {
        TabView {
            HaikuListView(contests: $contests)
                .tabItem {
                    Label("Haikus", systemImage: "book")
                }

            ContestListView(contests: $contests)
                .tabItem {
                    Label("Contests", systemImage: "trophy")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .onAppear {
            loadContests()
        }
    }
    func loadContests() {
        if let data = UserDefaults.standard.data(forKey: "savedContests"),
           let decoded = try? JSONDecoder().decode([Contest].self, from: data) {
            contests = decoded
        }
    }
    
    //
//    func loadThems() {
//        if let data = UserDefaults.standard.data(forKey: "savedThemes"),
//           let decoded = try? JSONDecoder().decode([Theme].self, from: data) {
//            themes = decoded
//        }
//    }
}
