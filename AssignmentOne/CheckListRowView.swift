//
//  CheckListTitlePage.swift
//  AssignmentOne
//
//  Created by wsq on 14/4/2023.
//

import SwiftUI

/**
 # CheckListRowView
 
 One single view to represent a check list.
 
 ## Introduction
 
 This view is present one single check list. Containing a check list name. Also, this view providing a edit function. When the environment turning to edit mode. User is able to input a new check list name. When edit mode is finished, if the user input is valid, this new name will be set as a new name to this check list, otherwise nothing will happen. When rename is done, this view will call the function from checkListDataModel to save the updated data to JSON file.
 
 - Tag: CheckListRowViewExample
 
 ## Example
 
 CheckListRowView(checkListObject: CheckList, checkListDataModel: CheckListDataModel)
 
 */
struct CheckListRowView: View {
    ///The checkList Object
    var checkListObject: CheckList
    ///Use to call save data to json file
    var checkListDataModel: CheckListDataModel
    ///a status that whether now is in edit mode
    @Environment(\.editMode) private var editMode
    ///a variable to store new item name
    @State private var listName: String = ""
    var body: some View {
        HStack{
            //if now is in edit mode, the textField that allow user to input new item name will be shown, otherwise, the original item name will be shown
            if editMode?.wrappedValue == .active {
                TextField(checkListObject.listName, text:$listName)
            } else {
                Text(checkListObject.listName).font(.title2).foregroundColor(.black)
            }
        }.onChange(of:editMode?.wrappedValue){newValue in   // if the status of edit mode first changed, which is mean the user have done the edit name operation, if the new item name is valid, then change the item name and save data to json
            if newValue == .inactive && listName != "" {
                checkListObject.listName = listName
                listName = ""
                checkListDataModel.saveCheckData()
            }
        }
    }
}
