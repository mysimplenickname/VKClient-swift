//
//  UserView.swift
//  VKClient
//
//  Created by Lev on 4/11/21.
//

import UIKit

class UserView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("UserView", owner: self, options: nil)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func configureUserView(userImage: UIImage, userFullname: String) {
        self.userImageView.image = userImage
        self.userLabel.text = userFullname
        
        self.userImageView.clipsToBounds = true
        self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
        
        let userImageViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.animateUserImageView))
        self.userImageView.isUserInteractionEnabled = true
        self.userImageView.addGestureRecognizer(userImageViewTapGestureRecognizer)
        
        shadowView.layer.cornerRadius = shadowView.frame.height / 2
        
        updateShadowColor()
        updateShadowRadius()
        updateShadowOpacity()
        updateShadowOffset()
    }
    
    // MARK: - shadow properties
    
    var shadowColor: UIColor = .systemBlue {
        didSet {
            updateShadowColor()
        }
    }
    
    var shadowRadius: CGFloat  = 6 {
        didSet {
            updateShadowRadius()
        }
    }
    
    var shadowOpacity: Float = 0.8 {
        didSet {
            updateShadowOpacity()
        }
    }
    
    var shadowOffset: CGSize = .zero {
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

// MARK: - Animation

extension UserView {
    
    @objc func animateUserImageView() {
        UIImageView.animate(
            withDuration: 0.15,
            delay: 0,
            options: [],
            animations: {
                let newSize: CGFloat = 0.6
                self.userImageView.transform = CGAffineTransform(scaleX: newSize, y: newSize)
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
                        self.userImageView.transform = CGAffineTransform(scaleX: oldSize, y: oldSize)
                        self.shadowView.transform = CGAffineTransform(scaleX: oldSize, y: oldSize)
                    },
                    completion: nil
                )
            }
        )
    }
    
}
