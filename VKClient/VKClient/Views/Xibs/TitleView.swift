//
//  UserView.swift
//  VKClient
//
//  Created by Lev on 4/11/21.
//

import UIKit

class TitleView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
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
        Bundle.main.loadNibNamed("TitleView", owner: self, options: nil)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func configureTitleView(titleImage: UIImage, titleLabel: String, subtitleLabel: String) {
        self.titleImageView.image = titleImage
        self.titleLabel.text = titleLabel
        self.subtitleLabel.text = subtitleLabel
        
        self.titleImageView.clipsToBounds = true
        self.titleImageView.layer.cornerRadius = self.titleImageView.frame.height / 2
        
        let titleImageViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.animateTitleImageView))
        self.titleImageView.isUserInteractionEnabled = true
        self.titleImageView.addGestureRecognizer(titleImageViewTapGestureRecognizer)
        
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

extension TitleView {
    
    @objc func animateTitleImageView() {
        UIImageView.animate(
            withDuration: 0.15,
            delay: 0,
            options: [],
            animations: {
                let newSize: CGFloat = 0.6
                self.titleImageView.transform = CGAffineTransform(scaleX: newSize, y: newSize)
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
                        self.titleImageView.transform = CGAffineTransform(scaleX: oldSize, y: oldSize)
                        self.shadowView.transform = CGAffineTransform(scaleX: oldSize, y: oldSize)
                    },
                    completion: nil
                )
            }
        )
    }
    
}
