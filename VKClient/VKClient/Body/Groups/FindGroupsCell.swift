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
        
        guard type(of: object) == GroupModelItem.self else { return }
        let group = object as! GroupModelItem
        
        titleView.configureTitleView(titleImage: group.image ?? UIImage(), titleLabel: group.name, subtitleLabel: "")
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleView.configureTitleView(titleImage: UIImage(), titleLabel: "", subtitleLabel: "")
    }
    
}
