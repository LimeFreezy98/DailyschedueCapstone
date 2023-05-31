//
//  AddShopingListView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 5/31/23.
//

import SwiftUI

struct AddShoppingListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shoppingList: ShoppingList
    @State private var itemName = ""
    @State private var itemQuantity = ""

    var body: some View {
        Form {
            Section(header: Text("Item Details")) {
                TextField("Item Name", text: $itemName)
                TextField("Quantity", text: $itemQuantity)
                    .keyboardType(.numberPad)
            }

            Section {
                Button("Done") {
                    guard let quantity = Int(itemQuantity) else {
                        // Show an error message for invalid quantity
                        return
                    }

                    let newItem = ShoppingItem(name: itemName, quantity: quantity, isChecked: false)
                    shoppingList.items.append(newItem)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationBarTitle("Add Item")
    }
}

//struct AddShopingListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddShopingListView()
//    }
//}
