//
//  NewsCell.swift
//  VKClient
//
//  Created by Lev on 3/21/21.
//

import UIKit

class NewsCell: UITableViewCell {

    static let reusableId: String = "NewsCell"
    
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var watchLabel: UILabel!
    
    private var likes: UInt = 0
    private var isLiked: Bool = false
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if isLiked {
            isLiked = false
            likes -= 1
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            likeLabel.text = String(likes)
        } else {
            isLiked = true
            likes += 1
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeLabel.text = String(likes)
        }
    }
    
}
