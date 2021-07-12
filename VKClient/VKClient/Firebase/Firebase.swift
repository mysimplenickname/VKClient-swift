//
//  Firebase.swift
//  VKClient
//
//  Created by Lev on 5/27/21.
//

import Foundation
import FirebaseDatabase

class FirebaseUser {
    let firstName, lastName: String
    let id: Int
    let ref: DatabaseReference?
    
    init(firstName: String, lastName: String, id: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let id = value["id"] as? Int
        else {
            return nil
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "id": id
        ]
    }
}

class FirebaseGroup {
    let name: String
    let id: Int
    let ref: DatabaseReference?
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let name = value["name"] as? String,
            let id = value["id"] as? Int
        else {
            return nil
        }
        
        self.name = name
        self.id = id
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "name": name,
            "id": id
        ]
    }
}
