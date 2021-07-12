//
//  UserModel.swift
//  VKClient
//
//  Created by Lev on 4/21/21.
//

import Foundation
import RealmSwift

//MARK: - UserModel
struct UserModel: Codable {
    let response: UserModelResponse
}

//MARK: - Response
struct UserModelResponse: Codable {
    let items: [UserModelItem]
}

//MARK: - Item
struct UserModelItem: Codable {
    let id: Int
    let firstName, lastName: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case imageUrl = "photo_100"
    }
    
    lazy var fullname = {
        return firstName + " " + lastName
    }()
    
    var image: UIImage?
}

//MARK: - Realm object
class RealmUserModelItem: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var fullName: String = ""
    @objc dynamic var imageUrl: String = ""
}
