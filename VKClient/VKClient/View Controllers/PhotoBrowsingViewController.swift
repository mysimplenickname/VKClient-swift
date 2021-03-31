//
//  PhotoBrowsingViewController.swift
//  VKClient
//
//  Created by Lev on 3/26/21.
//

import UIKit

class PhotoBrowsingViewController: UIViewController {

    var images: [Photo] = []
    var imagesIndex: Int!
    
    @IBOutlet weak var centerContainerView: UIView!
    @IBOutlet weak var interactionView: InteractionView!
    
    private lazy var centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: images[imagesIndex].name)
        return imageView
    }()
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private func layout() {
        centerImageView.removeFromSuperview()
        leftImageView.removeFromSuperview()
        rightImageView.removeFromSuperview()
        
        centerImageView.translatesAutoresizingMaskIntoConstraints = false
        centerContainerView.addSubview(centerImageView)
        NSLayoutConstraint.activate([
            centerImageView.topAnchor.constraint(equalTo: centerContainerView.topAnchor),
            centerImageView.bottomAnchor.constraint(equalTo: centerContainerView.bottomAnchor),
            centerImageView.leftAnchor.constraint(equalTo: centerContainerView.leftAnchor),
            centerImageView.rightAnchor.constraint(equalTo: centerContainerView.rightAnchor)
        ])
        
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        centerContainerView.addSubview(leftImageView)
        NSLayoutConstraint.activate([
            leftImageView.topAnchor.constraint(equalTo: centerContainerView.topAnchor),
            leftImageView.bottomAnchor.constraint(equalTo: centerContainerView.bottomAnchor),
            leftImageView.leftAnchor.constraint(equalTo: centerContainerView.leftAnchor, constant: -centerContainerView.frame.width),
            leftImageView.rightAnchor.constraint(equalTo: centerContainerView.leftAnchor)
        ])
        
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        centerContainerView.addSubview(rightImageView)
        NSLayoutConstraint.activate([
            rightImageView.topAnchor.constraint(equalTo: centerContainerView.topAnchor),
            rightImageView.bottomAnchor.constraint(equalTo: centerContainerView.bottomAnchor),
            rightImageView.leftAnchor.constraint(equalTo: centerContainerView.rightAnchor),
            rightImageView.rightAnchor.constraint(equalTo: centerContainerView.rightAnchor, constant: centerContainerView.frame.width)
        ])
    }
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(imageViewPanned))
        return recognizer
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        layout()
        
        centerContainerView.addGestureRecognizer(panGestureRecognizer)
    }
    
    private enum Side {
        case left
        case right
        case none
    }
    
    private var currentState: Side = .none
    
    private var runningAnimators: [UIViewPropertyAnimator] = []
    
    private func animateTransitionIfNeeded(to side: Side, duration: TimeInterval) {
        
        guard runningAnimators.isEmpty else { return }
        
        let centerTransitionAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: { [self] in
            
            switch side {
            
            case .left: // 1 -> 2
                centerImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: centerContainerView.frame.width, y: 0))
                
            case .right: // 2 <- 1
                centerImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: -centerContainerView.frame.width, y: 0))
            
            default:
                break
                
            }
            
            self.centerContainerView.layoutIfNeeded()
        })
        
        let sideTransitionAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: { [self] in
            
            switch side {
            
            case .left: // 1 -> 2
                imagesIndex -= 1
                leftImageView.image = UIImage(named: images[imagesIndex].name)
                centerContainerView.bringSubviewToFront(leftImageView)
                leftImageView.transform = CGAffineTransform(translationX: centerContainerView.frame.width, y: 0)
                
            case .right: // 2 <- 1
                imagesIndex += 1
                rightImageView.image = UIImage(named: images[imagesIndex].name)
                centerContainerView.bringSubviewToFront(rightImageView)
                rightImageView.transform = CGAffineTransform(translationX: -centerContainerView.frame.width, y: 0)
            
            default:
                break
                
            }
            
            self.centerContainerView.layoutIfNeeded()
        })
        
        centerTransitionAnimator.startAnimation()
        sideTransitionAnimator.startAnimation()

        runningAnimators.append(centerTransitionAnimator)
        runningAnimators.append(sideTransitionAnimator)
        
    }
    
    private var shouldEnd: Bool = false
    
    @objc private func imageViewPanned(recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        
        case .began:
            
            animateTransitionIfNeeded(to: currentState, duration: 1)
            
            runningAnimators.forEach {
                $0.pauseAnimation()
            }
        
        case .changed:
            let translation = recognizer.translation(in: centerContainerView)
            let fraction = translation.x / centerContainerView.frame.width
            
            currentState = fraction > 0 ? (imagesIndex > 0 ? .left : .none) : (imagesIndex < images.count - 1 ? .right : .none)
            
            print(fraction, currentState, imagesIndex)
            
            runningAnimators.forEach {
                $0.fractionComplete = fraction
            }
            
            shouldEnd = abs(fraction) > 0.3
            
        case .ended:
            print(currentState, shouldEnd)
            if currentState != .none && shouldEnd {
                runningAnimators.forEach {
                    $0.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                }
                //layout()
                //centerContainerView.layoutIfNeeded()
                break
            }
            
            runningAnimators.forEach {
                $0.stopAnimation(true)
                $0.finishAnimation(at: .current)
            }
            runningAnimators.removeAll()
            
            UIView.animate(
                withDuration: 1,
                delay: 0,
                options: [.curveEaseOut],
                animations: {
                    self.centerImageView.transform = .identity
                    self.leftImageView.transform = .identity
                    self.rightImageView.transform = .identity
                },
                completion: nil
            )
            
        default:
            break
            
        }
    }
    
}
