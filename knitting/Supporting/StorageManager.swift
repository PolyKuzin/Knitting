////
////  StorageManager.swift
////  knitting
////
////  Created by Павел Кузин on 28.04.2020.
////  Copyright © 2020 Павел Кузин. All rights reserved.
////
//
//import RealmSwift
//
//let realm = try! Realm()
//
//class StorageManager {
//    
//    static func saveObject (_ project: Project){
//        
//        try! realm.write {
//            realm.add(project)
//        }
//    }
//    
//    static func deleteObject(_ project: Project){
//        
//        try! realm.write{
//            realm.delete(project)
//        }
//    }
//    static func saveCounter(_ counter: Counter){
//        
//        try! realm.write {
//            realm.add(counter)
//        }
//    }
//    static func deleteCounters(_ counter: Counter){
//        
//        try! realm.write{
//            realm.delete(counter)
//        }
//    }
//    static func saveRowsInCounter(_ currentCounter: Counter,_ rows: Int){
//        
//        try! realm.write{
//            currentCounter.rows = rows
//        }
//    }
//    static func congratulations (_ currentCounter: Counter){
//        
//        try! realm.write{
//            currentCounter.congratulations = true
//        }
//    }
//}
