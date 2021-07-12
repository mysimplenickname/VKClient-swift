//
//  Photo.swift
//  VKClient
//
//  Created by Lev on 3/14/21.
//

import Foundation

struct Photo: Codable {
    
    var name: String,
        id: Int,
        owner_id: Int,
        likes: UInt,
        isLiked: Bool
    
}
