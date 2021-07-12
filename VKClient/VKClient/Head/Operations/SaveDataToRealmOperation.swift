//
//  SaveDataToRealmOperation.swift
//  VKClient
//
//  Created by Lev on 6/22/21.
//

import Foundation
import RealmSwift

class SaveDataToRealmOperation<T: Codable>: Operation {
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T>,
              let data = parseDataOperation.outputData else { return }
        
        do {
            let realm = try Realm()
            let oldRealmObjects = Array(realm.objects(data.self as! Object.Type))
            realm.beginWrite()
            realm.delete(oldRealmObjects)
            realm.add(data as! [Object])
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
}
