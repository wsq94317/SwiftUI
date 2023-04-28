//
//  CheckListView.swift
//  AssignmentOne
//
//  Created by wsq on 4/4/2023.
//

import SwiftUI
/**
 # CheckListView
 
 This is a single Check List, contains all items in this Check List. Allow user to view all items and edit each items and add new items to this check list.
 
 ## Introduction
 This is a CheckList view, which includes a check list page and a floating page. The transition between the two pages is controlled by the $isAdding state. When the user presses the Add button, the isAdding state becomes true, and the floating page (AddCheckListView) is displayed using the .sheet() modifier. When the user correctly inputs a new item name and clicks the confirm button, or clicks the cancel button, the isAdding state changes to false, returning to the check list page.
 
 - Tag: CheckListViewExample
 
 ## Example
 CheckListView(checkListObject: CheckList, checkListDataModel: CheckListDataModel)
 */
struct CheckListView: View {
    /// observe the object of checkListObject where the check list data is stored. when the observed object has changed, this view will be updated
    @ObservedObject var checkListObject: CheckList
    ///a status for mark of whether the addCheckItemView will be shown
    @State private var isAdding = false
    ///  add a reference in order to store data within any updates
    var checkListDataModel: CheckListDataModel
    var body: some View {
        VStack{
            Divider()
            HStack{
                // HStack containing buttons for adding items, editing, unchecking all items, and undo
                // the plus button with its style
                Button(action:{
                    isAdding = true
                },label:{Image(systemName: "plus")})
                    .padding()
                    .frame(height:30)
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                
                // the edit button with its style
                EditButton()
                    .padding()
                    .frame(height:30)
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                
                // add spacer()to seperate two buttons below and uncheck button and undo button
                Spacer()
                
                //uncheck button with its style
                Button(action:{
                    checkListObject.uncheckAll()    //to call the class function to uncheck all items stored in the class CkeckList
                    checkListDataModel.saveCheckData()  // when the data updated, store the data to json file
                },label:{Text("Uncheck all")})
                .padding()
                .frame(height:30)
                .background(Color.black.opacity(0.7))
                .foregroundColor(Color.white)
                .cornerRadius(10)
                
                // the undo button is only shown right after the uncheckAll button pressed and worked.
                if (checkListObject.isShowUndoButton){
                    Button(action: {
                        checkListObject.undoUncheckAll()    //call the class function to undo the uncheckAll operation, all items affected by uncheck all operation will be turn to the original status
                        checkListDataModel.saveCheckData()  // when the data updated, store the data to json file
                    },label: {
                        Image(systemName: "arrow.counterclockwise.circle").foregroundColor(.white)  //set the icon for undo button
                    })
                    .padding()
                    .frame(height:30)
                    .background(Color.red.opacity(0.7))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
            }.padding()
                .background(Color.gray).frame(height: 35)   //set the background colour and button frame
            
            Divider()   //use devider to seperate header and list content
            
            List{   //a container to store all check items
                ForEach(checkListObject.checkList.indices, id: \.self){ // use forEach for instantiation of each check item
                    index in ListRowView(checkItem: checkListObject.checkList[index],checkListObject: checkListObject,checkListDataModel: checkListDataModel)
                }.onDelete{indices in checkListObject.checkList.remove(atOffsets: indices)  // Enable delete list items
                    checkListDataModel.saveCheckData()  // when the data updated, store the data to json file
                }.onMove{indices,pos in checkListObject.checkList.move (fromOffsets: indices, toOffset: pos)    //Enable move the order for each list items
                        checkListDataModel.saveCheckData()  // when the data updated, store the data to json file
                    }
            }.listStyle(.plain)
                .navigationBarTitle(checkListObject.listName)
            
            Spacer()
            
        }.foregroundColor(Color.gray)   //set foreground colour
        .onAppear{
            checkListObject.resetAllHistory()   //when this view updated, the recording of undo operation will be reset
        }.sheet(isPresented: $isAdding){    //if the isAdding status is true, show the floating page AddCheckItemView allow user to add new item
            AddCheckItemView(checkListObject: checkListObject, isAdding:$isAdding,checkListDataModel: checkListDataModel)
        }
    }
}

/** Used for preview*/
struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        let checkList = CheckList(listName: "List 1", checkList: [CheckItem(name: "Item 1", bIsChecked: false)])
        let checkListDataModel = CheckListDataModel(listDataModel: [checkList])
        CheckListView(checkListObject: checkList, checkListDataModel: checkListDataModel)
    }
}
