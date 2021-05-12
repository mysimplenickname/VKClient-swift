//
//  FindGroupsCell.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

class FindGroupsCell: UITableViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "FindGroupsCell"
    
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
