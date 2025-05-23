//
//  SettingsView.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/04/28.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("colourScheme") private var colourScheme: String = "Light"
    @AppStorage("colourTheme") private var colourTheme: String = "Standard"
    @AppStorage("language") private var language: String = "English"
    @AppStorage("defaultWriter") private var defaultWriter: String = ""

    @State private var themes: [String] = UserDefaults.standard.stringArray(forKey: "themes") ?? []
    @State private var newTheme = ""
    @State private var isThemesExpanded = true

    let colourOptions = ["System", "Light", "Dark"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Picker("Colour Scheme", selection: $colourScheme) {
                        ForEach(colourOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle());
                    
                    Picker("Colour Theme", selection: $colourTheme) {
                        ForEach(allThemes) { theme in
                            Text(theme.name).tag(theme.name)
                        }
                    }
                }

                Section(header: Text("Default Writer's Name")) {
                    TextField("Default Writer’s Name", text: $defaultWriter)
                        .submitLabel(.done)
                }

                Section {
                    Button(action: {
                        withAnimation {
                            isThemesExpanded.toggle()
                        }
                    }) {
                        HStack {
                            Text("Themes")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .rotationEffect(.degrees(isThemesExpanded ? 180 : 0))
                                .foregroundColor(.blue)
                                .animation(.easeInOut, value: isThemesExpanded)
                        }
                    }

                    if isThemesExpanded {
                        ForEach(themes.indices, id: \.self) { index in
                            HStack {
                                TextField("Theme", text: $themes[index])
                                Button(action: {
                                    themes.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }

                        Button(action: {
                            themes.append("")
                        }) {
                            Label("Add Theme", systemImage: "plus.circle")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                themes = UserDefaults.standard.stringArray(forKey: "themes") ?? ["Nature", "Seasons", "Life"]
            }
            .onDisappear {
                let cleaned = themes.map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
                UserDefaults.standard.set(cleaned, forKey: "themes")
            }
        }
    }
    
    func saveThemes() {
        UserDefaults.standard.set(themes, forKey: "themes")
    }
}
