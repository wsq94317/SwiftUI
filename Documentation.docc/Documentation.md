#AssignmentOne: Check List App

## Overview

    This document provides an overview of the code for the Check List App. The app is designed to manage check lists, which can include multiple check items. The main components of the app are the CheckItem, CheckList, and CheckListDataModel classes.

## Classes

### CheckItem Class

The CheckItem class represents a single check item in the check list, including its name and status. This class conforms to the Codable, ObservableObject, and Identifiable protocols.

#### Properties

* ‘name: String’: The name of the check item.
* ‘bIsChecked: Bool’: A boolean value indicating whether the check item is checked.
* ‘bIsAutoSwitched: Bool’: A private boolean value for undo operations.
* ‘id: UUID’: A unique identifier for the check item.

#### Initialization

- init(name: String, bIsChecked: Bool): Initializes a new CheckItem instance with a name and a checked status.

#### Codable Conformance

+ CodingKeys: An enumeration for encoding and decoding keys.
+ init(from decoder: Decoder): Initializes a new CheckItem instance from a decoder.
+ encode(to encoder: Encoder): Encodes a CheckItem instance into an encoder.

#### Methods
* setUncheck(): Sets the bIsChecked property to false if it is currently true. This function is only used when the "Uncheck All" button is pressed and can be undone by the undoUncheck() function.
* undoUncheck(): Reverts the bIsChecked property to true if the bIsAutoSwitched property is true.
* resetHistory(): Resets the bIsAutoSwitched property to false.


### CheckList Class

The CheckList class represents a check list containing a list of CheckItem instances and a name. This class conforms to the Codable, ObservableObject, and Identifiable protocols.

#### Properties

* ‘listName: String’: The name of the check list.
* ‘checkList: [CheckItem]’: A list of CheckItem instances in the check list.
* ‘isShowUndoButton: Bool’: A boolean value indicating whether the undo button should be shown.
* ‘id: UUID’: A unique identifier for the check list.

#### Initialization

- init(): Initializes a new CheckList instance with an empty name and list.
- init(listName: String, checkList: [CheckItem]): Initializes a new CheckList instance with a given name and list of check items.

#### Codable Conformance

+ CodingKeys: An enumeration for encoding and decoding keys.
+ init(from decoder: Decoder): Initializes a new CheckList instance from a decoder.
+ encode(to encoder: Encoder): Encodes a CheckList instance into an encoder.

#### Methods

* setListName(listName: String): Sets the name of the check list.
* addItem(newItem: CheckItem): Adds a new CheckItem instance to the check list.
* uncheckAll(): Sets all check items in the check list to the unchecked state.
* undoUncheckAll(): Undoes the unchecking of all check items in the check list.
* resetAllHistory(): Resets the undo history for all check items in the check list.


### CheckListDataModel Class

The CheckListDataModel class represents the data model for the entire check list app. This class conforms to the ObservableObject and `Codable` protocols.

#### Properties

* ‘listDataModel: [CheckList]’: A list of CheckList instances representing the data model for the app.
* ‘dataLoaded: Bool’: A boolean value indicating whether the data has been loaded.


#### Initialization

+ init(): Initializes a new CheckListDataModel instance, loads data from the JSON file, and sets the dataLoaded property.
+ init(listDataModel: [CheckList]): Initializes a new CheckListDataModel instance with a given list of check lists.

####Codable Conformance

- CodingKeys: An enumeration for encoding and decoding keys.
- init(from decoder: Decoder): Initializes a new CheckListDataModel instance from a decoder.
- encode(to encoder: Encoder): Encodes a CheckListDataModel instance into an encoder.

#### Error Handling

+ FileError: An enumeration defining errors related to file operations.

#### File URL

+ fileurl: URL: A computed property that returns the file URL for the JSON file containing the check list data.

#### Methods

* loadCheckData(): Loads check list data from the JSON file and sets the dataLoaded property after a fixed delay.
* saveCheckData(): Saves check list data to the JSON file.
* addNewList(newListName: String): Adds a new CheckList instance with a given name to the data model and saves the data to the JSON file.

## Summary

This document provides an overview of the Check List App, which includes the CheckItem, CheckList, and CheckListDataModel classes. The app allows users to create and manage check lists, each containing multiple check items. The data model is stored in a JSON file, and the app provides functionality for loading, saving, and updating check list data.

## Usage

To use the Check List App, you would typically follow these steps:

1. Initialize a CheckListDataModel instance to manage the data for the entire app:

`let checkListDataModel = CheckListDataModel()`

2. To add a new check list, call the addNewList(newListName: String) method:

`checkListDataModel.addNewList(newListName: "NewListName")`

3. To add a new check item to a specific check list, create a new CheckItem instance and call the addItem(newItem: CheckItem) method on the desired check list:

`let newItem = CheckItem(name: "NewItem", bIsChecked: false)`
`checkListDataModel.listDataModel[0].addItem(newItem: newItem)`

4. To uncheck all items in a specific check list, call the uncheckAll() method:

`checkListDataModel.listDataModel[0].uncheckAll()`

5. To undo an "uncheck all" operation, call the undoUncheckAll() method:

`checkListDataModel.listDataModel[0].undoUncheckAll()`

6. To reset the uncheck all operation history for a specific check list, call the resetAllHistory() method:

`checkListDataModel.listDataModel[0].resetAllHistory()`

7. To save the check list data to the JSON file, call the saveCheckData() method:

`checkListDataModel.loadCheckData()`

8. To load the check list data from the JSON file, call the loadCheckData() method:

`checkListDataModel.loadCheckData()`


