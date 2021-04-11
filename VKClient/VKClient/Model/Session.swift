//
//  Session.swift
//  VKClient
//
//  Created by Lev on 4/11/21.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
    
}
