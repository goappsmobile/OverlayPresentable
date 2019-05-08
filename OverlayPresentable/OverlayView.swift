//
//  OverlayView.swift
//  OverlayPresentable
//
//  Created by Jan Tyra on 15.03.2017.
//  Copyright © 2017 GoApps. All rights reserved.
//

/// Base class used by `OverlayPresentable`
/// Defines animation properties such as duration(`TimeInterval`) and options(`UIViewAnimationOptions`)
open class OverlayView: UIView {
    
    /// Duration of adding as overlay animation
    open var animationDuration: TimeInterval = 0.3
    
    /// `UIViewAnimationOptions` of adding as overlay animation
    open var animationOptions: UIView.AnimationOptions = [.beginFromCurrentState, .transitionCrossDissolve]
}

extension OverlayView {
    
    /// Helper function that adds `self` as a subview of a `UIView` that overlays it completly - zero margins form vertical and horizontal edges
    ///
    /// - parameter view:   View that will become superview of `self`
    internal func overlay(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self)
        view.bringSubviewToFront(self)
        
        let leftConstraint = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}
