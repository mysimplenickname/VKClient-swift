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
        
        guard type(of: object) == News.self else { return }
        let news = object as! News
        
        titleView.configureTitleView(
            titleImage: UIImage(systemName: "person")!,
            titleLabel: news.authorLabel,
            subtitleLabel: ""
        )
    }
    
}
