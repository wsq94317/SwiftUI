//
//  AddCheckListView.swift
//  AssignmentOne
//
//  Created by wsq on 14/4/2023.
//

import SwiftUI

/**
 # AddCheckListView
 
 A view that allow user to add new check list.
 
 ## Introduction
 
 This page is used as a floating view in the project, allowing users to add new  CheckList. The view enables users to enter a new check list  name into a TextField. There are two buttons, one for confirmation and one for cancellation. When the user presses the confirmation button, if the entered data is valid, a new check list instantiated and added to CheckListDataModel. The CheckListDataModel's method is then called to store the updated data in the JSON file. If the user enters invalid data, the action will not be triggered. After successfully storing the new data or when the user presses the cancel button, the $isAdding state will be changed, closing this view in the parent view.
 
 - Tag: AddCheckListViewExample
 
 ## Example
 
 AddCheckListView(checkListDataModel: CheckListDataModel, isAdding: $Bool)
 
 */

struct AddCheckListView: View {
    var checkListDataModel: CheckListDataModel  // a reference to chackListDataModel using to store new data and call class function to store data to json
    @Binding var isAdding: Bool // a status binding to the parent, use to switch page
    @State private var newCheckListName: String = ""    // a variable to store new check list name
    var body: some View {
        VStack{
            HStack{
                Spacer()
                //Header text
                Text("Add a new check list").font(.title)
                    .foregroundColor(.white)
                Spacer()
            }.frame(height:50)
                .background(.black)
                .cornerRadius(25)
            
            Divider()
            
            // HStack containing the TextField for inputting the new check list name
            HStack{
                Spacer()
                Text("New name: ")
                TextField("Please input new check list name",text: $newCheckListName)
                Spacer()
            }.padding()
            
            Divider()
            
            // HStack containing the Add and Cancel buttons
            HStack{
                Spacer()
                // Add button to add the new check list and close the view
                Button("Add"){
                    if (newCheckListName != ""){
                        checkListDataModel.addNewList(newListName:newCheckListName)
                        isAdding = false    //when the add operation done, the status will change and switch to parent page
                    }
                }.frame(width:100,height: 40)
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    .cornerRadius(10)
                Spacer()
                // Cancel button to close the view without adding a new check list
                Button("Cancel"){
                    isAdding = false
                }.frame(width:100,height: 40)
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    .cornerRadius(10)
                Spacer()
            }.padding()
            
            Spacer()
        }
    }
}
