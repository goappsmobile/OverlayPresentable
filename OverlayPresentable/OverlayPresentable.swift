//
//  OverlayPresentable.swift
//  OverlayPresentable
//
//  Created by Jan Tyra on 15.03.2017.
//  Copyright © 2017 GoApps. All rights reserved.
//

/// Defines ability to present `OverlayView` in any given `UIView`
public protocol OverlayPresentable {
    var overlayView: OverlayView { get }
}

extension OverlayPresentable {
    
    /// Adds a `OverlayView` as subview of `view`
    /// If `OverlayView` is already a subview of `view` completion block is ignored
    ///
    /// - parameter view:       To what view loader should added.
    /// - parameter animated:   Decides if adding subview should be animated. `true` by default
    /// - parameter completion: Optional completion block called after adding subview finished. `nil` by default.
    public func presentOverlay(in view: UIView, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        present(view, animated: animated, completion: completion)
    }
    
    /// Adds a `OverlayView` as subview of `view` and removes it after given `TimeInterval`
    /// If `OverlayView` is already a subview of `view` presentCompletion block and dismissCompletion are ignored
    ///
    /// - parameter view:              To what view loader should added.
    /// - parameter animated:          Decides if adding subview should be animated. `true` by default
    /// - parameter presentCompletion: Optional completion block called after adding subview finished. `nil` by default.
    /// - parameter dismissCompletion: Optional completion block called after removing subview finished. `nil` by default.
    public func presentOverlay(autodismissAfter dismissDelay: TimeInterval, in view: UIView, animated: Bool = true, presentCompletion: ((Bool) -> Void)? = nil, dismissCompletion: ((Bool) -> Void)? = nil) {
        present(view, animated: animated, completion: presentCompletion)
        
        let delay = overlayView.animationDuration + dismissDelay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.dismissOverlay(animated: animated, completion: dismissCompletion)
        }
    }
    
    /// Removes previously added `OverlayView` from `view`. 
    /// If `OverlayView` doesn't have superview completion block will be called regardless
    ///
    /// - parameter animated:   Decides if removal of subview should be animated. `true` by default
    /// - parameter completion: Optional completion block called after removing subview finished. `nil` by default.
    public func dismissOverlay(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }
    
    // Wrapper method for present
    private func present(_ view: UIView, animated: Bool, completion: ((Bool) -> Void)?) {
        guard !view.subviews.contains(overlayView) else {
            return
        }
        
        animate(view, animations: {
            self.overlayView.overlay(in: view)
        }, animated: animated, completion: completion)
    }
    
    // Wrapper method for dismiss
    private func dismiss(animated: Bool, completion: ((Bool) -> Void)?) {
        guard let view = overlayView.superview else {
            completion?(true)
            return
        }
        
        animate(view, animations: {
            self.overlayView.removeFromSuperview()
        }, animated: animated, completion: completion)
    }
    
    // Wrapper method for animations
    private func animate(_ view: UIView, animations: @escaping (() -> Void), animated: Bool, completion: ((Bool) -> Void)? = nil) {
        let duration = animated ? overlayView.animationDuration : 0
        UIView.transition(with: view, duration: duration, options: overlayView.animationOptions, animations: animations, completion: completion)
    }
}
