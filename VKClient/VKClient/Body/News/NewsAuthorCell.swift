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
        
        guard type(of: object) == GroupModelItem.self else { return }
        let group = object as! GroupModelItem
        
        titleView.configureTitleView(titleImage: group.image ?? UIImage(), titleLabel: group.name, subtitleLabel: "")
        
    }
    
}
