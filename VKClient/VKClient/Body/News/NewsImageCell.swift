//
//  NewsImageCell.swift
//  VKClient
//
//  Created by Lev on 7/9/21.
//

import UIKit

class NewsImageCell: UITableViewCell {

    static let reuseIdentifier: String = "ImageCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
    }
    
    func configureCell(image: UIImage?) {
        newsImageView.image = image ?? nil
    }
    
    private func setConstraints() {
        
        contentView.addSubview(newsImageView)
        
        let topConstraint = newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        NSLayoutConstraint.activate([
            topConstraint,
            newsImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
        
        topConstraint.priority = .init(999)
    }


}
