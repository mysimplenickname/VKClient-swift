//
//  PhotosViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit
import RealmSwift

class PhotosViewController: UICollectionViewController {
    
    var ownerId: Int!
    
    var images: [PhotoModelItem] = []
    
    var imageService: ImageService?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getPhotos(ownerId: ownerId) { rawImages in
            self.images = rawImages
            self.collectionView.reloadData()
        }
        
        imageService = ImageService(container: collectionView)
    }

}

// MARK: - Segues
extension PhotosViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotoBrowsingViewController,
           let indexPaths = self.collectionView.indexPathsForSelectedItems {
            let indexPath = indexPaths[0].row
            controller.images = images
            controller.imagesIndex = indexPath
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPhotoBrowsingSegue", sender: nil)
    }

}

// MARK: - UICollectionViewDataSource
extension PhotosViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
}

// MARK: - UICollectionViewDelegate
extension PhotosViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseIdentifier, for: indexPath) as! PhotosCell
        guard let imageUrl = images[indexPath.row].imageUrl else { return UICollectionViewCell() }
        let image = imageService?.getImage(atIndexPath: indexPath, byUrl: imageUrl)
        cell.configureCell(image: image)
        return cell
    }
}
