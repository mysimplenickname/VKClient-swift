//
//  FriendsCell.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

@IBDesignable class FriendsCell: UITableViewCell {
    
    static var reusableId: String = "FriendsCell"
    
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!

    func configureCell(friend: User) {
        friendLabel.text = friend.fullname
        let friendImages: [Photo] = friend.images
        if friendImages.count > 0 {
            friendImageView.image = UIImage(named: friendImages[0].name)
        } else {
            friendImageView.image = UIImage(systemName: "person")
        }
        
        friendImageView.clipsToBounds = true
        friendImageView.layer.cornerRadius = friendImageView.frame.height / 2
        
        let friendImageViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.animateFriendImageView))
        friendImageView.isUserInteractionEnabled = true
        friendImageView.addGestureRecognizer(friendImageViewTapGestureRecognizer)
        
        shadowView.layer.cornerRadius = shadowView.frame.height / 2
        
        updateShadowColor()
        updateShadowRadius()
        updateShadowOpacity()
        updateShadowOffset()
    }
    
    // MARK: - shadow properties
    
    @IBInspectable var shadowColor: UIColor = .systemBlue {
        didSet {
            updateShadowColor()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat  = 6 {
        didSet {
            updateShadowRadius()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.8 {
        didSet {
            updateShadowOpacity()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            updateShadowOffset()
        }
    }
    
    func updateShadowColor() {
        shadowView.layer.shadowColor = shadowColor.cgColor
    }
    
    func updateShadowRadius() {
        shadowView.layer.shadowRadius = shadowRadius
    }
    
    func updateShadowOpacity() {
        shadowView.layer.shadowOpacity = shadowOpacity
    }
    
    func updateShadowOffset() {
        shadowView.layer.shadowOffset = shadowOffset
    }
    
}

extension FriendsCell {
    
    @objc func animateFriendImageView() {
        UIImageView.animate(
            withDuration: 0.15,
            delay: 0,
            options: [],
            animations: {
                let newSize: CGFloat = 0.6
                self.friendImageView.transform = CGAffineTransform(scaleX: newSize, y: newSize)
                self.shadowView.transform = CGAffineTransform(scaleX: newSize, y: newSize)
            },
            completion: { _ in
                UIImageView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0,
                    options: [],
                    animations: {
                        let oldSize: CGFloat = 1.0
                        self.friendImageView.transform = CGAffineTransform(scaleX: oldSize, y: oldSize)
                        self.shadowView.transform = CGAffineTransform(scaleX: oldSize, y: oldSize)
                    },
                    completion: nil
                )
            }
        )
    }
    
}
