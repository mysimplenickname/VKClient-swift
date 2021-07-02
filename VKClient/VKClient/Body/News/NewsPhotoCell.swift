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
        
        if (news.attachments?.count) != nil {
            newsImageView?.image = news.attachments!.first?.photo?.image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView?.image = nil
    }
    
}
