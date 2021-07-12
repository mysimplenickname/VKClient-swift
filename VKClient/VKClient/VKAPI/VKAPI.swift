//
//  VKAPIMainClass.swift
//  VKClient
//
//  Created by Lev on 4/14/21.
//

import Foundation
import Alamofire
import UIKit

func searchGroups(for userId: Int, searchString: String, completion: @escaping ([GroupModelItem]) -> Void) {
    
    let parameters: Parameters = [
        "q": searchString,
        "type": "group, page",
        "user_id": userId,
        "access_token": Session.shared.token,
        "v": "5.131"
    ]
    
    Alamofire.request("https://api.vk.com/method/groups.search", method: .get, parameters: parameters).responseData { response in
        
        guard let data = response.value else { return }
        
        var rawGroups = [GroupModelItem]()
        
        do {
            rawGroups = try JSONDecoder().decode(GroupModel.self, from: data).response.items
        } catch {
            print(error)
            do {
                print(try JSONDecoder().decode(ErrorModel.self, from: data))
            } catch {
                print(error)
            }
        }
        
        completion(rawGroups)
        
    }
    
}
    
func getPhotos(ownerId: Int, completion: @escaping ([PhotoModelItem]) -> Void) {
    
    let parameters: Parameters = [
        "owner_id": ownerId,
        "access_token": Session.shared.token,
        "v": "5.131"
    ]
    
    Alamofire.request("https://api.vk.com/method/photos.getAll", method: .get, parameters: parameters).responseData { response in
        
        guard let data = response.value else { return }
        
        var rawPhotos = [PhotoModelItem]()
        
        do {
            rawPhotos = try JSONDecoder().decode(PhotoModel.self, from: data).response.items
        } catch {
            print(error)
            do {
                print(try JSONDecoder().decode(ErrorModel.self, from: data))
            } catch {
                print(error)
            }
        }
        
        completion(rawPhotos)
    }
}
