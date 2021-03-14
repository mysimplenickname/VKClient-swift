//
//  LikesControl.swift
//  VKClient
//
//  Created by Lev on 3/13/21.
//

import UIKit

class LikesControl: UIControl {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    
    private var likes: UInt = 0
    private var isLiked: Bool = false
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if isLiked {
            isLiked = false
            likes -= 1
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            likeLabel.text = String(likes)
            likeLabel.textColor = .systemBlue
        } else {
            isLiked = true
            likes += 1
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeLabel.text = String(likes)
            likeLabel.textColor = .systemPink
        }
    }
    
}
