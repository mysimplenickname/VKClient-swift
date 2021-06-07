//
//  NewsViewController.swift
//  VKClient
//
//  Created by Lev on 3/21/21.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let news = News(
        authorImage: Photo(name: "johnsnow3", id: 0, owner_id: 0, likes: 0, isLiked: false),
        authorLabel: "John Snow",
        text: "Hello!",
        image: Photo(name: "johnsnow1", id: 0, owner_id: 0, likes: 0, isLiked: false)
    )
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewsAuthorCell", bundle: nil), forCellReuseIdentifier: NewsAuthorCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsTextCell", bundle: nil), forCellReuseIdentifier: NewsTextCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsPhotoCell", bundle: nil), forCellReuseIdentifier: NewsPhotoCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsInteractionCell", bundle: nil), forCellReuseIdentifier: NewsInteractionCell.reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorCell.reuseIdentifier, for: indexPath) as! NewsAuthorCell
            cell.configureCell(object: news)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseIdentifier, for: indexPath) as! NewsTextCell
            cell.configureCell(object: news)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseIdentifier, for: indexPath) as! NewsPhotoCell
            cell.configureCell(object: news)
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsInteractionCell.reuseIdentifier, for: indexPath) as! NewsInteractionCell
            cell.configureCell(object: news)
            return cell
        }
        return NewsAuthorCell()
    }

}
