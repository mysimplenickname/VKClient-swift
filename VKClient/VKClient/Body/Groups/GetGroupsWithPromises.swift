//
//  GetGroupsWithPromises.swift
//  VKClient
//
//  Created by Lev on 6/22/21.
//

import Foundation
import PromiseKit
import Alamofire

func getGroups(for userId: Int) -> Promise<[GroupModelItem]> {
    
    let HOST = "https://api.vk.com"
    let VERSION = "5.131"
    let path = "/method/groups.get"

    let parameters: Parameters = [
        "extended": "1",
        "fields": "photo_200",
        "user_id": userId,
        "access_token": Session.shared.token,
        "v": VERSION
    ]
    
    return Promise { seal in
        Alamofire.request(HOST + path, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let rawData = try JSONDecoder().decode(GroupModel.self, from: data).response.items
                    seal.fulfill(rawData)
                } catch {
                    return seal.reject(error)
                }
            case .failure(let error):
                seal.reject(error)
            }
        }
    }
    
}
