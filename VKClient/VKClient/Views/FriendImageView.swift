//
//  FriendImageView.swift
//  VKClient
//
//  Created by Lev on 3/11/21.
//

import UIKit

@IBDesignable class FriendImageView: UIView {
    
    // MARK: - friend image view
    
    let friendImageView = UIImageView()
    
    @IBInspectable var image: UIImage? {
        didSet {
            friendImageView.image = image
        }
    }
    
    // MARK: - setup
    
    private func setup() {
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        
        addSubview(friendImageView)
        
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            friendImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            friendImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            friendImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        ])
        
    }
    
    // MARK: - inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
}
