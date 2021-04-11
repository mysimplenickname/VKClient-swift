//
//  SelfConfiguringCell.swift
//  VKClient
//
//  Created by Lev on 3/27/21.
//

import UIKit

protocol SelfConfiguringCell: class {
    static var reuseIdentifier: String { get }
    func configureCell(object: Any)
}
