//
//  FriendsCell.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

class FriendsCell: UITableViewCell {

    @IBOutlet weak var friendLabel: UILabel!
    @IBOutlet weak var friendImageView: FriendImageView!
    @IBOutlet weak var shadowView:  ShadowView!

    func configureCell(friend: User) {
        
        friendLabel.text = friend.fullname
        
        let friendImages: [Photo] = friend.images
        
        if friendImages.count > 0 {
            friendImageView.image = UIImage(named: friendImages[0].name)
        } else {
            friendImageView.image = UIImage(systemName: "person")
        }
        
    }
    
}
