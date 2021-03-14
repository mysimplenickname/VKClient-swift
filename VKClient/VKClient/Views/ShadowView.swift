//
//  ShadowView.swift
//  VKClient
//
//  Created by Lev on 3/13/21.
//

import UIKit

@IBDesignable class ShadowView: UIView {

    let shadowView = UIView()
    
    @IBInspectable var shadowColor: UIColor = .systemBlue {
        didSet {
            updateShadowColor()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat  = 6 {
        didSet {
            updateShadowRadius()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.8 {
        didSet {
            updateShadowOpacity()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            updateShadowOffset()
        }
    }
    
    func updateShadowColor() {
        self.layer.shadowColor = shadowColor.cgColor
    }
    
    func updateShadowRadius() {
        self.layer.shadowRadius = shadowRadius
    }
    
    func updateShadowOpacity() {
        self.layer.shadowOpacity = shadowOpacity
    }
    
    func updateShadowOffset() {
        self.layer.shadowOffset = shadowOffset
    }
    
    func setup() {
        
        self.layer.cornerRadius = self.frame.height / 2
        
        updateShadowColor()
        updateShadowRadius()
        updateShadowOpacity()
        updateShadowOffset()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

}
