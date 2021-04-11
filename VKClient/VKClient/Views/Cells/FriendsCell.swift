//
//  FriendsCell.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

@IBDesignable class FriendsCell: UITableViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "FriendsCell"
    
    @IBOutlet weak var userView: UserView!

    func configureCell(friend: User) {
        let friendFullName: String = friend.fullname
        let friendImages: [Photo] = friend.images
        var friendImage: UIImage?
        if friendImages.count > 0 {
            friendImage = UIImage(named: friendImages[0].name)!
        } else {
            friendImage = UIImage(systemName: "person")
        }
        userView.configureUserView(userImageView: friendImage!, userFullname: friendFullName)
    }
    
}
