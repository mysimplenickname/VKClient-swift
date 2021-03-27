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
    
    var forSingleUse: Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension PhotoBrowsingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoBrowsingCell.reuseIdentifier, for: indexPath) as! PhotoBrowsingCell
        cell.imageView.image = UIImage(named: images[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        self.title = "\(indexPath.row + 1) of \(images.count)"
        
        if !forSingleUse {
            forSingleUse.toggle()
            let indexPath = IndexPath(item: indexOfSelectedImage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [],
            animations: {
                let size: CGFloat = 0.8
                cell.transform = CGAffineTransform(scaleX: size, y: size)
            },
            completion: { _ in
                cell.transform = .identity
            }
        )
    }
    
}
