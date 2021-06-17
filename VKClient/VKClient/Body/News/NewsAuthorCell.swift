//
//  NewsAuthorCell.swift
//  VKClient
//
//  Created by Lev on 6/7/21.
//

import UIKit

class NewsAuthorCell: UITableViewCell, SelfConfiguringCell {

    static var reuseIdentifier: String = "AuthorCell"
    
    @IBOutlet weak var titleView: TitleView!
    
    func configureCell(object: Any) {
        
        guard type(of: object) == NewsModelForUse.self else { return }
        let news = object as! NewsModelForUse
        
        guard let url = URL(string: news.mainPhoto) else { return }
        loadPhoto(from: url) { [self] image in
            titleView.configureTitleView(
                titleImage: image,
                titleLabel: news.name,
                subtitleLabel: ""
            )
        }
        
    }
    
}
