//
//  PhotosCell.swift
//  VKClient
//
//  Created by Lev on 3/3/21.
//

import UIKit

class PhotosCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "photosCell"
    
    @IBOutlet weak var photosImage: UIImageView!
    
    func configureCell(object: Any) {
        return
    }
    
}
