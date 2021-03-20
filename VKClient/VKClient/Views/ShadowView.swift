//
//  ShadowView.swift
//  VKClient
//
//  Created by Lev on 3/13/21.
//

import UIKit

@IBDesignable class ShadowView: UIView {

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

}
