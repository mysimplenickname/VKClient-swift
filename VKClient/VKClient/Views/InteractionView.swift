//
//  InteractionView.swift
//  VKClient
//
//  Created by Lev on 3/26/21.
//

import UIKit

protocol ButtonTappedDelegate: class {
    func buttonTapped()
}

class InteractionView: UIView {

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
    
    private var likes: UInt = 0
    private var isLiked: Bool = false
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if isLiked {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            isLiked.toggle()
            likes -= 1
            animateLabel(.systemBlue)
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isLiked.toggle()
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
