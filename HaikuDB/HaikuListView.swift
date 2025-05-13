//
//  HaikuListView.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/04/24.
//

import SwiftUI

struct HaikuListView: View {
    @Binding var contests: [Contest]
    @State private var haikus: [Haiku] = []
    @State private var haikuToEdit: Haiku?
    @State private var searchText = ""

    var filteredHaikus: [Haiku] {
        if searchText.isEmpty {
            return haikus
        } else {
            return haikus.filter {
                $0.upperPhrase.localizedCaseInsensitiveContains(searchText) ||
                $0.middlePhrase.localizedCaseInsensitiveContains(searchText) ||
                $0.lowerPhrase.localizedCaseInsensitiveContains(searchText) ||
                $0.writer.localizedCaseInsensitiveContains(searchText) ||
                $0.theme.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredHaikus) { haiku in
                    HaikuRowView(haiku: haiku, contest: contest(for: haiku))
                        .contentShape(Rectangle()) // makes the whole row tappable
                        .onTapGesture {
                            haikuToEdit = haiku
                        }
                }
                .onDelete(perform: deleteHaikus)
            }
            .navigationTitle("My Haikus")
            .searchable(text: $searchText, prompt: "Search haikus")
            .toolbar {
                Button {
                    // Create a new empty haiku for creation
                    haikuToEdit = Haiku(
                        id: UUID(),
                        upperPhrase: "",
                        middlePhrase: "",
                        lowerPhrase: "",
//                        poem: "",
                        theme: "",
                        date: Date(),
//                        writer: UserDefaults.standard.string(forKey: "defaultWriter") ?? "",
                        writer: "",
                        contestID: nil
                    )
                } label: {
                    Label("Add Haiku", systemImage: "square.and.pencil")
                }
            }
            .sheet(item: $haikuToEdit, onDismiss: {
                haikuToEdit = nil
            }) { haiku in
                HaikuEditorView(
                    haikus: $haikus,
                    contests: contests,
                    editingHaiku: haiku
                )
            }
            .onAppear {
                loadHaikus()
            }
            .onChange(of: haikus) {
                saveHaikus()
            }
        }
    }

    // MARK: - Helpers

    func contest(for haiku: Haiku) -> Contest? {
        contests.first(where: { $0.id == haiku.contestID })
    }

    func saveHaikus() {
        if let data = try? JSONEncoder().encode(haikus) {
            UserDefaults.standard.set(data, forKey: "savedHaikus")
        }
    }

    func loadHaikus() {
        if let data = UserDefaults.standard.data(forKey: "savedHaikus"),
           let saved = try? JSONDecoder().decode([Haiku].self, from: data) {
            haikus = saved
        }
    }
    
    func deleteHaikus(at offsets: IndexSet) {
        haikus.remove(atOffsets: offsets)
    }
}

// MARK: - Extracted Row View

struct HaikuRowView: View {
    let haiku: Haiku
    let contest: Contest?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(haiku.upperPhrase + " " + haiku.middlePhrase + " " + haiku.lowerPhrase)
                .font(.headline)

//            Text("Theme: \(haiku.theme)")
//                .font(.subheadline)
//
//            if let contest = contest {
//                Text("Contest: \(contest.title)")
//                    .font(.caption)
//                    .foregroundColor(.blue)
//            }

            Text("By: \(haiku.writer)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
