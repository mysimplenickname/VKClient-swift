//
//  NewsViewController.swift
//  VKClient
//
//  Created by Lev on 3/21/21.
//

import UIKit
import Alamofire

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var news = NewsModelResponse(
        items: [],
        profiles: [],
        groups: [],
        nextFrom: ""
    )
    
    var nextFrom = ""
    var isLoading = false
    
    private var imageService: ImageService?
    
    private let queueForNews = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNews(startFrom: nil, startTime: nil)
        nextFrom = news.nextFrom ?? ""
        
        imageService = ImageService(container: tableView)
        
        tableView.register(NewsAuthorCell.self, forCellReuseIdentifier: NewsAuthorCell.reuseIdentifier)
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: NewsTextCell.reuseIdentifier)
        tableView.register(NewsImageCell.self, forCellReuseIdentifier: NewsImageCell.reuseIdentifier)
        tableView.register(NewsInteractionCell.self, forCellReuseIdentifier: NewsInteractionCell.reuseIdentifier)
        
        setupRefreshControl()
        
        tableView.prefetchDataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        news.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorCell.reuseIdentifier) as! NewsAuthorCell
            guard let imageUrl = news.sources?[indexPath.section].authorImageUrl else { return UITableViewCell() }
            let image = imageService?.getImage(atIndexPath: indexPath, byUrl: imageUrl)
            let name = news.sources?[indexPath.section].authorName
            cell.configureCell(image: image, name: name)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseIdentifier) as! NewsTextCell
            let text = news.items[indexPath.section].text
            cell.configureCell(text: text)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageCell.reuseIdentifier) as! NewsImageCell
            guard
                let attachments = news.items[indexPath.section].attachments,
                let imageUrl = attachments[0].photo?.imageUrl
            else { return UITableViewCell() }
            let image = imageService?.getImage(atIndexPath: indexPath, byUrl: imageUrl)
            cell.configureCell(image: image)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsInteractionCell.reuseIdentifier) as! NewsInteractionCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 67
        case 1:
            if news.items[indexPath.section].text.isEmpty { return 0 }
            return UITableView.automaticDimension
        case 2:
            guard
                let attachments = news.items[indexPath.section].attachments,
                let imageAspectRatio = attachments[0].photo?.aspectRatio
            else { return 0 }
            let tableWidth = tableView.bounds.width
            let cellHeight = tableWidth * imageAspectRatio
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
    private func getNews(startFrom: String?, startTime: String?) {
        
        let parameters: Parameters = [
            "filters": "post",
            "count": "10",
            "start_from": startFrom ?? "",
            "start_time": startTime ?? "",
            "access_token": Session.shared.token,
            "v": "5.131"
        ]
        
        let request = Alamofire.request(
            "https://api.vk.com/method/newsfeed.get",
            method: .get,
            parameters: parameters
        )
        
        let getDataOperation = GetDataOperation(request: request)
        queueForNews.addOperation(getDataOperation)
        
        let parseDataOperation = ParseDataOperation<NewsModel>()
        parseDataOperation.addDependency(getDataOperation)
        queueForNews.addOperation(parseDataOperation)
        
        if startFrom == nil && startTime == nil {
            let reloadTableOperation = ReloadTableOperation<NewsModel>(controller: self)
            reloadTableOperation.addDependency(parseDataOperation)
            OperationQueue.main.addOperation(reloadTableOperation)
        } else if startFrom == nil && startTime != nil {
            let loadNewsToTopOperation = LoadNewsToTopOperation(controller: self)
            loadNewsToTopOperation.addDependency(parseDataOperation)
            OperationQueue.main.addOperation(loadNewsToTopOperation)
        } else if startFrom != nil && startTime == nil {
            let loadNewsToBottomOperation = LoadNewsToBottomOperation(controller: self)
            loadNewsToBottomOperation.addDependency(parseDataOperation)
            OperationQueue.main.addOperation(loadNewsToBottomOperation)
        }
        
    }

}

extension NewsViewController {
    
    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .gray
        tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc private func refreshNews() {
        tableView.refreshControl?.beginRefreshing()
        getNews(startFrom: nil, startTime: String((news.items.first?.date ?? Int(Date().timeIntervalSince1970)) + 1))
    }
    
}

extension NewsViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        if maxSection > news.items.count - 3 && !isLoading {
            isLoading = true
            getNews(startFrom: nextFrom, startTime: nil)
            
        }
    }
    
}
