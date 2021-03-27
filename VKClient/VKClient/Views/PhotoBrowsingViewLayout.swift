//
//  PhotoBrowsingViewLayout.swift
//  VKClient
//
//  Created by Lev on 3/27/21.
//

import UIKit

class PhotoBrowsingViewLayout: UICollectionViewLayout {

    var cachedAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    
    var totalWidth: CGFloat = 0
    
    override func prepare() {
        cachedAttributes = [:]
        
        guard let collectionView = self.collectionView else { return }
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        guard numberOfItems > 0 else { return }
        
        let size: CGFloat = collectionView.frame.width
        var lastX: CGFloat = 0
        
        for index in 0..<numberOfItems {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: lastX, y: 0, width: size, height: collectionView.frame.height)
            lastX += size
            cachedAttributes[indexPath] = attributes
        }
        
        totalWidth = lastX
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes.values.filter {
            attributes in return rect.intersects(attributes.frame)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: totalWidth,
                      height: collectionView?.frame.height ?? 0)
    }
    
}
