//
//  ConvertDataToRealmObjects.swift
//  VKClient
//
//  Created by Lev on 6/22/21.
//

import Foundation
import RealmSwift

class ConvertDataToRealmObjects<T: Codable>: Operation {
    
    var outputData: [Object]?
    
    override func main() {
        
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T>,
              let data = parseDataOperation.outputData else { return }
        
        print(data.self)
        
        switch data.self {
        case is [UserModelItem]:
            let rawUsers = data as! [UserModelItem]
            var realmUsers = [RealmUserModelItem]()
            for rawElem in rawUsers {
                let realmUser = RealmUserModelItem()
                realmUser.id = rawElem.id
                realmUser.firstName = rawElem.firstName
                realmUser.lastName = rawElem.lastName
                realmUser.mainPhoto = rawElem.mainPhoto
                realmUsers.append(realmUser)
            }
            outputData = realmUsers
        case is [GroupModelItem]:
            let rawGroups = data as! [GroupModelItem]
            var realmGroups = [RealmGroupModelItem]()
            for rawGroup in rawGroups {
                let realmGroup = RealmGroupModelItem()
                realmGroup.id = rawGroup.id
                realmGroup.name = rawGroup.name
                realmGroup.mainPhoto = rawGroup.mainPhoto
                realmGroups.append(realmGroup)
            }
            outputData = realmGroups
        case is [PhotoModelItem]:
            let rawPhotos = data as! [PhotoModelItem]
            var realmPhotos = [RealmPhotoModelItem]()
            for rawPhoto in rawPhotos {
                let realmPhoto = RealmPhotoModelItem()
                realmPhoto.id = rawPhoto.id
                realmPhoto.ownerId = rawPhoto.ownerID
                realmPhoto.url = rawPhoto.sizes[3].url
                realmPhotos.append(realmPhoto)
            }
            outputData = realmPhotos
        default:
            break
        }
    }
    
}
