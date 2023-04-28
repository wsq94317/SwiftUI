//
//  Struct.swift
//  AssignmentOne
//
//  Created by wsq on 1/4/2023.
//

import Foundation


// MARK: - CheckItem
/**
 # CheckItem

 Represents a single check item in the check list, including its name and status.
 
 */
class CheckItem: Codable,ObservableObject,Identifiable {
    var name : String
    @Published var bIsChecked: Bool
    /// a mark for undo operation
    private var bIsAutoSwitched = false
    ///a unique mark to iterate
    let id = UUID()
    enum CodingKeys: String, CodingKey{
        case name, bIsChecked
    }
    
    // MARK: - Initialization
    init(name:String, bIsChecked:Bool){
        self.name = name
        self.bIsChecked = bIsChecked
//        self.bIsCanBeCanceled = bIsCanBeCanceled
    }
    
    //init decoder
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        bIsChecked = try container.decode(Bool.self, forKey: .bIsChecked)
    }
    
    // MARK: - Codable Conformance
    ///encode function to encode data
    func encode(to encoder:Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(bIsChecked, forKey: .bIsChecked)
    }
    
    // MARK: - Methods
    /// this function is only use the button "uncheck all" which can be undo by the undo button
    func setUncheck(){
        if (bIsChecked == true){
            bIsChecked = false
            bIsAutoSwitched = true
        }
    }
    
    ///this function is to undo a uncheck all operation
    func undoUncheck(){
        if (bIsAutoSwitched){
            bIsChecked = true
            bIsAutoSwitched = false
        }
    }
    
    /// in some circunstances, the auto uncheck recording will be reset, such as user continue his next step, user go back to parent page
    func resetHistory(){
        bIsAutoSwitched = false
    }
}

// MARK: - CheckList
/**
 # CheckList
 
 Represents a check list containing a list of CheckItem instances and its name.
 */
class CheckList: Codable, ObservableObject, Identifiable{
    /// variable to store list name
    @Published var listName : String
    ///all check item data will be stored in a list
    @Published var checkList : [CheckItem] = []
    /// undo button status
    @Published var isShowUndoButton = false
    
    enum CodingKeys: String, CodingKey{
        case listName, checkList
    }
    
    /// a unique mark for iteration
    var id = UUID()
    
    // MARK: - Initialization
    init(){
        listName = ""
        checkList = []
    }
    init(listName: String, checkList:[CheckItem]){
        self.listName = listName
        self.checkList = checkList
    }
    
    // MARK: - Codable Conformance
    ///init Decoder
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        listName = try container.decode(String.self, forKey: .listName)
        checkList = try container.decode([CheckItem].self, forKey: .checkList)
    }
    
    ///init encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(listName,forKey: .listName)
        try container.encode(checkList, forKey: .checkList)
    }
    
    // MARK: - Methods
    /// this function is to change the list name while in edit mode
    func setListName(listName:String){
        self.listName = listName
    }
    
    /// this function is to add new check list
    func addItem(newItem:CheckItem){
        checkList.append(newItem)
    }
    
    /// this function is to uncheck all item in this check list while user pressed uncheck all
    func uncheckAll(){
        for checkItem in checkList {
            if (checkItem.bIsChecked) {
                isShowUndoButton = true // when this operation truly switched a item, the undo button will be shown
            }
            checkItem.setUncheck()
        }
    }
    
    /// called to undo the uncheck all operation
    func undoUncheckAll(){
        for checkItem in checkList {
            checkItem.undoUncheck()
        }
        isShowUndoButton = false
    }
    
    /// if user go to another page or continue other operation, the undo button status will be updated
    func resetAllHistory(){
        for checkItem in checkList {
            checkItem.resetHistory()
        }
        isShowUndoButton = false
    }
}


// MARK: - CheckListDataModel
/**
 # CheckListDataModel
 
 Represents the data model for the entire check list app.
 */

class CheckListDataModel: ObservableObject, Codable {
    enum CodingKeys : CodingKey {
        case listDataModel
    }
    
    // MARK: - Codable Conformance
    ///init decoder
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        listDataModel = try container.decode([CheckList].self, forKey: .listDataModel)
    }
    
    ///init encoder
    func encode(to encoder:Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(listDataModel, forKey: .listDataModel)
    }
    
    // MARK: - Error Handling
    /// define errors
    enum FileError: Error {
        case dirNotFound
    }
    
    // MARK: - File URL
    ///create the file location as url
    static var fileurl: URL {
        get throws {
            let fileName = "checkListData1.json"
            let fm = FileManager.default
            guard let path = fm.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
            else{
                throw FileError.dirNotFound
            }
            return path.appendingPathComponent(fileName)
        }
    }
    
    // MARK: - Methods
    ///function to load data from json file
    func loadCheckData(){
        do{
            let fileurl = try CheckListDataModel.fileurl
            if FileManager.default.fileExists(atPath: fileurl.path){
                let data = try Data(contentsOf: fileurl)
                let datamodel = try JSONDecoder().decode(CheckListDataModel.self, from: data)
                listDataModel = datamodel.listDataModel
            } else {
                let data = try JSONEncoder().encode(CheckListDataModel(listDataModel: []))
                FileManager.default.createFile(atPath: fileurl.path, contents: data, attributes: nil)
                listDataModel = []
            }
        } catch let error {
            print("Error loading data: \(error)")
            listDataModel = []
        }
        // this status will updated when user first open this app, but it is too fast to change the status. so I write down a constant time delay to show the loading view
//        self.dataLoaded = true
        let delayTime:TimeInterval = 1.0
        let deadline = DispatchTime.now()+delayTime
        DispatchQueue.main.asyncAfter(deadline:deadline) {
            self.dataLoaded = true
        }
    }
    
    
    /// function to save data to json file
    func saveCheckData(){
        do{
            let data = try JSONEncoder().encode(self)
            let url = try CheckListDataModel.fileurl
            print("filepath:\(url)")
            try data.write(to:url, options: .atomic)
        } catch {
            print("There is an Error to load data")
            listDataModel = []
        }
    }
    
    ///function to add a new check list to data model
    func addNewList(newListName:String){
        let newCheckList = CheckList(listName: newListName, checkList: [])
        self.listDataModel.append(newCheckList)
        saveCheckData()
    }
    
    // MARK: - Properties
    @Published var listDataModel:[CheckList]
    @Published var dataLoaded = false
    
    // MARK: - Initialization
    init() {
        listDataModel = []
        loadCheckData()
    }
    init(listDataModel:[CheckList]){
        self.listDataModel = listDataModel
    }
}
