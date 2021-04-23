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
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func configureCell(object: Any) {
        guard type(of: object) == GroupModelItem.self else { return }
        let group = object as! GroupModelItem
        
        guard let url = URL(string: group.mainPhoto) else { return }
        VKAPIMainClass.loadPhoto(from: url) { [self] image in
            titleView.configureTitleView(titleImage: image, titleLabel: group.name, subtitleLabel: "")
        }
    }
    
}
