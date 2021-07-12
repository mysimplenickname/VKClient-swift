//
//  ReloadTableOperation.swift
//  VKClient
//
//  Created by Lev on 6/22/21.
//

import Foundation
import UIKit

class ReloadTableOperation<T: Codable>: Operation {
    
    private var controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T> else { return }
        
        switch controller {
        case is FriendsViewController:
            let friendsViewController = controller as! FriendsViewController
            friendsViewController.friends = parseDataOperation.outputData as! [UserModelItem]
            friendsViewController.friendsForUse = parseDataOperation.outputData as! [UserModelItem]
            friendsViewController.tableView.reloadData()
        case is NewsViewController:
            let newsViewController = controller as! NewsViewController
            let parsedData = parseDataOperation.outputData as! NewsModelResponse
            newsViewController.news = parsedData
            newsViewController.nextFrom = parsedData.nextFrom ?? ""
            newsViewController.tableView.reloadData()
        default:
            break
        }
        
    }
    
}
