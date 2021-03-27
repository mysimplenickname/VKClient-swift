//
//  PhotoBrowsingViewController.swift
//  VKClient
//
//  Created by Lev on 3/26/21.
//

import UIKit


class PhotoBrowsingViewController: UIViewController {

    var images: [Photo] = []
    var indexOfSelectedImage: Int!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var interactionView: InteractionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        imageView.image = UIImage(named: images[indexOfSelectedImage].name)
    }

}

extension PhotoBrowsingViewController: ButtonTappedDelegate {
    func buttonTapped() {
        // todo
    }
}
