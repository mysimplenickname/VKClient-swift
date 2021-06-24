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
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T> else { return }
        
        controller.friends = parseDataOperation.outputData as! [UserModelItem]
        controller.friendsForUse = parseDataOperation.outputData as! [UserModelItem]
        controller.tableView.reloadData()
    }
    
}
