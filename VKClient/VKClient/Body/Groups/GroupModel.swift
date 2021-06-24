//
//  GroupModel.swift
//  VKClient
//
//  Created by Lev on 4/21/21.
//

import Foundation
import RealmSwift

//MARK: - GroupModel
struct GroupModel: Codable {
    let response: GroupModelResponse
}

//MARK: - Response
struct GroupModelResponse: Codable {
    let items: [GroupModelItem]
}

//MARK: - Item
struct GroupModelItem: Codable {
    let id: Int
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "photo_200"
    }
    
    var image: UIImage?
}

struct SingleGroupModel: Codable {
    let response: [GroupModelItem]
}

//MARK: - Realm object
class RealmGroupModelItem: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var imageUrl: String = ""
}