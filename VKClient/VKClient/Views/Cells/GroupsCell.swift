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
        
        guard type(of: object) == Group.self else { return }
        let group = object as! Group
        
        var groupImage: UIImage
        if group.image != nil {
            groupImage = UIImage(named: group.image!.name)!
        } else {
            groupImage = UIImage(systemName: "person.3")!
        }
        
        titleView.configureTitleView(titleImage: groupImage, titleLabel: group.name, subtitleLabel: "")
        
    }
    
}
