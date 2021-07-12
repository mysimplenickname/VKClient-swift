//
//  LoadNewsToTopOperation.swift
//  VKClient
//
//  Created by Lev on 7/11/21.
//

import UIKit

class LoadNewsToTopOperation: Operation {
    
    private var controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    override func main() {
        
        guard let newsController = controller as? NewsViewController else { return }
        
        newsController.tableView.refreshControl?.endRefreshing()
        
        guard
            let parseDataOperation = dependencies.first as? ParseDataOperation<NewsModel>,
            let newNews = parseDataOperation.outputData as? NewsModelResponse
        else { return }
        
        var oldNews = newsController.news
        
        oldNews.items = newNews.items + oldNews.items
        oldNews.groups = newNews.groups + oldNews.groups
        oldNews.profiles = newNews.profiles + oldNews.profiles
        oldNews.sources = (newNews.sources)! + oldNews.sources!
        
        newsController.news = oldNews
        
        newsController.tableView.reloadData()
        
    }
    
}
