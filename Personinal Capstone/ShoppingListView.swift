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


struct ShoppingListView: View {
    @State private var items: [ShoppingItem] = [
        ShoppingItem(name: "Milk", quantity: 10, isChecked: false),
    ]
    
    var body: some View {
           NavigationView {
               List {
                   ForEach(items.indices) { index in
                       ShoppingListCell(item: $items[index])
                   }
                   .onDelete(perform: deleteItems)
               }
               .navigationBarTitle("Shopping List")
               .navigationBarItems(trailing:
                   Button(action: {
                       // Navigate to AddShoppingListView
                   }) {
                       Image(systemName: "plus")
                   }
               )
           }
       }
       
       private func deleteItems(at offsets: IndexSet) {
           items.remove(atOffsets: offsets)
       }
   }

struct ShoppingListCell: View {
    @Binding var item: ShoppingItem
    
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
