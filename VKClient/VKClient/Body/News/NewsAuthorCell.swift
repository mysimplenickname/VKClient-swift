//
//  NewsAuthorCell.swift
//  VKClient
//
//  Created by Lev on 7/8/21.
//

import UIKit

class NewsAuthorCell: UITableViewCell {
    
    static let reuseIdentifier: String = "AuthorCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var authorName: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorImageView.image = nil
        authorName.text = ""
    }
    
    func configureCell(image: UIImage?, name: String?) {
        authorImageView.image = image ?? UIImage(systemName: "person")
        authorName.text = name ?? ""
    }
    
    private func setConstraints() {
        contentView.addSubview(authorImageView)
        contentView.addSubview(authorName)
        
        NSLayoutConstraint.activate([
            authorImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            authorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            authorImageView.heightAnchor.constraint(equalToConstant: 50),
            authorImageView.widthAnchor.constraint(equalToConstant: 50),
            
            authorName.leftAnchor.constraint(equalTo: authorImageView.rightAnchor, constant: 10),
            authorName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            authorName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }
    
}
