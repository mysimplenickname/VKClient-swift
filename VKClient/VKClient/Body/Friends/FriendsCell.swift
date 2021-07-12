//
//  FriendsCell.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

class FriendsCell: UITableViewCell {
    
    @IBOutlet private weak var titleView: TitleView!
    
    static let reuseIdentifier: String = "FriendsCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleView.configureTitleView(titleImage: nil, titleLabel: nil, subtitleLabel: nil)
    }
    
    func configureCell(image: UIImage?, name: String?) {
        titleView.configureTitleView(titleImage: image, titleLabel: name, subtitleLabel: "")
    }
    
}
