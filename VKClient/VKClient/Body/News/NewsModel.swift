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
    let profiles: [UserModelItem]
    var groups: [GroupModelItem]
}

struct NewsModelItem: Codable {
    let sourceId: Int
    let date: Int
    let postType: String
    let text: String
    var attachments: [NewsAttachmentItem]
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case postType = "post_type"
        case text
        case attachments
    }
}

struct NewsAttachmentItem: Codable {
    let type: String?
    var photo: PhotoModelItem?
}
