//
//  AnimatedDotsView.swift
//  VKClient
//
//  Created by Lev on 4/11/21.
//

import UIKit

class AnimatedDotsView: UIView {

    @IBOutlet weak var dot1ImageView: UIImageView!
    @IBOutlet weak var dot2ImageView: UIImageView!
    @IBOutlet weak var dot3ImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        animateView(self.dot1ImageView, 0)
        animateView(self.dot2ImageView, 0.5)
        animateView(self.dot3ImageView, 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        animateView(self.dot1ImageView, 0)
        animateView(self.dot2ImageView, 0.5)
        animateView(self.dot3ImageView, 1)
    }
    
    private func animateView(_ dotImageView: UIImageView, _ delay: TimeInterval) {
        dotImageView.alpha = 0.3
        
        UIImageView.animate(
            withDuration: 1,
            delay: delay,
            options: [.repeat, .autoreverse],
            animations: {
                dotImageView.alpha = 1
            },
            completion: nil
        )
    }

}
