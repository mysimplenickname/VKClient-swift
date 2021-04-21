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
    let count: Int
    let items: [GroupModelItem]
}

//MARK: - Item
struct GroupModelItem: Codable {
    let id: Int
    let name: String
    let mainPhoto: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case mainPhoto = "photo_200"
    }
}