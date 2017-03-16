//
//  OverlayPresentableTests.swift
//  OverlayPresentableTests
//
//  Created by Jan Tyra on 16.03.2017.
//  Copyright © 2017 GoApps. All rights reserved.
//

import XCTest
@testable import OverlayPresentable

class OverlayPresentableTests: XCTestCase {
    
    let viewController: ViewController = ViewController()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewController.dismissOverlay()
    }
    
    func testPresentingTwice() {
        // given
        var testedString = "test1"
        
        // when
        viewController.presentOverlay(animated: true) { _ in
            testedString = "test2"
        }
        
        viewController.presentOverlay(animated: false) { _ in
            testedString = "test3"
        }
        
        // then
        let predicate = NSPredicate(format: "SELF != \"test3\"")
        expectation(for: predicate, evaluatedWith: testedString, handler: nil)
        waitForExpectations(timeout: viewController.overlayView.animationDuration, handler: nil)
    }
    
    func testPresentingInGivenView() {
        // given
        let view = UIView()
        
        // when
        viewController.presentOverlay(in: view)
        
        // then
        let predicate = NSPredicate(format: "SELF.superview == %@", view)
        expectation(for: predicate, evaluatedWith: viewController.overlayView, handler: nil)
        waitForExpectations(timeout: viewController.overlayView.animationDuration, handler: nil)
    }
    
    func testPresenting() {
        // when
        viewController.presentOverlay()
        
        // then
        let predicate = NSPredicate(format: "SELF.superview == %@", viewController.view)
        expectation(for: predicate, evaluatedWith: viewController.overlayView, handler: nil)
        waitForExpectations(timeout: viewController.overlayView.animationDuration, handler: nil)
    }
    
    func testPresentingWithoutAnimations() {
        // when
        viewController.presentOverlay(animated: false)
        
        // then
        XCTAssertEqual(viewController.overlayView.superview, viewController.view)
    }
    
    func testPresentingCompletionHandler() {
        // given
        let exp = expectation(description: "presentCompletionHandlerCalled")
        
        // when
        viewController.presentOverlay(animated: false) { _ in
            exp.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testDismissingFromViewController() {
        // given
        viewController.presentOverlay()
        
        // when
        viewController.dismissOverlay()
        
        // then
        let predicate = NSPredicate(format: "SELF.superview != %@", viewController.view)
        expectation(for: predicate, evaluatedWith: viewController.overlayView, handler: nil)
        waitForExpectations(timeout: viewController.overlayView.animationDuration, handler: nil)
    }
    
    func testDismissingWithoutAnimations() {
        // given
        viewController.presentOverlay(animated: false)
        
        // when
        viewController.dismissOverlay(animated: false)
        
        // then
        XCTAssertNotEqual(viewController.overlayView.superview, viewController.view)
    }
    
    func testDismissingCompletionHandler() {
        // given
        let exp = expectation(description: "dismissCompletionHandlerCalled")
        
        // when
        viewController.presentOverlay(animated: false)
        viewController.dismissOverlay(animated: false) { _ in
            exp.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testAutoDismissing() {
        // given
        let dismissDelay: TimeInterval = 1.0
        
        // when
        viewController.presentOverlay(autodismissAfter: dismissDelay, animated: false)
        
        // then
        XCTAssertEqual(viewController.overlayView.superview, viewController.view)
        
        let predicate = NSPredicate(format: "SELF.superview != %@", viewController.view)
        expectation(for: predicate, evaluatedWith: viewController.overlayView, handler: nil)
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

class ViewController: UIViewController, OverlayPresentable {
    var overlayView: OverlayView = OverlayView()
}
