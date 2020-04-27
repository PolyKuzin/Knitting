//
//  ProjectModel.swift
//  knitting
//
//  Created by Павел Кузин on 27.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import Foundation

struct Project {
    
    var name: String
    var tag: String
    var image: String

    static let projectsNames = [
            "Варежки", "Слоник", "Медведь", "Овоська", "Цыплёнок", "Шарф"
        ]
    
   static func getProjects() -> [Project] {
        
        var projects = [Project]()
        
        for project in projectsNames {
            
            projects.append(Project(name: project, tag: "Для себя", image: project))
        }
        
        return  projects
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


