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
    
    var realmImages: [RealmPhotoModelItem] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let realm = try Realm()
            print(realm.objects(RealmPhotoModelItem.self))
            let results = realm.objects(RealmPhotoModelItem.self)
            realmImages = Array(results)
        } catch {
            print(error)
        }
        
        if realmImages.count == 0 {
            getPhotos(ownerId: ownerId) { [weak self] realmImages in
                self?.realmImages = realmImages
                self?.collectionView.reloadData()
            }
        }
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotoBrowsingViewController,
           let indexPaths = self.collectionView.indexPathsForSelectedItems {
            let indexPath = indexPaths[0].row
            controller.realmImages = realmImages
            controller.realmImagesIndex = indexPath
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPhotoBrowsingSegue", sender: nil)
    }
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realmImages.count
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseIdentifier, for: indexPath) as! PhotosCell
        guard let url = URL(string: realmImages[indexPath.row].url) else { return cell }
        loadPhoto(from: url) { image in
            cell.photosImage.image = image
        }
        return cell
    }
    
}
