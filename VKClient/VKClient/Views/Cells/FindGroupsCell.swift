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
