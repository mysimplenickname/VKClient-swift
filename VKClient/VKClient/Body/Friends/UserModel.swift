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
//    let count: Int
    let items: [UserModelItem]
}

//MARK: - Item
struct UserModelItem: Codable {
    let id: Int
    let firstName, lastName: String
    let mainPhoto: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case mainPhoto = "photo_100"
    }
}

//MARK: - Realm object
class RealmUserModelItem: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var mainPhoto: String = ""
}
