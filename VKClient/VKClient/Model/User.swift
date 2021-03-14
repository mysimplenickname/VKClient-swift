//
//  Structures.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import Foundation

struct User {
    
    var name: String,
        surname: String,
        images: [Photo]
    
    var fullname: String {
        return name + " " + surname
    }
    
}

extension User {
    static let user1 = User(name: "Adam", surname: "Willson", images: []),
               user2 = User(name: "Alex", surname: "Smith", images: []),
               user3 = User(name: "John", surname: "Snow", images: [
                Photo(name: "johnsnow1", likes: 0, isLiked: false),
                Photo(name: "johnsnow2", likes: 0, isLiked: false),
                Photo(name: "johnsnow3", likes: 0, isLiked: false)
               ])
    
    static func loadUsers() -> [User] {
        return [User.user1, User.user2, User.user3]
    }
}
