//
//  NewsInteractionCell.swift
//  VKClient
//
//  Created by Lev on 7/9/21.
//

import UIKit

class NewsInteractionCell: UITableViewCell {

    static let reuseIdentifier = "InteractionCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var interactionView: InteractionView = {
        let interactionView = InteractionView()
        interactionView.translatesAutoresizingMaskIntoConstraints = false
        return interactionView
    }()
    
    private func setConstraints() {
        contentView.addSubview(interactionView)
        
        NSLayoutConstraint.activate([
            interactionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            interactionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            interactionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            interactionView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }

}
