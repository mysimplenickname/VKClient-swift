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
    
    func configureCell(object: Any) {
        guard type(of: object) == RealmGroupModelItem.self else { return }
        let group = object as! RealmGroupModelItem
        
        guard let url = URL(string: group.mainPhoto) else { return }
        loadPhoto(from: url) { [self] image in
            titleView.configureTitleView(titleImage: image, titleLabel: group.name, subtitleLabel: "")
        }
    }
    
}
