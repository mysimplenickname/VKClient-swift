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
    
    lazy var imageUrl: String? = {
        return sizes.last?.url
    }()
}

// MARK: - Size
struct PhotoModelSize: Codable {
    let height: Int?
    let width: Int?
    let url: String?
    let type: String?
    
    var aspectRatio: CGFloat { return CGFloat(height ?? 1) / CGFloat(width ?? 1) }
}
