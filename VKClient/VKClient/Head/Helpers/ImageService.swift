//
//  ImageService.swift
//  VKClient
//
//  Created by Lev on 6/24/21.
//

import Foundation
import UIKit
import Alamofire

class ImageService {
    
    // FileImage is low level cache, this array is high level cache
    private var images = [String: UIImage]()
    
    private let cacheLifeTime: TimeInterval = 60 * 60 * 24 * 30
    private static let path: String = {
        
        let pathName = "images"
        
        // Check if chachesDirectory exists
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        
        // Create an url for cachesDirectory/<pathName>
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        // Create a directory if it doesn't exist
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
        
    }()
    
    private func getFileName(url: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        
        let fileName = url.split(separator: "/").last ?? "default"
        
        return cachesDirectory.appendingPathComponent(ImageService.path + "/" + fileName).path
        
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        
        guard
            let fileName = getFileName(url: url),
            let data = image.pngData()
        else { return }
        
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
        
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        
        // Get attributes of an image and choose modificationDate from it
        guard
            let fileName = getFileName(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        // Check if the time since last modification(time of adding to cache) is less than cacheLifeTime
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName)
        else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        
        return image
        
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    private func loadImage(atIndexPath indexPath: IndexPath, byUrl url: String) {
        
        Alamofire.request(url).responseData(queue: DispatchQueue.global()) { response in
            
            guard
                let data = response.data,
                let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self.images[url] = image
            }
            
            self.saveImageToCache(url: url, image: image)
            
            DispatchQueue.main.async {
                self.container.reloadRow(atIndexPath: indexPath)
            }
            
        }
        
    }
    
    func getImage(atIndexPath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        
        var outputImage: UIImage?
        
        if let image = images[url] {
            outputImage = image
        } else if let image = getImageFromCache(url: url) {
            outputImage = image
        } else {
            loadImage(atIndexPath: indexPath, byUrl: url)
        }
        
        return outputImage
        
    }
    
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexPath indexPath: IndexPath)
}

extension ImageService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
    
}
