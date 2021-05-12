//
//  PhotoBrowsingViewController.swift
//  VKClient
//
//  Created by Lev on 3/26/21.
//

import UIKit

class PhotoBrowsingViewController: UIViewController {

    var rawImages: [PhotoModelItem] = []
    var rawImagesIndex: Int!
    
    @IBOutlet weak var centerContainerView: UIView!
    @IBOutlet weak var interactionView: InteractionView!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if rawImagesIndex < 0 && rawImagesIndex > rawImages.count - 1 {
            rawImagesIndex = 0
        }
        
        guard let url = URL(string: rawImages[rawImagesIndex].sizes[3].url) else { return }
//        centerImageView.image = VKAPIMainClass.loadPhoto(from: url)
        VKAPIMainClass.loadPhoto(from: url) { [self] image in
            centerImageView.image = image
        }
        
        centerContainerView.addSubview(centerImageView)
        centerImageView.frame = centerContainerView.bounds
        
        title = String("\(rawImagesIndex! + 1) of \(rawImages.count)")
        
        centerContainerView.addGestureRecognizer(panGestureRecognizer)
    }
    
    private enum Side {
        case left
        case right
    }
    
    private var currentState: Side!
    
    private var runningAnimators: [UIViewPropertyAnimator] = []
    
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
                    rawImagesIndex -= 1
                case .right:
                    rawImagesIndex += 1
                default:
                    break
                }
                
                centerImageView.transform = .identity
                
                guard let url = URL(string: rawImages[rawImagesIndex].sizes[3].url) else { return }
//                centerImageView.image = VKAPIMainClass.loadPhoto(from: url)
                VKAPIMainClass.loadPhoto(from: url) { [self] image in
                    centerImageView.image = image
                }
                
                runningAnimators.remove(at: runningAnimators.firstIndex(of: centerTransitionAnimator)!)
            }
        }
        
        centerTransitionAnimator.startAnimation()
        runningAnimators.append(centerTransitionAnimator)
        
        if canPerformTransition(state: currentState) {
            
            switch currentState {
            case .left:
                guard let url = URL(string: rawImages[rawImagesIndex - 1].sizes[3].url) else { return }
//                nextImageView.image = VKAPIMainClass.loadPhoto(from: url)
                VKAPIMainClass.loadPhoto(from: url) { [self] image in
                    nextImageView.image = image
                }
                centerContainerView.addSubview(nextImageView)
                nextImageView.frame = centerContainerView.bounds.offsetBy(dx: -centerContainerView.frame.width, dy: 0)
            case .right:
                guard let url = URL(string: rawImages[rawImagesIndex + 1].sizes[3].url) else { return }
//                nextImageView.image = VKAPIMainClass.loadPhoto(from: url)
                VKAPIMainClass.loadPhoto(from: url) { [self] image in
                    nextImageView.image = image
                }
                centerContainerView.addSubview(nextImageView)
                nextImageView.frame = centerContainerView.bounds.offsetBy(dx: centerContainerView.frame.width, dy: 0)
            default:
                break
            }
            
            let sideTransitionAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: { [self] in
                switch currentState {
                case .left:
                    title = String("\(rawImagesIndex!) of \(rawImages.count)")
                    nextImageView.transform = CGAffineTransform(translationX: centerContainerView.frame.width, y: 0)
                case .right:
                    title = String("\(rawImagesIndex! + 2) of \(rawImages.count)")
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
    
    private var shouldEnd: Bool = false
    
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
                
                title = String("\(rawImagesIndex! + 1) of \(rawImages.count)")
                
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
            ? rawImagesIndex > 0
            : rawImagesIndex < rawImages.count - 1
    }
    
}
