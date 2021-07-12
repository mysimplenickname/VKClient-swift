//
//  PhotosCell.swift
//  VKClient
//
//  Created by Lev on 3/3/21.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "photosCell"
    
    @IBOutlet weak var photosImage: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        photosImage.image = nil
    }
    
    func configureCell(image: UIImage?) {
        photosImage.image = image ?? UIImage()
    }
    
}
