//
//  GroupsCell.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class GroupsCell: UITableViewCell {

    @IBOutlet private weak var titleView: TitleView!
    
    static let reuseIdentifier: String = "GroupsCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleView.configureTitleView(titleImage: nil, titleLabel: nil, subtitleLabel: nil)
    }
    
    func configureCell(image: UIImage?, name: String?) {
        titleView.configureTitleView(titleImage: image, titleLabel: name, subtitleLabel: "")
    }
    
}
