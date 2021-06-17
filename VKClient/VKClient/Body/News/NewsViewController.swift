//
//  NewsViewController.swift
//  VKClient
//
//  Created by Lev on 3/21/21.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var news = [NewsModelItem]()
    
    var preparedNews = [NewsModelForUse]()
    let numberOfPreparedNews = 20
    
    var counter: Int = -1
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getNews(ownerId: Session.shared.userId) { [self] rawNews in
            news = rawNews
            if rawNews.count > numberOfPreparedNews {
                preparedNews = prepareNews(news: rawNews.suffix(numberOfPreparedNews))
            } else {
                preparedNews = prepareNews(news: rawNews)
            }
            
            tableView.reloadData()
        }
       
        print(preparedNews)
        
        tableView.register(UINib(nibName: "NewsAuthorCell", bundle: nil), forCellReuseIdentifier: NewsAuthorCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsTextCell", bundle: nil), forCellReuseIdentifier: NewsTextCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsPhotoCell", bundle: nil), forCellReuseIdentifier: NewsPhotoCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsInteractionCell", bundle: nil), forCellReuseIdentifier: NewsInteractionCell.reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("\n \(indexPath) \(indexPath.row) \(counter) \n")
        if indexPath.row % 4 == 0 {
            counter = counter < news.count - 1 ? counter + 1 : 0
            if Double(counter / numberOfPreparedNews) > 0 {
                preparedNews = []
                let from = Int(counter / numberOfPreparedNews) * numberOfPreparedNews
                if from + numberOfPreparedNews < news.count {
                    preparedNews = prepareNews(news: Array(news[from..<from + numberOfPreparedNews]))
                } else {
                    preparedNews = prepareNews(news: Array(news[from..<news.count]))
                }
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorCell.reuseIdentifier, for: indexPath) as! NewsAuthorCell
            cell.configureCell(object: preparedNews[Int(counter / numberOfPreparedNews)])
            return cell
        } else if indexPath.row - 1 % 4 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseIdentifier, for: indexPath) as! NewsTextCell
            cell.configureCell(object: preparedNews[Int(counter / numberOfPreparedNews)])
            return cell
        } else if indexPath.row - 2 % 4 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseIdentifier, for: indexPath) as! NewsPhotoCell
            cell.configureCell(object: preparedNews[Int(counter / numberOfPreparedNews)])
            return cell
        } else if indexPath.row - 3 % 4 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsInteractionCell.reuseIdentifier, for: indexPath) as! NewsInteractionCell
            cell.configureCell(object: preparedNews[Int(counter / numberOfPreparedNews)])
            return cell
        }
        return NewsAuthorCell()
    }

}

extension NewsViewController {

    func prepareNews(news: [NewsModelItem]) -> [NewsModelForUse] {
        
        var preparedNews = [NewsModelForUse]()
        
        for elem in news {
            if elem.sourceId > 0 {
                getUserInfo(for: elem.sourceId) { user in
                    let newElem = NewsModelForUse(name: user.firstName + " " + user.lastName, mainPhoto: user.mainPhoto, text: elem.text)
                    preparedNews.append(newElem)
                }
            } else {
                let newsSourceId: Int = elem.sourceId * -1
                getGroupInfo(for: newsSourceId) { group in
                    let newElem = NewsModelForUse(name: group.name, mainPhoto: group.mainPhoto, text: elem.text)
                    DispatchQueue.main.async {
                        preparedNews.append(newElem)
                    }
                }
            }
        }
        
        return preparedNews
    }
    
}
