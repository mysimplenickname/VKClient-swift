//
//  VKAPIMainClass.swift
//  VKClient
//
//  Created by Lev on 4/14/21.
//

import Foundation
import Alamofire

class VKAPIMainClass {
    
    static func getFriends() {
        let host = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let version = "5.130"
        
        let parameters: Parameters = [
            "user_id": Session.instance.userId,
            "access_token": Session.instance.token,
            "v": version
        ]
        
        let url = host + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value as Any)
        }
    }
    
    static func getGroups() {
        let host = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let version = "5.130"
        
        let parameters: Parameters = [
            "user_id": Session.instance.userId,
            "access_token": Session.instance.token,
            "v": version
        ]
        
        let url = host + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value as Any)
        }
    }
    
    static func getPhotos() {
        let host = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let version = "5.130"
        
        let parameters: Parameters = [
            "owner_id": Session.instance.userId,
            "access_token": Session.instance.token,
            "v": version
        ]
        
        let url = host + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value as Any)
        }
    }
    
}
