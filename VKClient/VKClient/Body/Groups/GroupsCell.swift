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
        guard type(of: object) == GroupModelItem.self else { return }
        let group = object as! GroupModelItem
        
        titleView.configureTitleView(titleImage: group.image ?? UIImage(), titleLabel: group.name, subtitleLabel: "")
    }
    
}
