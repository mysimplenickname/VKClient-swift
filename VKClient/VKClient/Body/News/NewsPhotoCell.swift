//
//  NewsPhotoCell.swift
//  VKClient
//
//  Created by Lev on 6/7/21.
//

import UIKit

class NewsPhotoCell: UITableViewCell, SelfConfiguringCell {

    static var reuseIdentifier: String = "PhotoCell"
    
    @IBOutlet weak var newsImageView: UIImageView?
    
    func configureCell(object: Any) {
        
        guard type(of: object) == News.self else { return }
        let news = object as! News
        
        if news.image != nil {
            newsImageView?.image = UIImage(named: news.image!.name)
        }
    }
    
}
