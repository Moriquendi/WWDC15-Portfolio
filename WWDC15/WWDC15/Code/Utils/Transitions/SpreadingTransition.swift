//
//  SpreadingTransition.swift
//  WWDC15
//
//  Created by Michal Smialko on 18/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class SpreadingTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let referenceView: UIView
    let finalFrame: CGRect
    let dismissing: Bool
    
    let PRESENT_ANIMATION_DURATION: NSTimeInterval = 0.75
    let DISMISS_ANIMATION_DURATION: NSTimeInterval = 0.65
    let PRESENTED_VIEW_START_SCALE: CGFloat = 1.35
    let SHRINKING_VIEW_END_SCALE: CGFloat = 0.7
    let SPRING_DAMPING: CGFloat = 0.65
    let CORNER_RADIUS: CGFloat = 7.0
    
    var backgroundView: UIView
    let BACKGROUND_VIEW_TAG = 10
    var clippingView: UIView
    let CLIPPING_VIEW_TAG = 11

    init(referenceView: UIView, dismissing: Bool) {
        self.dismissing = dismissing
        self.referenceView = referenceView
        
        self.backgroundView = UIView()
        self.backgroundView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        self.backgroundView.tag = BACKGROUND_VIEW_TAG
        
        self.clippingView = UIView()
        self.clippingView.clipsToBounds = true
        self.clippingView.backgroundColor = UIColor.clearColor()
        self.clippingView.layer.cornerRadius = CORNER_RADIUS
        self.clippingView.autoresizesSubviews = false
        self.clippingView.tag = CLIPPING_VIEW_TAG
        
        var rectInWindow = self.referenceView.convertRect(self.referenceView.bounds, toView: nil)
        if (!dismissing) {
            rectInWindow.origin.x -= 70
            rectInWindow.origin.y -= 70
            rectInWindow.size.width += 140
            rectInWindow.size.height += 140
        }
        self.finalFrame = rectInWindow
        
        super.init()
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
 
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        if (self.dismissing) {
            return DISMISS_ANIMATION_DURATION
        }
        else {
            return PRESENT_ANIMATION_DURATION
        }
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if (self.dismissing) {
            self.animateDismissTransition(transitionContext)
        }
        else {
            self.animatePresentTransition(transitionContext)
        }
    }

    // MARK: SpreadingTransition

    func setupDismissTransition(context: UIViewControllerContextTransitioning) {
        
        let toViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let containerView = context.containerView()
        let window = UIApplication.sharedApplication().keyWindow!
        
        self.backgroundView = containerView.viewWithTag(BACKGROUND_VIEW_TAG)!
        self.clippingView = containerView.viewWithTag(CLIPPING_VIEW_TAG)!
        
        self.referenceView.transform = CGAffineTransformMakeScale(
            self.SHRINKING_VIEW_END_SCALE,
            self.SHRINKING_VIEW_END_SCALE)
        self.referenceView.alpha = 0
    }
    
    func setupPresentTransitionViewHierarchy(context: UIViewControllerContextTransitioning) {
  
        let toViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let containerView = context.containerView()
        let window = UIApplication.sharedApplication().keyWindow!
        
        toViewController.view.layer.cornerRadius = CORNER_RADIUS
        toViewController.view.clipsToBounds = true
        
        containerView.addSubview(self.backgroundView)
        self.backgroundView.frame = containerView.bounds
        self.backgroundView.alpha = 0
        
        // Clipping view
        containerView.addSubview(self.clippingView)
        self.clippingView.addSubview(toViewController.view)
        
        // Update frames to start position
        self.clippingView.frame = self.referenceView.convertRect(self.referenceView.bounds,
            toView: self.clippingView.superview)
        
        toViewController.view.frame = window.convertRect(self.finalFrame, toView:toViewController.view.superview)
        toViewController.view.alpha = 0;
        toViewController.view.transform =
            CGAffineTransformScale(CGAffineTransformIdentity,
                PRESENTED_VIEW_START_SCALE,
                PRESENTED_VIEW_START_SCALE)
    }
    
    func animatePresentTransition(context: UIViewControllerContextTransitioning) {
        self.setupPresentTransitionViewHierarchy(context)
        
        let toViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let containerView = context.containerView()
        let window = UIApplication.sharedApplication().keyWindow!
        
        UIView.animateWithDuration(self.transitionDuration(context),
            delay: 0,
            usingSpringWithDamping: SPRING_DAMPING, initialSpringVelocity: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                // Background
                self.backgroundView.alpha = 1
                
                // Clipping view
                self.clippingView.frame = window.convertRect(self.finalFrame,
                    toView:self.clippingView.superview)
                
                // Shrink and fade out the view which we're animating from
                self.referenceView.transform = CGAffineTransformMakeScale(
                    self.SHRINKING_VIEW_END_SCALE,
                    self.SHRINKING_VIEW_END_SCALE)
                self.referenceView.alpha = 0
                
                // Fade in toVC
                toViewController.view.alpha = 1
                toViewController.view.transform = CGAffineTransformIdentity;
                toViewController.view.frame = self.clippingView.bounds
        }) { (finished) -> Void in
            self.referenceView.transform = CGAffineTransformIdentity
            context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
    func animateDismissTransition(context:UIViewControllerContextTransitioning) {
        
        self.setupDismissTransition(context)
        
        let toViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let containerView = context.containerView()
        let window = UIApplication.sharedApplication().keyWindow!
        
        let oldFromRect = fromViewController.view .convertRect(fromViewController.view.frame, toView: nil)
        UIView.animateWithDuration(self.transitionDuration(context),
            delay: 0,
            usingSpringWithDamping: SPRING_DAMPING,
            initialSpringVelocity: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                // Background
                self.backgroundView.alpha = 0
                
                // Clipping view
                self.clippingView.frame = window.convertRect(self.finalFrame,
                    toView:self.clippingView.superview)
                
                // Shrink and fade out the view which we're animating from
                self.referenceView.transform = CGAffineTransformIdentity
                self.referenceView.alpha = 1
                
                // Fade out toVC
                fromViewController.view.frame = fromViewController.view.superview!.convertRect(oldFromRect, fromView: nil)
                fromViewController.view.alpha = 0
                fromViewController.view.transform =
                    CGAffineTransformScale(CGAffineTransformIdentity,
                        self.PRESENTED_VIEW_START_SCALE,
                        self.PRESENTED_VIEW_START_SCALE)
            }) { (finished) -> Void in
                
                self.backgroundView.removeFromSuperview()
                self.clippingView.removeFromSuperview()
                
                context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
}
