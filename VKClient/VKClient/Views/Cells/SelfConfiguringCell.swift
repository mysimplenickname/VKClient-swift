//
//  SelfConfiguringCell.swift
//  VKClient
//
//  Created by Lev on 3/27/21.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    //func configureCell()
}
