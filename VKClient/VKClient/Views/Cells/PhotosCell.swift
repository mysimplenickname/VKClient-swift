//
//  PhotosCell.swift
//  VKClient
//
//  Created by Lev on 3/3/21.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var photosImage: UIImageView!
    
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
