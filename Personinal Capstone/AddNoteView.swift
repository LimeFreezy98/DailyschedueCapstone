//
//  AddNoteView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 5/30/23.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var notes: [Note]  // Replace with your notes array
    @State private var newNoteTitle = ""
    @State private var newNoteDescription = ""

    var body: some View {
        VStack {
            TextField("Title", text: $newNoteTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextEditor(text: $newNoteDescription)
                .frame(height: 200)
                .overlay(
                    VStack(alignment: .leading, spacing: 4) {
                        if newNoteDescription.isEmpty {
                            Text("Enter description")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 8)
                    .opacity(newNoteDescription.isEmpty ? 1 : 0)
                    .allowsHitTesting(false)
                )
                .padding()

            Button(action: {
                let newNote = Note(title: newNoteTitle, description: newNoteDescription)
                notes.append(newNote)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add Note")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitle("Add Note")
    }
}
