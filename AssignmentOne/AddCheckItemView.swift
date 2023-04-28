//
//  AddView.swift
//  AssignmentOne
//
//  Created by wsq on 13/4/2023.
//

import SwiftUI
/**
 # AddCheckItemView
 
 A view that allow user to add new item to a check list.
 
 ## Introduction
 
 This page is used as a floating view in the project, allowing users to add new items to a CheckList. The view enables users to enter a new item name into a TextField and set the new item's status using a toggle. There are two buttons, one for confirmation and one for cancellation. When the user presses the confirmation button, if the entered data is valid, a new item will be instantiated and added to the check list. The CheckListDataModel's method is then called to store the updated data in the JSON file. If the user enters invalid data, the action will not be triggered. After successfully storing the new data or when the user presses the cancel button, the $isAdding state will be changed, closing this view in the parent view.
 
 - Tag: AddCheckItemViewExample
 
 ## Example
 
 AddCheckItemView(checkListObject: CheckList, isAdding: $Bool, checkListDataModel: CheckListDataModel)
 
 */
struct AddCheckItemView: View {
    /// the class object that store data of current check list
    var checkListObject: CheckList
    /// a status to decide which view will be shown
    @Binding var isAdding: Bool
    /// a class object to save uopdated data to JSON file
    var checkListDataModel: CheckListDataModel
    /// a local  virable to store user input about new item name
    @State private var checkItemName : String = ""
    ///a local virable to store new item status
    @State private var bIsChecked : Bool = false
    var body: some View {
        VStack{
            HStack{
                Spacer()
                //Here is the header text
                Text("Add a new check Item").font(.title)
                    .foregroundColor(.white)
                Spacer()
            }.frame(height:50)
            .background(Color.black)
            .cornerRadius(25)
            Divider()
            
            HStack{
                // The item name including textfield that user input the new item name
                Spacer()
                Text("Item Name:")
                TextField("Please input the item name",text: $checkItemName)
                Spacer()
            }
            
            Divider()
            
            HStack{
                // here is the HStack contains the toggle to switch the status of the new item
                Spacer()
                Text("Item Status")
                Toggle("", isOn: $bIsChecked)
                Spacer()
            }
            
            Divider()
            
            HStack{
                // The two buttons contains in a HStack, including a Add button and a Cancel button
                Spacer()
                Button("Add"){
                    //if user press the add button and the check item name is not null value, the new item and its status will be store to checkListObject using class function, after that ,the new data will be saved to json
                    if (checkItemName != "")
                    {
                        let newItem = CheckItem(name:checkItemName,bIsChecked: bIsChecked)
                        checkListObject.addItem(newItem:newItem)
                        checkListDataModel.saveCheckData()
                        isAdding = false
                    }
                }.frame(width:100,height: 40).foregroundColor(Color.white).background(Color.gray).cornerRadius(10)
                Spacer()
                Button("Cancel"){
                    isAdding = false
                }.frame(width:100,height: 40).foregroundColor(Color.white).background(Color.gray).cornerRadius(10)
                Spacer()
            }
        }.padding()
        Spacer()
    }
}
