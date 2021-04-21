//
//  FriendsCell.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

class FriendsCell: UITableViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "FriendsCell"
    
    @IBOutlet weak var titleView: TitleView!

//    func configureCell(object: Any) {
//        guard type(of: object) == User.self else { return }
//        let friend = object as! User
//
//        let friendFullName: String = friend.fullname
//        let friendImages: [Photo] = friend.images
//        var friendImage: UIImage
//        if friendImages.count > 0 {
//            friendImage = UIImage(named: friendImages[0].name)!
//        } else {
//            friendImage = UIImage(systemName: "person")!
//        }
//
//        titleView.configureTitleView(titleImage: friendImage, titleLabel: friendFullName, subtitleLabel: "")
//    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func configureCell(object: Any) {
        guard type(of: object) == UserModelItem.self else { return }
        let friend = object as! UserModelItem
        
        let friendFullName: String = friend.firstName + " " + friend.lastName
//        let friendImages: [Photo] = friend.images
        let url = URL(string: friend.mainPhoto)
        getData(from: url!) { [self] data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                titleView.configureTitleView(titleImage: UIImage(data: data)!, titleLabel: friendFullName, subtitleLabel: "")
            }
        }
    }
    
}
