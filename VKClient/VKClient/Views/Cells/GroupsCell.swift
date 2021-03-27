//
//  GroupsCell.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class GroupsCell: UITableViewCell, SelfConfiguringCell {

    static var reuseIdentifier: String = "groupsCell"
    
    @IBOutlet weak var groupsImage: UIImageView!
    @IBOutlet weak var groupsLabel: UILabel!

}
