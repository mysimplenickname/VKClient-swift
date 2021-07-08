//
//  FriendsCell.swift
//  VKClient
//
//  Created by Lev on 3/2/21.
//

import UIKit

class FriendsCell: UITableViewCell {
    
    static let reuseIdentifier: String = "FriendsCell"
    
    @IBOutlet weak var titleView: TitleView!
    
    func configureCell(image: UIImage?, name: String?) {
        titleView.configureTitleView(titleImage: image, titleLabel: name, subtitleLabel: "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleView.configureTitleView(titleImage: nil, titleLabel: nil, subtitleLabel: nil)
    }
    
}
