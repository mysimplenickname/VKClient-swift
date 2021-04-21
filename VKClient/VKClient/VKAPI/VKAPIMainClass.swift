//
//  VKAPIMainClass.swift
//  VKClient
//
//  Created by Lev on 4/14/21.
//

import Foundation
import Alamofire

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
            
            completion(rawPhotos)
        }
    }
    
}