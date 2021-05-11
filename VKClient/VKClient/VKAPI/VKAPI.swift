//
//  VKAPIMainClass.swift
//  VKClient
//
//  Created by Lev on 4/14/21.
//

import Foundation
import Alamofire

func getFriends(for userId: Int, completion: @escaping ([RealmUserModelItem]) -> Void ) {
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
        
        let realmFriends = convertToObjects(raw: rawFriends)
        for realmFriend in realmFriends {
            saveObject(object: realmFriend)
        }
        
        completion(realmFriends as! [RealmUserModelItem])
    }
}

func getGroups(for userId: Int, completion: @escaping ([RealmGroupModelItem]) -> Void) {
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
        
        saveObjects(raw: rawGroups)
        
        completion(convertToObjects(raw: rawGroups) as! [RealmGroupModelItem])
    }
}
    
func getPhotos(ownerId: Int, completion: @escaping ([RealmPhotoModelItem]) -> Void) {
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
        
        let realmPhotos = convertToObjects(raw: rawPhotos)
        for realmPhoto in realmPhotos {
            saveObject(object: realmPhoto)
        }
        
        completion(realmPhotos as! [RealmPhotoModelItem])
    }
}

func loadPhoto(from url: URL, completion: @escaping (UIImage) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async() {
            completion(UIImage(data: data)!)
        }
    }.resume()
}
