import SwiftUI

struct MainTabView: View {
    @State private var contests: [Contest] = []
    @State private var haikus: [Haiku] = []
    
    var body: some View {
        TabView {
            HaikuListView(contests: $contests)
                .tabItem {
                    Label("Haikus", systemImage: "book")
                }

            ContestListView(contests: $contests, haikus: haikus)
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
            loadHaikus()
        }
    }
    
    func loadContests() {
        if let data = UserDefaults.standard.data(forKey: "savedContests"),
           let decoded = try? JSONDecoder().decode([Contest].self, from: data) {
            contests = decoded
        }
    }
    
    func loadHaikus() {
        if let data = UserDefaults.standard.data(forKey: "savedHaikus"),
           let decoded = try? JSONDecoder().decode([Haiku].self, from: data) {
            haikus = decoded
        }
    }
}
