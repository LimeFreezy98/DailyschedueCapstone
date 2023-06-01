//
//  ShoppingListView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 5/31/23.
//

import SwiftUI

struct ShoppingItem: Identifiable {
    let id = UUID()
    var name: String
    var quantity: Int
    var isChecked: Bool
}


class ShoppingList: ObservableObject {
    @Published var items: [ShoppingItem] = [
//        @Binding var eventStorage: Events
    ]
}

struct ShoppingListView: View {
    @StateObject private var shoppingList = ShoppingList()

    var body: some View {
        
        NavigationView {
            List {
                ForEach(shoppingList.items) { item in
                    ShoppingListCell(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("Shopping List")
            .navigationBarItems(trailing:
                NavigationLink(destination: AddShoppingListView(shoppingList: shoppingList)) {
                    Image(systemName: "plus")
                }
            )
            .background(Color.green.opacity(0.2))
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        shoppingList.items.remove(atOffsets: offsets)
    }
}

struct ShoppingListCell: View {
    @State var item: ShoppingItem

    var body: some View {
        HStack {
            Button(action: {
                item.isChecked.toggle()
            }) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(PlainButtonStyle())

            VStack(alignment: .leading) {
                Text(item.name)
                    .foregroundColor(item.isChecked ? .gray : .primary)
                Text("Quantity: \(item.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
//struct ShoppingListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingListView()
//    }
//}
