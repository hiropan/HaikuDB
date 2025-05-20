//
//  ContestEditorView.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/04/28.
//

import SwiftUI

struct ContestEditorView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var contests: [Contest]
    var editingContest: Contest?
    var haikus: [Haiku]
    var relatedHaikus: [Haiku] {
        guard let contestID = editingContest?.id else { return [] }
        return haikus.filter { $0.contestID == contestID }
    }
    
    @State private var title = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var note = ""
    @State private var hasLoaded = false
    @State private var isNoteExpanded = false

    var isNewContest: Bool {
        guard let editingContest else { return true }
        return !contests.contains(where: { $0.id == editingContest.id })
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Contest Title", text: $title)
                }

                Section(header: Text("Dates")) {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                }
                
                Section {
                    Button {
                        withAnimation(.easeInOut) {
                            isNoteExpanded.toggle()
                        }
                    } label: {
                        HStack {
                            Text("Note")
                            Spacer()
                            Image(systemName: "chevron.down")
                                .rotationEffect(.degrees(isNoteExpanded ? 180 : 0))
                                .foregroundColor(.blue)
                                .animation(.easeInOut(duration: 0.2), value: isNoteExpanded)
                        }
                    }

                    if isNoteExpanded {
                        TextEditor(text: $note)
                            .frame(height: 100)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                
                Section (header: Text("Submitted Haikus")) {
                    ForEach(relatedHaikus) { haiku in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(haiku.upperPhrase + " " + haiku.middlePhrase + " " + haiku.lowerPhrase)
                                .font(.body)
                            Text("by \(haiku.writer)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle(isNewContest ? "Create Contest" : "Edit Contest")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let updatedContest = Contest(
                            id: editingContest?.id ?? UUID(),
                            title: title,
                            startDate: startDate,
                            endDate: endDate,
                            note: note
                        )

                        if let existingIndex = contests.firstIndex(where: { $0.id == editingContest?.id }) {
                            contests[existingIndex] = updatedContest
                        } else {
                            contests.append(updatedContest)
                        }

                        saveContests()
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            if let contest = editingContest, !hasLoaded {
                title = contest.title
                startDate = contest.startDate
                endDate = contest.endDate
                note = contest.note
                hasLoaded = true
                isNoteExpanded = !contest.note.isEmpty // 🆕 Expand if there's already a note
            }
        }
    }

    func saveContests() {
        if let data = try? JSONEncoder().encode(contests) {
            UserDefaults.standard.set(data, forKey: "savedContests")
        }
    }
}
