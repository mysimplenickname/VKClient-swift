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
        let friend = object as! UserModelItem
        
        let friendFullName: String = friend.firstName + " " + friend.lastName
        guard let url = URL(string: friend.mainPhoto) else { return }
        VKAPIMainClass.loadPhoto(from: url) { [self] image in
            titleView.configureTitleView(titleImage: image, titleLabel: friendFullName, subtitleLabel: "")
        }
    }
    
}
