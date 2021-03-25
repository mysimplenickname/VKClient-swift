//
//  TestViewController.swift
//  VKClient
//
//  Created by Lev on 3/24/21.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var dot1ImageView: UIImageView!
    @IBOutlet weak var dot2ImageView: UIImageView!
    @IBOutlet weak var dot3ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateView(self.dot1ImageView, 0)
        animateView(self.dot2ImageView, 0.5)
        animateView(self.dot3ImageView, 1)
    }
    
    private func animateView(_ dotImageView: UIImageView, _ delay: TimeInterval) {
        dotImageView.alpha = 0.3
        
        UIImageView.animateKeyframes(
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
