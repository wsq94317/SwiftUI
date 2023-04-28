//
//  ListRowView.swift
//  AssignmentOne
//
//  Created by wsq on 27/3/2023.
//

import SwiftUI
/**
 # ListRowView
 
 This is the item containing in a HStack(), which represent one check item including its name and status
 
 ## Introduction
 This view displays a checkItem. It shows the item's name and status. The status is represented by a toggle, and users can change the item's status by adjusting the toggle. In addition, when entering edit mode, a TextField replaces the Text, allowing users to input a new name to rename the item. When the user exits edit mode and if input is detected with a non-empty value, the entered text will replace the original item name.
 
 - Tag: ListRowViewExample
 
 # Example
 ListRowView(checkItem: CheckItem, checkListObject: CheckList, checkListDataModel: CheckListDataModel)
 */
struct ListRowView: View {
    /// To get the checked/unchecked state of the list item/
    @ObservedObject var checkItem: CheckItem
    /// This is a object where this data stored
    var checkListObject: CheckList
    /// To use this object instance to call the function to store updated data to JSON
    var checkListDataModel: CheckListDataModel
    /// a marker that if this status changed by the user using toggle
    @State var userOperation = false
    /// A state to decide whether now is in edit mode
    @Environment(\.editMode) var editMode
    @State private var itemName:String = ""
    var body: some View {
        HStack {
            // Display the appropriate icon based on the checked/unchecked state of the list item
            Image(systemName: checkItem.bIsChecked ? "checkmark.square" : "square") //if in edit mode, the item name will be able to change, then change the Text() into TextField() to allow user input a new item name
            if editMode?.wrappedValue == .active {
                TextField(checkItem.name, text:$itemName)
            } else {
                Text(checkItem.name) // Display the title of the list item
                    .font(.headline)    // Use a larger font size for the item title
                    .foregroundColor(.primary) //Use the default text colour
            }
            Spacer() // Add a spacer to push the toggle button to the right
            Toggle("", isOn: $checkItem.bIsChecked) // Add a toggle button to check/uncheck the list item
                .toggleStyle(SwitchToggleStyle(tint: .black)) //Use black colour for the toggle button
                .onTapGesture { // Add a tap gesture to toggle the checked/unchecked state of the list item
                    userOperation = true
                }.onChange(of: checkItem.bIsChecked){newValue in
                    checkListDataModel.saveCheckData()
                    if (userOperation){
//                        checkItem.resetHistory()   //if this status switch using toggle, then this will be mark as user operation and will not be undo by the undoUncheck()
                        userOperation = false
                        checkListObject.resetAllHistory() // when user switch stauts using toggle, the undo button in parent page will be hidden
                    }
                }
        }
        .font(.title2) // Set the font size of the list item title and the icon
        .frame(height: 50) // Set the height of the list item
        .padding(.horizontal) //Add some padding to the item
        .onChange(of: editMode?.wrappedValue){newValue in // if the new Name input properly, when the edit mode end, the new name will be saved
            if newValue == .inactive && itemName != "" {
                checkItem.name = itemName
                itemName = ""
                checkListDataModel.saveCheckData()  //updated data will be stored to json
            }
        }
    }
}

