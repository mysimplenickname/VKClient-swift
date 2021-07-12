//
//  ErrorModel.swift
//  VKClient
//
//  Created by Lev on 6/16/21.
//

import Foundation

struct ErrorModel: Codable {
    let error: ErrorModelResponse
}

struct ErrorModelResponse: Codable {
    let errorCode: Int
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}

