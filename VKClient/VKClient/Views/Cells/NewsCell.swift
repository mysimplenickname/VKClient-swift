//
//  NewsCell.swift
//  VKClient
//
//  Created by Lev on 3/21/21.
//

import UIKit

class NewsCell: UITableViewCell, SelfConfiguringCell {

    static var reuseIdentifier: String = "NewsCell"
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var interactionView: InteractionView!
    @IBOutlet weak var watchLabel: UILabel!
    
    func configureCell(friend: User) {
        let friendFullName: String = friend.fullname
        let friendImages: [Photo] = friend.images
        var friendImage: UIImage?
        if friendImages.count > 0 {
            friendImage = UIImage(named: friendImages[0].name)!
        } else {
            friendImage = UIImage(systemName: "person")
        }
    }
    
}
