//
//  FriendsCell.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

class FriendsCell: UITableViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "FriendsCell"
    
    @IBOutlet weak var titleView: TitleView!
    
    func configureCell(object: Any) {
        guard type(of: object) == UserModelItem.self else { return }
        var friend = object as! UserModelItem
        
        titleView.configureTitleView(titleImage: friend.image ?? UIImage(), titleLabel: friend.fullname, subtitleLabel: "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleView.configureTitleView(titleImage: UIImage(), titleLabel: "", subtitleLabel: "")
    }
    
}
