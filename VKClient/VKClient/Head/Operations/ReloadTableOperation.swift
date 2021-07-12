//
//  ReloadTableOperation.swift
//  VKClient
//
//  Created by Lev on 6/22/21.
//

import Foundation
import UIKit

class ReloadTableOperation<T: Codable>: Operation {
    
    var controller: FriendsViewController
    
    init(controller: FriendsViewController) {
        self.controller = controller
    }
    
    override func main() {
        guard let convertDataToRealmObjects = dependencies.first as? ConvertDataToRealmObjects<T> else { return }
        
        controller.realmFriends = convertDataToRealmObjects.outputData as! [RealmUserModelItem]
        controller.realmFriendsForUse = convertDataToRealmObjects.outputData as! [RealmUserModelItem]
        controller.tableView.reloadData()
    }
    
}
