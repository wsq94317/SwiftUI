# CheckList App

___MileStone3 Version

The CheckList App is a simple and user-friendly application for creating and managing checklists. Users can create multiple checklists, add items to each list, and toggle the status of each item.

This document provides an overview of the application structure and code organization.

## New Features

- Create multiple checklists
- Add items to each checklist
- While Undo function is unavailable, Undo button will be hidden
- Data storage updated from struct to class
- Automatically save and load data using JSON
- Codable conformance for data models
- Add "AddCheckList" and "AddCheckItem" view to add new list or item
- Manage the order for Check List and Check Item
- Swipe to delete item or check list
- App Icon
- Loading page
- Rename check lists or items

## Structure

### CheckItem

The CheckItem class represents a single item in a checklist. It has the following properties:

+ name: The name of the item
+ bIsChecked: The status of the item (checked or unchecked)
+ id: A unique identifier for the item
+ The CheckItem class also contains methods for setting the item's status, undoing the "Uncheck All" operation, and resetting the history.

### CheckList

The CheckList class represents a single checklist containing a list of CheckItem instances. It has the following properties:

+ listName: The name of the checklist
+ checkList: An array of CheckItem instances
+ isShowUndoButton: A boolean value indicating whether the undo button should be shown
+ id: A unique identifier for the checklist
+ The CheckList class also contains methods for setting the list name, adding items, toggling the status of all items, undoing the "Uncheck All" operation, and resetting the history.

### CheckListDataModel

The CheckListDataModel class represents the data model for the entire CheckList App. It has the following properties:

+ listDataModel: An array of CheckList instances
+ dataLoaded: A boolean value indicating whether the data has been loaded
+ The CheckListDataModel class also contains methods for loading and saving data using JSON, adding new lists, and initializing the data model.

## Usage

To use the CheckList App, simply run the project in Xcode and follow the on-screen instructions to create checklists, add items, and toggle item status, manage the order, delete item and checklists.


## Testing

- ContentView Test:

1. Verify if the loading screen can transition to the main view.
2. Transition to CheckListView and then back to ContentView, and check if the LoadingView appears.
3. Check if the app name "Memorandum List" is correctly displayed at the top of the screen.
4. Add a new CheckList, click the add button, and see if the add interface pops up.
5. Click the edit button and check if all items enter the edit state.
6. Click on a CheckList and see if it transitions to the corresponding page.
7. In edit state, adjust the order of the checklists.
8. In edit state, swipe right and check if a checklist can be deleted.
9. Click the edit button when there's no content in the main view and check if there's an error.
10. After adding a new checklist, exit the main view, and check if the previously added content is saved when restarting the app.

- AddCheckListView Test:

1. Check if the text in the view is correctly displayed.
2. Check if there's a response when clicking the Add button with an empty checklist name.
3. After entering a correct checklist name, click Add and check if the page closes correctly and updates in ContentView.
4. Click the cancel button and check if the page closes correctly.

- CheckListView Test:
1. Check if the CheckList name is displayed correctly.
2. Click the back button to see if it returns to ContentView.
3. Click the add button and check if it transitions to AddCheckListView.
4. Click the Edit button when the CheckList is empty and check if there's an error.
5. Click the Uncheck all button when the CheckList is empty and check if there's an error.
6. Check if the Undo button is displayed when opening CheckListView for the first time.
7. Click the edit button and check if it enters the edit state.
8. Click the edit button and check if the edit button changes to the Done button after entering the edit state.
9. Click the edit button and check if the check item name changes after clicking Done without changing the check item name.
10. Click the edit button, enter the edit state, and check if the check item status can be toggled.
11. Change any check item status, return to ContentView, and check if the change is recorded.
12. Change any check item status, close the app, and check if the change is recorded upon reopening.
13. Click on a single check item multiple times and check if the app crashes.
14. In edit state, click on a single check item multiple times and check if the app crashes.
15. When all check items are unchecked, click Uncheck all and check if the Undo button appears.
16. When all check items are unchecked, click Uncheck all and check if any check item status changes.
17. When some check items are checked and others are unchecked, click Uncheck all, and check if all check items become unchecked.
18. When some check items are checked and others are unchecked, click Uncheck all, then click Undo, and check if the previously unchecked items become checked.
19. In edit state, adjust the order of check items, click Done, and check if the order has changed.
20. In edit state, adjust the order of check items, click Done, return to ContentView, and check if the adjustment is recorded.
21. In edit state, adjust the order of check items, click Done, close the app and re-enter, and check if the adjustment is saved.

