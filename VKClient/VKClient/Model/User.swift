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
               user3 = User(name: "Li", surname: "Ning", images: []),
               user4 = User(name: "Eren", surname: "Eger", images: []),
               user5 = User(name: "Alan", surname: "Turing", images: []),
               user6 = User(name: "John", surname: "Snow", images:
                                [
                                    Photo(name: "johnsnow1", likes: 0, isLiked: false),
                                    Photo(name: "johnsnow2", likes: 0, isLiked: false),
                                    Photo(name: "johnsnow3", likes: 0, isLiked: false)
                                ]),
               user7 = User(name: "Andrew", surname: "Cool", images: []),
               user8 = User(name: "Sam", surname: "Hammer", images: []),
               user9 = User(name: "Anna", surname: "Taylor", images: []),
               user10 = User(name: "Lisa", surname: "Brown", images: [])
        
    static func loadUsers() -> [User] {
        return
            [
                User.user1,
                User.user2,
                User.user3,
                User.user4,
                User.user5,
                User.user6,
                User.user7,
                User.user8,
                User.user9,
                User.user10
            ]
    }
}
