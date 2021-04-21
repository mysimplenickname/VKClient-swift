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
        guard type(of: object) == User.self else { return }
        let friend = object as! User
        
        let friendFullName: String = friend.fullname
        let friendImages: [Photo] = friend.images
        var friendImage: UIImage
        if friendImages.count > 0 {
            friendImage = UIImage(named: friendImages[0].name)!
        } else {
            friendImage = UIImage(systemName: "person")!
        }
        
        titleView.configureTitleView(titleImage: friendImage, titleLabel: friendFullName, subtitleLabel: "")
    }
    
}
