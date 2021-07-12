//
//  NewsTextCell.swift
//  VKClient
//
//  Created by Lev on 7/8/21.
//

import UIKit

class NewsTextCell: UITableViewCell {

    static let reuseIdentifier: String = "TextCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var newsTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTextLabel.text = ""
    }
    
    func configureCell(text: String?) {
        newsTextLabel.text = text ?? ""
    }
    
    private func setConstraints() {
        
        contentView.addSubview(newsTextLabel)
        
        let topConstraint = newsTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2)
        NSLayoutConstraint.activate([
            topConstraint,
            newsTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            newsTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8)
        ])
        
        topConstraint.priority = .init(999)
    }

}
