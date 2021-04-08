//
//  CustomPushAnimation.swift
//  VKClient
//
//  Created by Lev on 4/2/21.
//

import UIKit

class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        
        destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: source.view.frame.width).concatenating(CGAffineTransform(rotationAngle: -1/2))
        
        UIView.animate(
            withDuration: 0.75,
            delay: 0,
            options: .curveLinear,
            animations: {
                destination.view.transform = .identity
            },
            completion: { finished in
                if finished && !transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            }
        )
        
    }
    
}
