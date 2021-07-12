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
    
    var token: NotificationToken?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getPhotos(ownerId: ownerId) { realmImages in
            self.realmImages = realmImages
            self.collectionView.reloadData()
        }
        
        updatePhotos()
    }
    
    func updatePhotos() {
        
        guard let realm = try? Realm() else { return }
        let results = realm.objects(RealmUserModelItem.self)
        
        token = results.observe { (changes: RealmCollectionChange) in
            guard let tableView = self.collectionView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self.collectionView.performBatchUpdates(
                    {
                        self.collectionView.insertItems(
                            at: insertions.map(
                                {
                                    IndexPath(row: $0, section: 0)
                                }
                            )
                        )
                        self.collectionView.deleteItems(
                            at: deletions.map(
                                {
                                    IndexPath(row: $0, section: 0)
                                }
                            )
                        )
                        self.collectionView.reloadItems(
                            at: modifications.map(
                                {
                                    IndexPath(row: $0, section: 0)
                                }
                            )
                        )
                    },
                    completion: nil
                )
            case .error(let error):
                fatalError("\(error)")
            }
        }
        
    }

}

// MARK: - Segues
extension PhotosViewController {
    
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

}

// MARK: - UICollectionViewDataSource
extension PhotosViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realmImages.count
    }
}

// MARK: - UICollectionViewDelegate
extension PhotosViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseIdentifier, for: indexPath) as! PhotosCell
        guard let url = URL(string: realmImages[indexPath.row].url) else { return cell }
        loadPhoto(from: url) { image in
            cell.photosImage.image = image
        }
        return cell
    }
}
