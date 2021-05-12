//
//  UserModel.swift
//  VKClient
//
//  Created by Lev on 4/21/21.
//

import Foundation

//MARK: - UserModel
struct UserModel: Codable {
    let response: UserModelResponse
}

//MARK: - Response
struct UserModelResponse: Codable {
    let count: Int
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
        case mainPhoto = "photo_200_orig"
    }
}
