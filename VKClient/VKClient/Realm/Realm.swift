//
//  Realm.swift
//  VKClient
//
//  Created by Lev on 4/28/21.
//

import Foundation
import RealmSwift

//MARK: - Realm methods
func convertToObjects(raw: [Any]) -> [Object] {
    
    if raw is [UserModelItem] {
        let rawUsers = raw as! [UserModelItem]
        var realmUsers = [RealmUserModelItem]()
        for rawElem in rawUsers {
            let realmUser = RealmUserModelItem()
            realmUser.id = rawElem.id
            realmUser.firstName = rawElem.firstName
            realmUser.lastName = rawElem.lastName
            realmUser.mainPhoto = rawElem.mainPhoto
            realmUsers.append(realmUser)
        }
        return realmUsers
    }
    
    if raw is [GroupModelItem] {
        let rawGroups = raw as! [GroupModelItem]
        var realmGroups = [RealmGroupModelItem]()
        for rawGroup in rawGroups {
            let realmGroup = RealmGroupModelItem()
            realmGroup.id = rawGroup.id
            realmGroup.name = rawGroup.name
            realmGroup.mainPhoto = rawGroup.mainPhoto
            realmGroups.append(realmGroup)
        }
        return realmGroups
    }
    
    if raw is [PhotoModelItem] {
        let rawPhotos = raw as! [PhotoModelItem]
        var realmPhotos = [RealmPhotoModelItem]()
        for rawPhoto in rawPhotos {
            let realmPhoto = RealmPhotoModelItem()
            realmPhoto.id = rawPhoto.id
            realmPhoto.ownerId = rawPhoto.ownerID
            realmPhoto.url = rawPhoto.sizes[3].url
            realmPhotos.append(realmPhoto)
        }
        return realmPhotos
    }
    
    return [Object()]
}

func saveObjects(raw: [Any], type: Object.Type) {
    
    let newObjects = convertToObjects(raw: raw)
    
    do {
        let realm = try Realm()
        let oldRealmGroups = Array(realm.objects(type))
        realm.beginWrite()
        realm.delete(oldRealmGroups)
        realm.add(newObjects)
        try realm.commitWrite()
    } catch {
        print(error)
    }
}

func getGroupsFromRealm() -> [RealmGroupModelItem] {
    
    var realmGroups = [RealmGroupModelItem]()
    
    do {
        let realm = try Realm()
        let results = realm.objects(RealmGroupModelItem.self)
        realmGroups = Array(results)
    } catch {
        print(error)
    }
    
    return realmGroups
    
}
