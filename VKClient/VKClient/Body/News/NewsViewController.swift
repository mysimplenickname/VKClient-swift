//
//  NewsViewController.swift
//  VKClient
//
//  Created by Lev on 3/21/21.
//

import UIKit
import Alamofire

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var news = NewsModelResponse(
        items: [],
        profiles: [],
        groups: [],
        nextFrom: ""
    )
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NewsAuthorCell.self, forCellReuseIdentifier: NewsAuthorCell.reuseIdentifier)
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: NewsTextCell.reuseIdentifier)
        tableView.register(NewsImageCell.self, forCellReuseIdentifier: NewsImageCell.reuseIdentifier)
        tableView.register(NewsInteractionCell.self, forCellReuseIdentifier: NewsInteractionCell.reuseIdentifier)
    }
    
    let queueForNews = OperationQueue()
    
    var imageService: ImageService?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getNews()
        
        imageService = ImageService(container: tableView)
    }
    
    private func getNews() {
        
        let parameters: Parameters = [
            "filters": "post",
            "count": "10",
            "start_from": "",
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
        
        let reloadTableOperation = ReloadTableOperation<NewsModel, NewsViewController>(controller: self)
        reloadTableOperation.addDependency(parseDataOperation)
        OperationQueue.main.addOperation(reloadTableOperation)
        
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
                let _ = news.items[indexPath.section].attachments,
                let imageUrl = news.items[indexPath.section].attachments?[0].photo?.imageUrl
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

}
