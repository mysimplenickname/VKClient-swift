//
//  PhotoModel.swift
//  VKClient
//
//  Created by Lev on 4/21/21.
//

import Foundation
import RealmSwift

// MARK: - PhotoModel
struct PhotoModel: Codable {
    let response: PhotoModelResponse
}

// MARK: - Response
struct PhotoModelResponse: Codable {
    let items: [PhotoModelItem]
}

// MARK: - Item
struct PhotoModelItem: Codable {
    let albumID, date, id, ownerID: Int
    let sizes: [PhotoModelSize]

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes
    }
    
    var imageUrl: String? { return sizes.last?.url }
    
    var aspectRatio: CGFloat { return CGFloat(sizes.last?.height ?? 1) / CGFloat(sizes.last?.width ?? 1) }
}

// MARK: - Size
struct PhotoModelSize: Codable {
    let type: String?
    let url: String?
    let height: Int?
    let width: Int?
}
