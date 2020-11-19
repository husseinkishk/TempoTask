//
//  NewsAnimationTransition.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import UIKit

// MARK: - UIViewControllerAnimatedTransitioning

class NewsAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.5
    var presenting = true
    var originFrame = CGRect.zero

    var dismissCompletion: (() -> Void)?

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        let toController = transitionContext.viewController(forKey: .to)

        let newsDetailsController = presenting ?
            transitionContext.viewController(forKey: .to) as? NewsDetailsViewController :
            transitionContext.viewController(forKey: .from) as? NewsDetailsViewController

        guard let newsDetailsView = newsDetailsController?.articleImageView,
              let toView = toController?.view else { return }

        let initialFrame = presenting ? originFrame : newsDetailsView.frame
        let finalFrame = presenting ? newsDetailsView.frame : originFrame

        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width

        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height

        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)

        if presenting {
            newsDetailsView.transform = scaleTransform
            newsDetailsView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            containerView.addSubview(toView)
            containerView.bringSubviewToFront(newsDetailsView)
        } else {
            toView.alpha = 0
            containerView.addSubview(toView)
            UIView.animate(withDuration: 0.4) {
                toView.alpha = 1
            }
        }

        UIView.animate(
            withDuration: duration,
            delay:0.0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            animations: {
                newsDetailsView.transform = self.presenting ? .identity : scaleTransform
                newsDetailsView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            }, completion: { (_) in
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
            })
    }
}
