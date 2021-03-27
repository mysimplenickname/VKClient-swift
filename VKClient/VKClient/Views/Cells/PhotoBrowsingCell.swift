//
//  PhotoBrowsingCell.swift
//  VKClient
//
//  Created by Lev on 3/27/21.
//

import UIKit

class PhotoBrowsingCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "PhotoBrowsingCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var interactionView: InteractionView!
    
}
