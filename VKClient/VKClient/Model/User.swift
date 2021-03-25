//
//  Structures.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

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
            surnamesArray.append(user.surname)
        }
        surnamesArray.sort()
        
        var sortedArray: [User] = []
        for surname in surnamesArray {
            for elem in unsortedArray {
                if elem.surname == surname {
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
        let surname = user.surname
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
