//
//  NewsInteractionCell.swift
//  VKClient
//
//  Created by Lev on 6/7/21.
//

import UIKit

class NewsInteractionCell: UITableViewCell, SelfConfiguringCell {

    static var reuseIdentifier: String = "InteractionCell"
    
    @IBOutlet weak var interactionView: InteractionView!
    @IBOutlet weak var watchLabel: UILabel!
    
    func configureCell(object: Any) {}
    
}
