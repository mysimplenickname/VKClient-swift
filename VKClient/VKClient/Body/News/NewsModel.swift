//
//  NewsModel.swift
//  VKClient
//
//  Created by Lev on 6/12/21.
//

import Foundation
import UIKit

struct NewsModel: Codable {
    let response: NewsModelResponse
}

struct NewsModelResponse: Codable {
    var items: [NewsModelItem]
    var profiles: [UserModelItem]
    var groups: [GroupModelItem]
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
    
    var sources: [NewsModelItem]?
}

struct NewsModelItem: Codable {
    let sourceId: Int
    let date: Int
    let postType: String
    let text: String
    var attachments: [NewsAttachmentItem]?
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case postType = "post_type"
        case text
        case attachments
    }
    
    var authorName: String?
    var authorImageUrl: String?
}

struct NewsAttachmentItem: Codable {
    var type: String?
    var photo: PhotoModelItem?
}
