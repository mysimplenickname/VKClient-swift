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
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            isLiked = false
            likes -= 1
            animateLabel(.systemBlue)
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isLiked = true
            likes += 1
            animateLabel(.systemPink)
        }
    }
    
    private func animateLabel(_ color: UIColor) {
        let animationDuration: TimeInterval = 0.3
        UILabel.animate(
            withDuration: animationDuration,
            animations: {
                self.likeLabel.layer.opacity = 0
            },
            completion: { _ in
                UILabel.animate(
                    withDuration: animationDuration,
                    animations: {
                        self.likeLabel.text = String(self.likes)
                        self.likeLabel.textColor = color
                        self.likeLabel.layer.opacity = 1
                    },
                    completion: nil
                )
            }
        )
    }
    
}
