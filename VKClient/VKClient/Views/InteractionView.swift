//
//  InteractionView.swift
//  VKClient
//
//  Created by Lev on 3/26/21.
//

import UIKit

class InteractionView: UIControl {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("InteractionView", owner: self, options: nil)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    private var likes: Int = 0
    private var isLiked: Bool = false {
        didSet {
            if isLiked {
                likes += 1
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                animateLabel(.systemPink)
            } else {
                likes -= 1
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                animateLabel(.systemBlue)
            }
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        isLiked.toggle()
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
