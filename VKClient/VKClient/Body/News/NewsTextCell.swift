//
//  NewsTextCell.swift
//  VKClient
//
//  Created by Lev on 6/7/21.
//

import UIKit

class NewsTextCell: UITableViewCell, SelfConfiguringCell {

    static var reuseIdentifier: String = "TextCell"
    
    @IBOutlet weak var newsTextLabel: UILabel?
    
    func configureCell(object: Any) {
        
        guard type(of: object) == NewsModel.self else { return }
        let news = object as! News
        
        if news.text != nil {
            newsTextLabel?.text = news.text
        }
    }
    
}
