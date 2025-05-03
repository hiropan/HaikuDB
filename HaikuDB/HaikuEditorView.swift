//
//  HaikuEditorView.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/04/24.
//

import SwiftUI

struct HaikuEditorView: View {
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("defaultWriter") private var defaultWriter: String = ""

    @Binding var haikus: [Haiku]
    var contests: [Contest]
    var editingHaiku: Haiku? = nil

    @State private var poem = ""
    @State private var theme = ""
    @State private var date = Date()
    @State private var writer: String
//    @State private var writer = ""
    @State private var selectedContestID: UUID?
    @State private var hasLoaded = false
    @State private var note = ""
    @State private var isNoteExpanded = false
    @State private var themeOptions: [String] = []
    
    init(haikus: Binding<[Haiku]>, contests: [Contest], editingHaiku: Haiku) {
        self._haikus = haikus
        self.contests = contests
        self.editingHaiku = editingHaiku
        _poem = State(initialValue: editingHaiku.poem)
        _theme = State(initialValue: editingHaiku.theme)
//        _writer = State(initialValue: editingHaiku.writer.isEmpty ? UserDefaults.standard.string(forKey: "defaultWriter") ?? "" : editingHaiku.writer)
//        _writer = State(initialValue: editingHaiku.writer)
        _writer = State(initialValue: "")
        _selectedContestID = State(initialValue: editingHaiku.contestID)
    }
    
    var isNewHaiku: Bool {
        guard let editingHaiku else { return true }
        return !haikus.contains(where: { $0.id == editingHaiku.id })
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Poem")) {
                    TextEditor(text: $poem)
                        .frame(height: 100)
                }

                Section(header: Text("Details")) {
                    Picker("Theme", selection: $theme) {
                        ForEach(themeOptions, id: \.self) { option in
                            Text(option)
                        }
                    }

                    HStack {
                        Text("Writer")
                            .foregroundColor(.primary)
                        Spacer()
                        TextField("Writer", text: $writer)
                            .multilineTextAlignment(.trailing)
                    }

                    DatePicker("Date", selection: $date, displayedComponents: .date)

                }

                Section(header: Text("Contest")) {
                    Picker("Contest", selection: $selectedContestID) {
                        Text("None").tag(UUID?.none)
                        ForEach(contests) { contest in
                            VStack(alignment: .leading) {
                                Text(contest.title)
                                    .font(.body)
                                if !contest.note.isEmpty {
                                    Text(contest.note)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .tag(Optional(contest.id))
                        }
                    }
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
            }
            .navigationTitle(isNewHaiku ? "Create Haiku" : "Edit Haiku")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let updatedHaiku = Haiku(
                            id: editingHaiku?.id ?? UUID(), // Use the same ID if editing
                            poem: poem,
                            theme: theme,
                            date: date,
                            writer: writer,
                            contestID: selectedContestID,
                            note: note
                        )

                        if let existingIndex = haikus.firstIndex(where: { $0.id == editingHaiku?.id }) {
                            haikus[existingIndex] = updatedHaiku // 🔄 Update existing
                        } else {
                            haikus.append(updatedHaiku) // ➕ Add new
                        }

                        saveHaikus()
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
            if !hasLoaded {
                if let haiku = editingHaiku {
                    poem = haiku.poem
//                    writer = haiku.writer
                    writer = isNewHaiku ? defaultWriter : haiku.writer
                    theme = haiku.theme
                    date = haiku.date
                    selectedContestID = haiku.contestID
                    note = haiku.note
                    isNoteExpanded = !haiku.note.isEmpty
                } else {
                    writer = defaultWriter // <- now defaultWriter from @AppStorage is available
                }

                themeOptions = UserDefaults.standard.stringArray(forKey: "themes") ?? []
                hasLoaded = true
            }
        }
//        .onAppear {
//            if !hasLoaded {
//                if let haiku = editingHaiku {
//
//                } else {
//                    writer = defaultWriter
//                }
////                if editingHaiku == nil {
////                    writer = defaultWriter
////                }
//                hasLoaded = true
//            }
//                themeOptions = UserDefaults.standard.stringArray(forKey: "themes") ?? []
//        }
    }
    
    func saveHaikus() {
        if let data = try? JSONEncoder().encode(haikus) {
            UserDefaults.standard.set(data, forKey: "SavedHaikus")
        }
    }
}
