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
        
        guard type(of: object) == NewsModelItem.self else { return }
        let news = object as! NewsModelItem
        
        newsTextLabel?.text = news.text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTextLabel?.text = ""
    }
    
}
