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
}

struct NewsModelItem: Codable {
    let type: String
    let sourceId: Int
    let date: Int
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case type = "post_type"
        case sourceId = "source_id"
        case date
        case text
    }
}

struct NewsModelForUse {
    let name: String
    let mainPhoto: String
    let text: String
}
