//
//  CounterToKnit.swift
//  knitting
//
//  Created by Павел Кузин on 27.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import Foundation
import Firebase

struct CounterToKnit {
    
    let ref             : DatabaseReference?
    let userID          : String
    var projectID       : Int
    var name            : String
    var rows            : Int
    var rowsMax         : Int
    //var counterID       : Int
    var congratulations : Bool = false
    
    init(userID: String, projectID: Int, name: String, rows: Int, rowsMax: Int) {
        self.userID = userID
        self.projectID = projectID
        self.name = name
        self.rows = rows
        self.rowsMax = rowsMax
        self.ref = nil
    }
    
    init( snapshot: DataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        userID = snapshotValue["userID"] as! String
        projectID = snapshotValue["projectID"] as! Int
        name = snapshotValue["name"] as! String
        rows = snapshotValue["rows"] as! Int
        rowsMax = snapshotValue["rowsMax"] as! Int
        congratulations = snapshotValue["congratulations"] as! Bool
        ref = snapshot.ref
    }
    
    func counterToDictionary () -> Any {
        return ["useID"             : userID,
                "projectID"         : projectID,
                "name"              : name,
                "rows"              : rows,
                "rowsMax"           : rowsMax,
                "congratulations"   : congratulations]
    }
}

//    func converToDictionary() -> Any {
//        return ["useID"     : userID,
//                "name"      : name,
//                "imageData" : imageData,
//                "tags"      : tags,
//                "completed" : completed]
//    }
//}
