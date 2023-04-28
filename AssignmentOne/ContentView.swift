//
//  ContentView.swift
//  AssignmentOne
//  Created by wsq on 13/3/2023.
//

import SwiftUI

/**
 # ContentView

 This is the main view, which consists of two pages and a floating page.
 
 ## Introduction
 The display of the two pages is determined by the state of CheckListDataModel.dataloaded. The state of CheckListDataModel.dataloaded represents whether the JSON data has been loaded during the initialization of the instance. If the value is true, the MainView is displayed; if the value is false, the loading page is shown. The CheckListDataModel.dataloaded state is bound using @StateObject. When there are changes in the values of the CheckListDataModel, the view will be refreshed. The floating page is controlled by the $isAdding state and is toggled using the .sheet() modifier. When the Add button is pressed, isAdding becomes true, and the floating page pops up. When the floating page successfully adds a new CheckList or cancels the addition, isAdding changes to false.
 
 - Tag: ContentViewExample
 
 ## Example
    ContentView()
 */
struct ContentView: View {
    /// StateObject for the data model, where the app data is stored
    @StateObject var checkListDataModel = CheckListDataModel()
    /// State variable to control the presentation of the AddCheckListView sheet
    @State var isAdding = false
    // State variable to control the loading state
    @State private var isLoading = true
    
    var body: some View {
        Group{
            // If the data is not loaded yet, show the loading view
            if (!$checkListDataModel.dataLoaded.wrappedValue) {
                LoadingView()
            } else {
                // If the data is loaded, show the main content
                NavigationView{
                    VStack{
                        // HStack containing EditButton and Plus Button
                        HStack{
                            EditButton()    //Edit button with style setting
                                .frame(width:60,height:35)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .cornerRadius(10).padding()
                            //Use spacer to separate two buttons on left and right side
                            Spacer()
                            
                            Button(action:{ //Add button with style setting
                                self.isAdding = true
                            },label:{Image(systemName: "plus")})
                                    .frame(width:60,height:35)
                                    .foregroundColor(Color.white)
                                    .background(Color.black)
                                    .cornerRadius(10).padding()
                        }
                        //set background colour
                        .background(.gray).frame(height: 35)
                        //Use divider to seperate header and content
                        Divider()
                        // use list as a container for check list
                        List{
                            // use for loop to generate each line that is the listDataModel
                            ForEach(checkListDataModel.listDataModel){
                                // instantiation a checkListRowView and using NavigationLink link to CheckListView
                                checkList in NavigationLink(destination:CheckListView(checkListObject: checkList,checkListDataModel: checkListDataModel)){
                                    
                                    CheckListRowView(checkListObject:checkList,checkListDataModel: checkListDataModel)
                                }
                            }
                            .onDelete{
                                indices in checkListDataModel.listDataModel.remove(atOffsets: indices)  // Enable delete list items
                                checkListDataModel.saveCheckData()   // when the data updated, store the data to json file
                            }.onMove{
                                indices, pos in checkListDataModel.listDataModel.move(fromOffsets: indices, toOffset: pos)  // Enable move the order of list items
                                checkListDataModel.saveCheckData()   // when the data updated, store the data to json file
                            }
                        }.navigationViewStyle(StackNavigationViewStyle()).navigationTitle("Memorandum list").font(.title)   //Set the navigation Style, and set the Title of this page
                    }
                }.sheet(isPresented: $isAdding){
                    AddCheckListView(checkListDataModel: checkListDataModel, isAdding: $isAdding)   // add floating view and enable the view switching, when the isAdding status is true, the floating view AddCheckListView will be shown, after add operation is done, the status of isAdding will turn to false, then close the floating view
                }
            }
        }
    }
}

/** Used for preview*/
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
