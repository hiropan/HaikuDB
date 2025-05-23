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

//    @State private var poem = ""
    @State private var upperPhrase = ""
    @State private var middlePhrase = ""
    @State private var lowerPhrase = ""
    @State private var theme = ""
    @State private var date = Date()
    @State private var writer = ""
    @State private var selectedContestID: UUID?
    @State private var hasLoaded = false
    @State private var note = ""
    @State private var isNoteExpanded = false
    @State private var themeOptions: [String] = []
      
    var isNewHaiku: Bool {
        guard let editingHaiku else { return true }
        return !haikus.contains(where: { $0.id == editingHaiku.id })
    }

    var isPoemValid: Bool {
        let trimmedUpper = upperPhrase.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedMiddle = middlePhrase.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLower = lowerPhrase.trimmingCharacters(in: .whitespacesAndNewlines)
        return !(trimmedUpper.isEmpty && trimmedMiddle.isEmpty && trimmedLower.isEmpty)
    }
    
    var body: some View {
        NavigationView {
            Form {
//                Section(header: Text("Poem")) {
//                    TextField("Poem", text: $poem)
//                }
                
                Section(header: Text("Haiku")) {
                    TextField("Upper phrase", text: $upperPhrase)
                        .textInputAutocapitalization(.sentences)
                        .disableAutocorrection(true)

                    TextField("Middle phrase", text: $middlePhrase)
                        .textInputAutocapitalization(.sentences)
                        .disableAutocorrection(true)

                    TextField("Lower phrase", text: $lowerPhrase)
                        .textInputAutocapitalization(.sentences)
                        .disableAutocorrection(true)
                    
                    Text([upperPhrase, middlePhrase, lowerPhrase]
                        .filter { !$0.isEmpty }
                        .joined(separator: "\n"))
                        .foregroundColor(.secondary)

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
                            upperPhrase: upperPhrase,
                            middlePhrase: middlePhrase,
                            lowerPhrase: lowerPhrase,
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
                    .disabled(!isPoemValid)
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
                let haiku = editingHaiku
                upperPhrase = haiku?.upperPhrase ?? ""
                middlePhrase = haiku?.middlePhrase ?? ""
                lowerPhrase = haiku?.lowerPhrase ?? ""
                writer = haiku?.writer.isEmpty == false ? haiku!.writer : defaultWriter
                theme = haiku?.theme ?? ""
                date = haiku?.date ?? Date()
                selectedContestID = haiku?.contestID
                note = haiku?.note ?? ""
                isNoteExpanded = !(haiku?.note.isEmpty ?? true)

                themeOptions = UserDefaults.standard.stringArray(forKey: "themes") ?? []
                hasLoaded = true
            }
        }
    }
    
    func saveHaikus() {
        if let data = try? JSONEncoder().encode(haikus) {
            UserDefaults.standard.set(data, forKey: "SavedHaikus")
        }
    }
}