- AddCheckItemView Test:

1. Check if all text is correctly displayed.
2. Check if there is a response when clicking the Add button with an empty input.
3. With correct input, click the Add button and check if it returns to the previous level and adds the item correctly.
4. With the toggle set to true and correct


## What I have learnt

During the development of the CheckList app, I have expanded my knowledge and gained new skills related to SwiftUI development. Based on the provided information and code, here are some of the new things I have learned:

1. Deepening my understanding and usage of SwiftUI Views: I have further explored creating and managing more complex custom views and have become more efficient in handling their properties and functions.
2. Advanced state management: I have gained experience in dealing with more complex state management, including synchronizing and updating app data across multiple levels of views.
3. Implementing data persistence with Core Data: I have learned how to use Core Data for data persistence, allowing me to store CheckList and CheckItem data on the device and load it when the app is relaunched.
4. Passing data between views: I have mastered the skill of passing data between multiple views, allowing for seamless sharing and updating of data across different levels of views.
5. Creating custom animations and visual effects: I have learned to create custom animations and visual effects using the tools and methods provided by SwiftUI, which enhances the user experience of the app.
6. Exploring new features and components of SwiftUI: I have likely discovered and utilized some new features and components of SwiftUI to build my app interface and functionalities more efficiently.
7. Performance optimization and debugging: During the development process, I have also learned how to optimize the performance of the app and resolve potential issues and bugs.

In summary, the development of the CheckList app has not only solidified my previously acquired skills but has also equipped me with numerous new skills and concepts, laying a strong foundation for my future SwiftUI development endeavors.


___ MileStone2 Version
## Overview

This CheckList app is a simple SwiftUI application that allows users to create and manage multiple checklists. Each checklist contains a list of items that can be checked/unchecked, added, or removed. The app also provides the ability to undo "Uncheck all" action, reverting the items to their original state.

## Features

- Create and manage multiple checklists: Users can create multiple checklists with custom names and navigate between them using the NavigationView.
- Add items to the checklists: Users can add new items to a specific checklist.
- Check/Uncheck items: Each item in the checklist can be checked or unchecked to indicate its completion status.
- Uncheck all items: Users can uncheck all items in a checklist with a single button press.
- Undo uncheck all items: Users can revert the changes made by the "Uncheck all" action, restoring the original state of the checklist.
- Delete items: Users can remove items from a checklist.

## Usage

- Create a new checklist: Press the "+" button in the top-right corner of the navigation view to create a new checklist.
- Navigate to a checklist: Tap on a checklist name in the navigation view to open the corresponding checklist.
- Add a new item to a checklist: Press the "+" button in the top-right corner of the checklist view to add a new item.
- Check/Uncheck items: Tap the checkbox next to an item to toggle its checked state.
- Uncheck all items: Press the "Uncheck all" button in the top-right corner of the checklist view to uncheck all items.
- Undo uncheck all items: Press the "Undo uncheck all" button in the top-right corner of the checklist view to restore the original state of the checklist.
- Delete items: Enter edit mode by tapping the "Edit" button in the top-right corner of the checklist view, then swipe left on an item to reveal the delete button, and tap the delete button to remove the item.

## What I've learnt

In the CheckList app, I have learned various technical skills and concepts related to SwiftUI development, including:

1. Creating and managing SwiftUI Views: I learned how to create custom views, such as CheckListView, ListRowView, and ContentView, and how to manage their properties and functions.
2. Using State and Binding: I gained experience in handling state management in SwiftUI by using @State, @StateObject, and @Binding. These tools help in keeping the app data synchronized and updated across different views.
3. Creating and using data models: I learned to create custom data models such as CheckItem and NavigationListItem and use them to manage and store data for the app.
4. Working with Lists and ForEach: I acquired knowledge in handling lists and iterating through their elements using ForEach and displaying them in the UI. This includes adding, removing, and updating elements within the list.
5. Implementing Navigation: I learned how to use NavigationView and NavigationLink to create a navigation hierarchy and navigate between different views in the app.
6. Adding Navigation Bar Items: I understood how to add and customize navigation bar items, such as EditButton, Button, and images, to perform various actions in the app.
7. Using Gestures and Actions: I developed skills in handling user interactions with the app by using gestures and actions, such as onTapGesture and button actions.
8. Implementing Undo functionality:I learned how to store previous states and implement an Undo functionality in the app.

By working on this project, I have gained a deeper understanding of SwiftUI and its capabilities, which will be beneficial for future app development projects.



