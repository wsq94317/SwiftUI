//
//  AssignmentOneApp.swift
//  AssignmentOne
//
//  Created by wsq on 13/3/2023.
//

import SwiftUI
/**
 # AssignmentOneAPP
 
 This is the main entry point for the Assignment One App
 
 # Introduction
 
 This app is a Check List App. Upon opening the app, a list of CheckLists will be displayed. By tapping on a list, users can access the detailed checklist containing all the items within that list. Users have the ability to add new checklists, modify checklist names, adjust the order of checklists, and delete checklists by swiping to the right. Additionally, users can add new items within a checklist, adjust item statuses, modify item names, delete items by swiping right, uncheck all items with a single button, and restore the items that were unchecked using the "Uncheck All" feature.
 
 */
@main
struct AssignmentOneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
