//
//  PhotosViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    var images: [Photo] = []
    var rawImages: [Item] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VKAPIMainClass.getPhotos() { [weak self] rawImages in
            self?.rawImages = rawImages
            self?.collectionView.reloadData()
        }
        print("from photos view controller: ", rawImages)
    }

    // MARK: - Segues
    
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
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images.count
        return rawImages.count
    }

    // MARK: - UICollectionViewDelegate
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseIdentifier, for: indexPath) as! PhotosCell
//        let image = images[indexPath.row]
//        cell.photosImage.image = UIImage(named: image.name)
        let url = URL(string: rawImages[indexPath.row].sizes[3].url)
        getData(from: url!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    cell.photosImage.image = UIImage(data: data)
                }
            }
        return cell
    }
    
}
