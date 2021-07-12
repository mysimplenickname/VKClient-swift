//
//  LoadNewsToBottomOperation.swift
//  VKClient
//
//  Created by Lev on 7/11/21.
//

import UIKit

class LoadNewsToBottomOperation: Operation {
    
    private var controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    override func main() {
        
        guard
            let parseDataOperation = dependencies.first as? ParseDataOperation<NewsModel>,
            let newsController = controller as? NewsViewController
        else { return }
        
        let newNews = parseDataOperation.outputData as! NewsModelResponse
        newsController.nextFrom = newNews.nextFrom ?? ""
        
        var oldNews = newsController.news
        
        oldNews.items += newNews.items
        oldNews.groups += newNews.groups
        oldNews.profiles += newNews.profiles
        oldNews.sources! += (newNews.sources)!

        newsController.news = oldNews
        
        newsController.tableView.reloadData()

        newsController.isLoading = false
        
    }
    
}


