//
//  PhotosViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    var images: [Photo] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotoBrowsingViewController,
           let indexPaths = self.collectionView.indexPathsForSelectedItems {
            let indexPath = indexPaths[0].row
            controller.images = images
            controller.indexOfSelectedImage = indexPath
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPhotoBrowsingSegue", sender: nil)
    }
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseIdentifier, for: indexPath) as! PhotosCell
        let image = images[indexPath.row]
        cell.photosImage.image = UIImage(named: image.name)
        return cell
    }
    
}
