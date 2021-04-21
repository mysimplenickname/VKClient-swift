//
//  GroupsCell.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class GroupsCell: UITableViewCell, SelfConfiguringCell {

    static var reuseIdentifier: String = "GroupsCell"
    
    @IBOutlet weak var titleView: TitleView!

//    func configureCell(object: Any) {
//
//        guard type(of: object) == Group.self else { return }
//        let group = object as! Group
//
//        var groupImage: UIImage
//        if group.image != nil {
//            groupImage = UIImage(named: group.image!.name)!
//        } else {
//            groupImage = UIImage(systemName: "person.3")!
//        }
//
//        titleView.configureTitleView(titleImage: groupImage, titleLabel: group.name, subtitleLabel: "")
//
//    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func configureCell(object: Any) {
        guard type(of: object) == GroupModelItem.self else { return }
        let group = object as! GroupModelItem
        
        let url = URL(string: group.mainPhoto)
        getData(from: url!) { [self] data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                titleView.configureTitleView(titleImage: UIImage(data: data)!, titleLabel: group.name, subtitleLabel: "")
            }
        }
    }
    
}
