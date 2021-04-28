//
//  PhotosViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    var ownerId: Int!
    
    var rawImages: [PhotoModelItem] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotos(ownerId: ownerId) { [weak self] rawImages in
            self?.rawImages = rawImages
            self?.collectionView.reloadData()
        }
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotoBrowsingViewController,
           let indexPaths = self.collectionView.indexPathsForSelectedItems {
            let indexPath = indexPaths[0].row
            controller.rawImages = rawImages
            controller.rawImagesIndex = indexPath
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPhotoBrowsingSegue", sender: nil)
    }
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rawImages.count
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseIdentifier, for: indexPath) as! PhotosCell
        guard let url = URL(string: rawImages[indexPath.row].sizes[3].url) else { return cell }
        loadPhoto(from: url) { image in
            cell.photosImage.image = image
        }
        return cell
    }
    
}
