//
//  NoteView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 5/30/23.
//

import SwiftUI
import Foundation

struct Note: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct NoteView: View {
    @State private var notes: [Note] = []  // Replace with your notes array

    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        NoteCell(note: note)
                    }
                }
                .onDelete(perform: deleteNote)  // Enable deletion

                // Add the navigation bar item
                .navigationBarItems(trailing:
                    NavigationLink(destination: AddNoteView(notes: $notes)) {
                        Image(systemName: "plus")
                    }
                )
            }
            .navigationBarTitle("Notes")
        }
    }

    private func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
}

struct NoteCell: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.headline)
            Text(note.description)
                .font(.subheadline)
        }
    }
}

struct NoteDetailView: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.headline)
            Text(note.description)
                .font(.subheadline)
        }
        .navigationBarTitle(note.title)
    }
}
