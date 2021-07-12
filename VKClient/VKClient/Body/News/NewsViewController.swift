//
//  NewsViewController.swift
//  VKClient
//
//  Created by Lev on 3/21/21.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var imageService: ImageService?
    
    var news: NewsModelResponse?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getNews(ownerId: Session.shared.userId) { [self] rawNews in
            news = rawNews
            tableView.reloadData()
        }
        
        imageService = ImageService(container: tableView)
        
        tableView.register(UINib(nibName: "NewsAuthorCell", bundle: nil), forCellReuseIdentifier: NewsAuthorCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsTextCell", bundle: nil), forCellReuseIdentifier: NewsTextCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsPhotoCell", bundle: nil), forCellReuseIdentifier: NewsPhotoCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsInteractionCell", bundle: nil), forCellReuseIdentifier: NewsInteractionCell.reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if indexPath.row % 4 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorCell.reuseIdentifier, for: indexPath) as! NewsAuthorCell
            
            let groupImage = imageService?.getImage(atIndexPath: indexPath, byUrl: news?.groups[indexPath.section].imageUrl ?? "") ?? UIImage()
            
            DispatchQueue.main.async {
                self.news?.groups[indexPath.section].image = groupImage
            }

            cell.configureCell(object: news?.groups[indexPath.section] ?? Void.self)
            return cell
        } else if indexPath.row - 1 % 4 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseIdentifier, for: indexPath) as! NewsTextCell
            cell.configureCell(object: news?.items[indexPath.section] ?? Void.self)
            return cell
        } else if indexPath.row - 2 % 4 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseIdentifier, for: indexPath) as! NewsPhotoCell
            
            if (news!.items[indexPath.section].attachments?.count) != nil {
                for (i, attachment) in news!.items[indexPath.section].attachments!.enumerated() {
                    if attachment.type == "photo" {
                        let attachmentImage = imageService?.getImage(atIndexPath: indexPath, byUrl: news?.items[indexPath.section].attachments![i].photo?.imageUrl ?? "") ?? UIImage()
                        
                        DispatchQueue.main.async {
                            self.news?.items[indexPath.section].attachments![i].photo?.image = attachmentImage
                        }
                    }
                }
            }
            
            cell.configureCell(object: news?.items[indexPath.section] ?? Void.self)
            return cell
        } else if indexPath.row - 3 % 4 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsInteractionCell.reuseIdentifier, for: indexPath) as! NewsInteractionCell
            cell.configureCell(object: Void.self)
            return cell
        }
        return NewsAuthorCell()
    }

}
