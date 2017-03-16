//
//  OverlayPresentableExtensions.swift
//  OverlayPresentable
//
//  Created by Jan Tyra on 15.03.2017.
//  Copyright © 2017 GoApps. All rights reserved.
//

extension OverlayPresentable where Self: UIViewController {
    
    /// Helper method for `UIViewController` where `OverlayView` is added as subview of `UIViewController`'s view.
    ///
    /// - parameter animated:   Decides if adding subview should be animated. `true` by default
    /// - parameter completion: Optional completion block called after adding subview finished. `nil` by default.
    public func presentOverlay(animated: Bool = true, with completion: ((Bool) -> Void)? = nil) {
        presentOverlay(in: self.view, animated: animated, completion: completion)
    }
    
    /// Helper method for `UIViewController` where `OverlayView` is added as subview of `UIViewController`'s view and automatically removed after given delay.
    ///
    /// - parameter animated:   Decides if adding subview should be animated. `true` by default
    /// - parameter completion: Optional completion block called after adding subview finished. `nil` by default.
    public func presentOverlay(autodismissAfter dismissDelay: TimeInterval, animated: Bool = true, presentCompletion: ((Bool) -> Void)? = nil, dismissCompletion: ((Bool) -> Void)? = nil) {
        presentOverlay(autodismissAfter: dismissDelay, in: self.view, animated: animated, presentCompletion: presentCompletion, dismissCompletion: dismissCompletion)
    }
}
