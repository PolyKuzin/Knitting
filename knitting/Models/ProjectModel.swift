//
//  ProjectModel.swift
//  knitting
//
//  Created by Павел Кузин on 27.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import RealmSwift

class Project: Object {
    
    @objc dynamic var name = ""
    let tags = List<String?>()
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()

    convenience init(name: String,
                     tag: String?,
                     imageData: Data?) {
        self.init()
        self.name = name
        self.tags.append(tag)
        self.imageData = imageData
    }
}



