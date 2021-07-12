//
//  GroupModel.swift
//  VKClient
//
//  Created by Lev on 4/21/21.
//

import Foundation

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
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "photo_200"
    }
}

struct SingleGroupModel: Codable {
    let response: [GroupModelItem]
}
