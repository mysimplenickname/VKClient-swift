//
//  VKAPIMainClass.swift
//  VKClient
//
//  Created by Lev on 4/14/21.
//

import Foundation
import Alamofire
import RealmSwift

class VKAPIMainClass {
    
    static func getFriends(for userId: Int, completion: @escaping ([UserModelItem]) -> Void ) {
        let host = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let version = "5.130"
        
        let parameters: Parameters = [
            "fields": "photo_200_orig",
            "user_id": userId,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        AF.request(host + path, method: .get, parameters: parameters).responseData { response in

            guard let data = response.value else { return }
            
            var rawFriends = [UserModelItem]()
            
            do {
                rawFriends = try JSONDecoder().decode(UserModel.self, from: data).response.items
            } catch {
                print(error)
            }
            
            for rawElem in rawFriends {
                let realmElem = convertToObject(raw: rawElem)
                saveObject(object: realmElem)
            }
            
            completion(rawFriends)
        }
    }
    
    static func getGroups(for userId: Int, completion: @escaping ([GroupModelItem]) -> Void) {
        let host = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let version = "5.130"
        
        let parameters: Parameters = [
            "extended": "1",
            "fields": "photo_200",
            "user_id": userId,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        AF.request(host + path, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.value else { return }
            
            var rawGroups = [GroupModelItem]()
            
            do {
                rawGroups = try JSONDecoder().decode(GroupModel.self, from: data).response.items
            } catch {
                print(error)
            }
            
            for rawElem in rawGroups {
                let realmElem = convertToObject(raw: rawElem)
                saveObject(object: realmElem)
            }
            
            completion(rawGroups)
        }
    }
    
    static func getPhotos(ownerId: Int, completion: @escaping ([PhotoModelItem]) -> Void) {
        let host = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let version = "5.130"
        
        let parameters: Parameters = [
            "owner_id": ownerId,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        AF.request(host + path, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.value else { return }
            
            var rawPhotos = [PhotoModelItem]()
            
            do {
                rawPhotos = try JSONDecoder().decode(PhotoModel.self, from: data).response.items
            } catch {
                print(error)
            }
            
            for rawElem in rawPhotos {
                let realmElem = convertToObject(raw: rawElem)
                saveObject(object: realmElem)
            }
            
            completion(rawPhotos)
        }
    }
    
}

extension VKAPIMainClass {
    
    static func loadPhoto(from url: URL, completion: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(UIImage(data: data)!)
            }
        }.resume()
    }

}

//MARK: - Realm methods

extension VKAPIMainClass {
    
    static func convertToObject(raw: Any) -> Object {
        
        if type(of: raw) == UserModelItem.self {
            let rawUser = raw as! UserModelItem
            let realmUser = RealmUserModelItem()
            realmUser.id = rawUser.id
            realmUser.firstName = rawUser.firstName
            realmUser.lastName = rawUser.lastName
            realmUser.mainPhoto = rawUser.mainPhoto
            return realmUser
        }
        
        if type(of: raw) == PhotoModelItem.self {
            let rawPhoto = raw as! PhotoModelItem
            let realmPhoto = RealmPhotoModelItem()
            realmPhoto.id = rawPhoto.id
            realmPhoto.ownerId = rawPhoto.ownerID
            realmPhoto.url = rawPhoto.sizes[3].url
            return realmPhoto
        }
        
        if type(of: raw) == GroupModelItem.self {
            let rawGroup = raw as! GroupModelItem
            let realmGroup = RealmGroupModelItem()
            realmGroup.id = rawGroup.id
            realmGroup.name = rawGroup.name
            realmGroup.mainPhoto = rawGroup.mainPhoto
            return realmGroup
        }
        
        return Object()
    }
    
    static func saveObject(object: Object) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(object)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
}
