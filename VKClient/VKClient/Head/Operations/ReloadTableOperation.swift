//
//  ReloadTableOperation.swift
//  VKClient
//
//  Created by Lev on 6/22/21.
//

import Foundation
import UIKit

class ReloadTableOperation<T: Codable, C: UIViewController>: Operation {
    
    var controller: C
    
    init(controller: C) {
        self.controller = controller
    }
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T> else { return }
        
        switch C.self {
        case is FriendsViewController.Type:
            (controller as! FriendsViewController).friends = parseDataOperation.outputData as! [UserModelItem]
            (controller as! FriendsViewController).friendsForUse = parseDataOperation.outputData as! [UserModelItem]
            (controller as! FriendsViewController).tableView.reloadData()
        case is NewsViewController.Type:
            (controller as! NewsViewController).news = (parseDataOperation.outputData as! NewsModelResponse)
            (controller as! NewsViewController).tableView.reloadData()
        default:
            break
        }
        
    }
    
}
