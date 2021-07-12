//
//  PhotoBrowsingViewController.swift
//  VKClient
//
//  Created by Lev on 3/26/21.
//

import UIKit

class PhotoBrowsingViewController: UIViewController {
    
    @IBOutlet private weak var centerContainerView: UIView!
    @IBOutlet private weak var interactionView: InteractionView!
    
    var images: [PhotoModelItem] = []
    var imagesIndex: Int!
    
    private lazy var centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(imageViewPanned))
        return recognizer
    }()
    
    private enum Side {
        case left
        case right
    }
    
    private var currentState: Side!
    private var runningAnimators: [UIViewPropertyAnimator] = []
    private var shouldEnd: Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if imagesIndex < 0 && imagesIndex > images.count - 1 {
            imagesIndex = 0
        }
        
        centerImageView.loadImage(imageUrl: images[imagesIndex].imageUrl)
        
        centerContainerView.addSubview(centerImageView)
        centerImageView.frame = centerContainerView.bounds
        
        title = String("\(imagesIndex! + 1) of \(images.count)")
        
        centerContainerView.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func animateTransitionIfNeeded(duration: TimeInterval) {
        
        guard runningAnimators.isEmpty else { return }
        
        let centerTransitionAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: { [self] in
            switch currentState {
            case .left:
                centerImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: centerContainerView.frame.width, y: 0))
            case .right:
                centerImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: -centerContainerView.frame.width, y: 0))
            default:
                break
            }
        })
        
        if canPerformTransition(state: currentState) {
            centerTransitionAnimator.addCompletion { [self] (position) in
                
                guard position == .end else { return }
            
                switch currentState {
                case .left:
                    imagesIndex -= 1
                case .right:
                    imagesIndex += 1
                default:
                    break
                }
                
                centerImageView.transform = .identity
                
                centerImageView.loadImage(imageUrl: images[imagesIndex].imageUrl)
                
                runningAnimators.remove(at: runningAnimators.firstIndex(of: centerTransitionAnimator)!)
            }
        }
        
        centerTransitionAnimator.startAnimation()
        runningAnimators.append(centerTransitionAnimator)
        
        if canPerformTransition(state: currentState) {
            
            switch currentState {
            case .left:
                
                nextImageView.loadImage(imageUrl: images[imagesIndex - 1].imageUrl)
                
                centerContainerView.addSubview(nextImageView)
                nextImageView.frame = centerContainerView.bounds.offsetBy(dx: -centerContainerView.frame.width, dy: 0)
            case .right:
                
                nextImageView.loadImage(imageUrl: images[imagesIndex + 1].imageUrl)
                
                centerContainerView.addSubview(nextImageView)
                nextImageView.frame = centerContainerView.bounds.offsetBy(dx: centerContainerView.frame.width, dy: 0)
            default:
                break
            }
            
            let sideTransitionAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: { [self] in
                switch currentState {
                case .left:
                    title = String("\(imagesIndex!) of \(images.count)")
                    nextImageView.transform = CGAffineTransform(translationX: centerContainerView.frame.width, y: 0)
                case .right:
                    title = String("\(imagesIndex! + 2) of \(images.count)")
                    nextImageView.transform = CGAffineTransform(translationX: -centerContainerView.frame.width, y: 0)
                default:
                    break
                }
            })
            
            sideTransitionAnimator.addCompletion { [self] (position) in
                
                guard position == .end else { return }
                
                nextImageView.transform = .identity
                nextImageView.removeFromSuperview()
                
                runningAnimators.remove(at: runningAnimators.firstIndex(of: sideTransitionAnimator)!)
            }
            
            sideTransitionAnimator.startAnimation(afterDelay: 0.2)
            runningAnimators.append(sideTransitionAnimator)
        }
    }
    
    @objc private func imageViewPanned(_ recognizer: UIPanGestureRecognizer) {
        
        var fraction = recognizer.translation(in: centerContainerView).x / centerContainerView.frame.width
        currentState = fraction > 0 ? .left : .right
        
        switch recognizer.state {
        case .began:
            animateTransitionIfNeeded(duration: 1)
            runningAnimators.forEach {
                $0.pauseAnimation()
            }
            
        case .changed:
            fraction = recognizer.translation(in: centerContainerView).x / centerContainerView.frame.width
            runningAnimators.forEach {
                $0.fractionComplete = abs(fraction)
            }
            shouldEnd = abs(fraction) > 0.5
            
        case .ended:
            if canPerformTransition(state: currentState) && shouldEnd {
                runningAnimators.forEach {
                    $0.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                }
            } else {
                runningAnimators.forEach {
                    $0.stopAnimation(true)
                    $0.finishAnimation(at: .current)
                }
                runningAnimators.removeAll()
                
                title = String("\(imagesIndex! + 1) of \(images.count)")
                
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: [.curveEaseOut],
                    animations: { [self] in
                        centerImageView.transform = .identity
                        if canPerformTransition(state: currentState) {
                            nextImageView.transform = .identity
                        }
                    },
                    completion: { [self] _ in
                        if canPerformTransition(state: currentState) {
                            nextImageView.removeFromSuperview()
                        }
                    }
                )
            }
            
        default:
            break
        }
    }
    
    private func canPerformTransition(state: Side) -> Bool {
        return state == .left
            ? imagesIndex > 0
            : imagesIndex < images.count - 1
    }
    
}
