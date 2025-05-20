//
//  ContestListView.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/04/28.
//

import SwiftUI

struct ContestListView: View {
    @Binding var contests: [Contest]
    @State private var contestToEdit: Contest?
    @State private var searchText = ""
    
    var haikus: [Haiku]
    var filteredContests: [Contest] {
        if searchText.isEmpty {
            return contests
        } else {
            return contests.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredContests) { contest in
                    ContestRowView(contest: contest)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            contestToEdit = contest
                        }
                }
                .onDelete(perform: deleteContests)
            }
            .navigationTitle("Contests")
            .searchable(text: $searchText, prompt: "Search contests")
            .toolbar {
                Button {
                    contestToEdit = Contest(title: "", startDate: Date(), endDate: Date())
                } label: {
                    Label("Add Contest", systemImage: "square.and.pencil")
                }
            }
            .sheet(item: $contestToEdit, onDismiss: {
                contestToEdit = nil
            }) { contest in
                ContestEditorView(
                    contests: $contests,
                    editingContest: contest,
                    haikus: haikus
                )
            }
            .onAppear {
                loadContests()
//                loadHaikus()
            }
            .onChange(of: contests) {
                saveContests()
            }
        }
    }

    // MARK: - Helpers

    func saveContests() {
        if let data = try? JSONEncoder().encode(contests) {
            UserDefaults.standard.set(data, forKey: "savedContests")
        }
    }

    func loadContests() {
        if let data = UserDefaults.standard.data(forKey: "savedContests"),
           let saved = try? JSONDecoder().decode([Contest].self, from: data) {
            contests = saved
        }
    }

    func deleteContests(at offsets: IndexSet) {
        contests.remove(atOffsets: offsets)
    }
}

struct ContestRowView: View {
    let contest: Contest

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(contest.title)
                .font(.headline)

            Text("Start: \(formatted(date: contest.startDate))")
                .font(.caption)
                .foregroundColor(.secondary)

            Text("End: \(formatted(date: contest.endDate))")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }

    func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
