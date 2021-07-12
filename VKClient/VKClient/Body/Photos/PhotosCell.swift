//
//  PhotosCell.swift
//  VKClient
//
//  Created by Lev on 3/3/21.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    @IBOutlet private weak var photosImage: UIImageView!
    
    static let reuseIdentifier: String = "photosCell"

    override func prepareForReuse() {
        super.prepareForReuse()
        photosImage.image = nil
    }
    
    func configureCell(imageUrl: String?) {
        photosImage.loadImage(imageUrl: imageUrl)
    }
    
}
