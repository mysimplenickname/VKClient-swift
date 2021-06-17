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
        
        guard type(of: object) == NewsModelItem.self else { return }
        let news = object as! NewsModelItem
        
        if news.attachments.count != 0 {
            guard let url = URL(string: news.attachments[0].photo.sizes[3].url) else { return }
            loadPhoto(from: url) { [self] image in
                newsImageView?.image = image
            }
        }
    }
    
}
