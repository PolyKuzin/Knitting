//
//  ProjectModel.swift
//  knitting
//
//  Created by Павел Кузин on 27.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import RealmSwift

class Counter: Object {
    @objc dynamic var name = ""
//    let countersNames = List<String?>()
    @objc dynamic var rows = 0
//    let countersRowsMax = List<Int?>()
    @objc dynamic var rowsMax = 0
    @objc dynamic var id = 0
    
    convenience init (name: String,
                      rows: Int,
                      rowsMax: Int,
                      id: Int) {
        
        self.init()
        self.name = name
        self.rows = rows
        self.rowsMax = rowsMax
        self.id = id
    }
}

class Project: Object {
    
    //need a List of colors to tags backgrounds
    
    @objc dynamic var name = ""
    let tags = List<String?>()
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    @objc dynamic var id = 0

    convenience init(name: String,
                     tag1: String?,
                     tag2: String?,
                     tag3: String?,
                     id: Int,
                     imageData: Data?) {
        self.init()
        self.name = name
        self.tags.append(tag1)
        self.tags.append(tag2)
        self.tags.append(tag3)
        self.imageData = imageData
        self.id = id

    }
}



