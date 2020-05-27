//
//  ProjectModel.swift
//  knitting
//
//  Created by Павел Кузин on 27.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//
import Foundation

struct Counter {
    var name = ""
    var rows = 0
    var rowsMax = 0
    var projectID = 0
    var counterID = 0
    var congratulations = false
    
}

struct Project {
        
    var name = ""
    var tags: [String?]
    var imageProjectForMainScreen: Data?
    var imageProject: Data?
    var date = Date()
    var projectID = 0

//    init(name: String,
//                     tags: [String?],
//                     projectID: Int,
//                     imageProjectForMainScreen: Data?,
//                     imageProject: Data? ) {
//
//        self.name = name
//        for tag in tags {
//            self.tags.append(tag)
//        }
//        self.imageProjectForMainScreen = imageProjectForMainScreen
//        self.imageProject = imageProject
//        self.projectID = projectID

    //}
}



