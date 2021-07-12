//
//  NewsModel.swift
//  VKClient
//
//  Created by Lev on 6/12/21.
//

import Foundation

struct NewsModel: Codable {
    let response: NewsModelResponse
}

struct NewsModelResponse: Codable {
    let items: [NewsModelItem]
    let profiles: [UserModelItem]
    let groups: [GroupModelItem]
}

struct NewsModelItem: Codable {
    let sourceId: Int
    let date: Int
    let postType: String
    let text: String
    let attachments: [NewsAttachmentItem]
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case postType = "post_type"
        case text
        case attachments
    }
}

struct NewsAttachmentItem: Codable {
    let type: String
    let photo: PhotoModelItem
}
