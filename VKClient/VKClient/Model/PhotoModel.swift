//
//  PhotoModel.swift
//  VKClient
//
//  Created by Lev on 4/21/21.
//

import Foundation

// MARK: - PhotoModel
struct PhotoModel: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let albumID, date, id, ownerID: Int
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: String
    let width: Int
}
