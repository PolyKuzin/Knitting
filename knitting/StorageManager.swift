//
//  StorageManager.swift
//  knitting
//
//  Created by Павел Кузин on 28.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject (_ project: Project){
        
        try! realm.write {
            realm.add(project)
        }
    }
    
    static func deleteObject(_ project: Project){
        
        try! realm.write{
            realm.delete(project)
        }
    }
}
