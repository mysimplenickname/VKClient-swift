//
//  Realm.swift
//  VKClient
//
//  Created by Lev on 4/28/21.
//

import Foundation
import RealmSwift

//MARK: - Realm methods
func convertToObject(raw: [Any]) -> [Object] {
    
    if type(of: raw) == [UserModelItem].self {
        let rawUser = raw as! [UserModelItem]
        let realmUser = [RealmUserModelItem]()
        for rawElem in rawUser {
            for realmElem in realmUser {
                realmElem.id = rawElem.id
                realmElem.firstName = rawElem.firstName
                realmElem.lastName = rawElem.lastName
                realmElem.mainPhoto = rawElem.mainPhoto
            }
        }
        return realmUser
    }
    
    if type(of: raw) == [PhotoModelItem].self {
        let rawPhoto = raw as! [PhotoModelItem]
        let realmPhoto = [RealmPhotoModelItem]()
        for rawElem in rawPhoto {
            for realmElem in realmPhoto {
                realmElem.id = rawElem.id
                realmElem.ownerId = rawElem.ownerID
                realmElem.url = rawElem.sizes[3].url
            }
        }
        return realmPhoto
    }
    
    if type(of: raw) == [GroupModelItem].self {
        let rawGroup = raw as! [GroupModelItem]
        let realmGroup = [RealmGroupModelItem]()
        for rawElem in rawGroup {
            for realmElem in realmGroup {
                realmElem.id = rawElem.id
                realmElem.name = rawElem.name
                realmElem.mainPhoto = rawElem.mainPhoto
            }
        }
        return realmGroup
    }
    
    return [Object()]
}

func saveObject(object: Object) {
    do {
        let realm = try Realm()
        realm.beginWrite()
        realm.add(object)
        try realm.commitWrite()
    } catch {
        print(error)
    }
}
