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
}

class Project: Object {
    
    //need a List of colors to tags backgrounds
    
    @objc dynamic var name = ""
    let tags = List<String?>()
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    let countersNames = List<String?>()

    convenience init(name: String,
                     tag1: String?,
                     tag2: String?,
                     tag3: String?,
                     counterName: String?,
                     imageData: Data?) {
        self.init()
        self.name = name
        self.tags.append(tag1)
        self.tags.append(tag2)
        self.tags.append(tag3)
        self.imageData = imageData
        self.countersNames.append(counterName)
    }
}



