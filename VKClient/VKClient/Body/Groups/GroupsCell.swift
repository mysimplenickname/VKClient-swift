//
//  GroupsCell.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class GroupsCell: UITableViewCell {

    static let reuseIdentifier: String = "GroupsCell"
    
    @IBOutlet weak var titleView: TitleView!
    
    func configureCell(image: UIImage?, name: String?) {
        titleView.configureTitleView(titleImage: image, titleLabel: name, subtitleLabel: "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleView.configureTitleView(titleImage: nil, titleLabel: nil, subtitleLabel: nil)
    }
    
}
