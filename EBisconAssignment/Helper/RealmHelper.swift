//
//  RealmHelper.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 2/3/24.
//

import Foundation
import RealmSwift
class RealmHelper {
    var realm:Realm!
    init(){
        var config = Realm.Configuration()

                 config.fileURL = config

                     .fileURL!

                     .deletingLastPathComponent()

                     .appendingPathComponent("cognity.realm")
             
           

                 config.schemaVersion = 60

                 config.migrationBlock = { _, oldSchemaVersion in

                     if oldSchemaVersion < 1 {}
                 }
              do{
                  realm = try Realm(configuration: config)
              }
              catch{
                  
              }
    }
    func saveObject<T:Object>(object: T) async {
        try! await realm?.asyncWrite{
            realm.add(object,update: .all)
        }
    }
  
 
}
