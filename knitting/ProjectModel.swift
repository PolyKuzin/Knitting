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
    @objc dynamic var tag: String?
    @objc dynamic var imageData: Data?

    convenience init(name: String, tag: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.tag = tag
        self.imageData = imageData
    }
}

struct ProjectMirr {

    var nameMirr: String
    var tagMirr: String
    var imageMirr: String

    static let projectsNamesMirr = [
             "Варежки", "Слоник", "Медведь", "Овоська", "Цыплёнок", "Шарф"
         ]

    static func getProjectsMirr() -> [ProjectMirr] {

         var projectsMirr = [ProjectMirr]()

         for projectMirr in projectsNamesMirr {

             projectsMirr.append(ProjectMirr(nameMirr: projectMirr, tagMirr: "Для себя", imageMirr: projectMirr))
         }

         return projectsMirr
     }
}


