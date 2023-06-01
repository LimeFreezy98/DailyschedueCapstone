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
//    @Binding var eventStorage: Events
//    @Binding var noteStorage: CoreNote
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NoteCell(note: note)
                        .listRowInsets(EdgeInsets())  // Add this line to remove the cell grouping
                        .padding(.vertical, 8)  // Add vertical padding to create space between cells
                }
                .onDelete(perform: deleteNote)  // Enable deletion
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing:
                NavigationLink(destination: AddNoteView(notes: $notes)) {
                    Image(systemName: "plus")
                }
            )
            .background(Color.cyan.opacity(0.2))
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
        .padding(.horizontal, 16)  // Add horizontal padding to center the content within the cell
    }
}
