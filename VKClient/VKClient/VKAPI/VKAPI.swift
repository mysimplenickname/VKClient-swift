//
//  VKAPIMainClass.swift
//  VKClient
//
//  Created by Lev on 4/14/21.
//

import Foundation
import Alamofire

let HOST = "https://api.vk.com"
let VERSION = "5.131"

//func getUserInfo(for userId: Int, completion: @escaping (UserModelItem) -> Void) {
//    let path = "/method/users.get"
//
//    let parameters: Parameters = [
//        "user_ids": userId,
//        "fields": "photo_200_orig",
//        "access_token": Session.shared.token,
//        "v": VERSION
//    ]
//
//    AF.request(HOST + path, method: .get, parameters: parameters).responseData { response in
//
//        guard let data = response.value else { return }
//
//        var user: UserModelItem?
//
//        do {
//            user = try JSONDecoder().decode(UserModel.self, from: data).response.items[0]
//        } catch {
//            print(error)
//        }
//
//        completion(user!)
//    }
//
//}

//func getGroupInfo(for groupId: Int, completion: @escaping (GroupModelItem) -> Void) {
//    let path = "/mathod/groups.getById"
//
//    let parameters: Parameters = [
//        "group_id": groupId,
//        "fields": "photo_200",
//        "access_token": Session.shared.token,
//        "v": VERSION
//    ]
//
//    AF.request(HOST + path, method: .get, parameters: parameters).responseData { response in
//
//        guard let data = response.value else { return }
//
//        var group: GroupModelItem?
//
//        do {
//            group = try JSONDecoder().decode(SingleGroupModel.self, from: data).response[0]
//        } catch {
//            print(error)
//            print("error: ", try? JSONDecoder().decode(ErrorModel.self, from: data))
//        }
//
//        DispatchQueue.main.async {
//            completion(group ?? GroupModelItem(id: 0, name: "", mainPhoto: ""))
//        }
//    }
//}

func getFriends(for userId: Int, completion: @escaping ([RealmUserModelItem]) -> Void ) {
    let path = "/method/friends.get"
    
    let parameters: Parameters = [
        "fields": "photo_100",
        "user_id": userId,
        "access_token": Session.shared.token,
        "v": VERSION
    ]
    
    AF.request(HOST + path, method: .get, parameters: parameters).responseData { response in

        guard let data = response.value else { return }
        
        var rawFriends = [UserModelItem]()
        
        do {
            rawFriends = try JSONDecoder().decode(UserModel.self, from: data).response.items
        } catch {
            print(error)
            do {
                print(try JSONDecoder().decode(ErrorModel.self, from: data))
            } catch {
                print(error)
            }
        }
        
        saveObjects(raw: rawFriends, type: RealmUserModelItem.self)
        
        completion(convertToObjects(raw: rawFriends) as! [RealmUserModelItem])
    }
}

func getGroups(for userId: Int, completion: @escaping ([RealmGroupModelItem]) -> Void) {
    let path = "/method/groups.get"
    
    let parameters: Parameters = [
        "extended": "1",
        "fields": "photo_200",
        "user_id": userId,
        "access_token": Session.shared.token,
        "v": VERSION
    ]
    
    AF.request(HOST + path, method: .get, parameters: parameters).responseData { response in
        
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
        
        saveObjects(raw: rawGroups, type: RealmGroupModelItem.self)
        
        completion(convertToObjects(raw: rawGroups) as! [RealmGroupModelItem])
    }
}

func searchGroups(for userId: Int, searchString: String, completion: @escaping ([RealmGroupModelItem]) -> Void) {
    let path = "/method/groups.search"
    
    let parameters: Parameters = [
        "q": searchString,
        "type": "group, page",
        "user_id": userId,
        "access_token": Session.shared.token,
        "v": VERSION
    ]
    
    AF.request(HOST + path, method: .get, parameters: parameters).responseData { response in
        
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
        
        completion(convertToObjects(raw: rawGroups) as! [RealmGroupModelItem])
        
    }
    
}
    
func getPhotos(ownerId: Int, completion: @escaping ([RealmPhotoModelItem]) -> Void) {
    let path = "/method/photos.getAll"
    
    let parameters: Parameters = [
        "owner_id": ownerId,
        "access_token": Session.shared.token,
        "v": VERSION
    ]
    
    AF.request(HOST + path, method: .get, parameters: parameters).responseData { response in
        
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
        
        saveObjects(raw: rawPhotos, type: RealmPhotoModelItem.self)
        
        completion(convertToObjects(raw: rawPhotos) as! [RealmPhotoModelItem])
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

func getNews(ownerId: Int, completion: @escaping (NewsModelResponse) -> Void) {
    let path = "/method/newsfeed.get"
    
    let parameters: Parameters = [
        "filters": "post",
        "count": "5",
        "return_banned": "0",
        "access_token": Session.shared.token,
        "v": VERSION
    ]
    
    AF.request(HOST + path, method: .get, parameters: parameters).responseData { response in
        
        guard let data = response.value else { return }
        
        var rawNews: NewsModelResponse?
        
        do {
            rawNews = try JSONDecoder().decode(NewsModel.self, from: data).response
        } catch {
            print(error)
            do {
                print(try JSONDecoder().decode(ErrorModel.self, from: data))
            } catch {
                print(error)
            }
        }
        
        completion(rawNews ?? NewsModelResponse(items: [], profiles: [], groups: []))
    }
}
