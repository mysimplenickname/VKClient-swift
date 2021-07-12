//
//  UIImageViewExtension.swift
//  VKClient
//
//  Created by Lev on 7/7/21.
//

import UIKit
import Alamofire

extension UIImageView {
    
    func loadImage(imageUrl: String?) {
        
        guard
            let checkedImageUrl = imageUrl,
            let url = URL(string: checkedImageUrl)
        else { return }
        
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let imageData = cache.cachedResponse(for: request)?.data {
            self.image = UIImage(data: imageData)
        } else {
            Alamofire.request(url).response { response in
                guard let data = response.data else { return }
                
                let cacheResponse = CachedURLResponse(response: response.response ?? HTTPURLResponse(), data: data)
                cache.storeCachedResponse(cacheResponse, for: request)
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
        
    }
    
}
