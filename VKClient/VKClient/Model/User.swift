//
//  Structures.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

struct User {
    
    var first_name: String,
        last_name: String,
        id: Int,
        photo_id: String?,
        images: [Photo]
    
    var fullname: String {
        return first_name + " " + last_name
    }
    
}

extension User {
    static let user1 = User(first_name: "John", last_name: "Snow", id: 0, photo_id: "", images:
                         [
                            Photo(name: "johnsnow1", id: 0, owner_id: 0, likes: 0, isLiked: false),
                             Photo(name: "johnsnow2", id: 0, owner_id: 0, likes: 0, isLiked: false),
                             Photo(name: "johnsnow3", id: 0, owner_id: 0, likes: 0, isLiked: false)
                         ]),
               user2 = User(first_name: "Alex", last_name: "Smith", id: 0, photo_id: "", images: []),
               user3 = User(first_name: "Li", last_name: "Ning", id: 0, photo_id: "", images: []),
               user4 = User(first_name: "Eren", last_name: "Eger", id: 0, photo_id: "", images: []),
               user5 = User(first_name: "Alan", last_name: "Turing", id: 0, photo_id: "", images: []),
               user6 = User(first_name: "Adam", last_name: "Willson", id: 0, photo_id: "", images: []),
               user7 = User(first_name: "Andrew", last_name: "Cool", id: 0, photo_id: "", images: []),
               user8 = User(first_name: "Sam", last_name: "Hammer", id: 0, photo_id: "", images: []),
               user9 = User(first_name: "Anna", last_name: "Taylor", id: 0, photo_id: "", images: []),
               user10 = User(first_name: "Lisa", last_name: "Brown", id: 0, photo_id: "", images: [])
}

extension User {
    static func loadUsers() -> [User] {
        return sortUsers(unsortedArray:
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
        )
    }
    
    static func sortUsers(unsortedArray: [User]) -> [User] {
        var surnamesArray: [String] = []
        for user in unsortedArray {
            surnamesArray.append(user.last_name)
        }
        surnamesArray.sort()
        
        var sortedArray: [User] = []
        for surname in surnamesArray {
            for elem in unsortedArray {
                if elem.last_name == surname {
                    sortedArray.append(elem)
                }
            }
        }
        
        return sortedArray
    }
    
    static func firstLetters(users: [User]) -> [Character] {
        var letters: [Character] = []
        for user in users {
            let letter = firstLetter(user: user)
            if letters.firstIndex(of: letter) == nil {
                letters.append(letter)
            }
        }
        return letters
    }
    
    static func firstLetter(user: User) -> Character {
        let surname = user.last_name
        return surname[surname.index(surname.startIndex, offsetBy: 0)]
    }
    
    static func arrangeUsers(users: [User]) -> [[User]] {
        let letters: [Character] = firstLetters(users: users)
        
        var arrangedArray: [[User]] = []
        for _ in 0..<letters.count {
            arrangedArray.append([])
        }
        
        var userIndex: Int = 0
        for i in 0..<letters.count {
            while userIndex < users.count && letters[i] == firstLetter(user: users[userIndex]) {
                arrangedArray[i].append(users[userIndex])
                userIndex += 1
            }
        }
        
        return arrangedArray
    }
}
