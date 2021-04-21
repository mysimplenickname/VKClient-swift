//
//  NewsCell.swift
//  VKClient
//
//  Created by Lev on 3/21/21.
//

import UIKit

class NewsCell: UITableViewCell, SelfConfiguringCell {

    static var reuseIdentifier: String = "NewsCell"
    
    @IBOutlet weak var titleView: TitleView!
    @IBOutlet weak var newsTextLabel: UILabel?
    @IBOutlet weak var newsImageView: UIImageView?
    @IBOutlet weak var interactionView: InteractionView!
    @IBOutlet weak var watchLabel: UILabel!
    
    func configureCell(object: Any) {
        
        guard type(of: object) == News.self else { return }
        let news = object as! News
        
        titleView.configureTitleView(titleImage: UIImage(named: news.authorImage.name)!, titleLabel: news.authorLabel, subtitleLabel: "")
        
        if news.text != nil {
            newsTextLabel?.text = news.text
        }
        
        if news.image != nil {
            newsImageView?.image = UIImage(named: news.image!.name)
        }
    }
    
}
