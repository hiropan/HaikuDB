import SwiftUI

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("colourTheme") private var colourTheme: String = "Standard"
    
    @State private var contests: [Contest] = []
    @State private var haikus: [Haiku] = []
    
    var theme: ThemeColours {
        currentTheme(named: colourTheme)
    }
    
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
        .background(theme.background)
        .foregroundColor(theme.primary)
        .accentColor(theme.accent)
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
    
    func currentTheme(named name: String) -> ThemeColours {
        let theme = allThemes.first { $0.name == name } ?? standardTheme
        return colorScheme == .dark ? theme.darkColours : theme.lightColours
    }
}
