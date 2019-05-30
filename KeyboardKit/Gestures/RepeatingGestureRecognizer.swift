//
//  RepeatingGestureRecognizer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This gesture recognizer will trigger a certain action, once
 after an `initialDelay` and repeating every `repeatInterval`
 until the user releases her/his finger. It's a good gesture
 to use for some keyboard actions, like `backspace`.
 
 This gesture does not cancel any other gestures, so you can
 use it together with taps and long presses.
 
 TODO: Unit test this class
 
 */

import UIKit.UIGestureRecognizerSubclass

public class RepeatingGestureRecognizer: UIGestureRecognizer {
    
    
    // MARK: - Initialization
    
    public init(initialDelay: TimeInterval = 0.8, repeatInterval: TimeInterval = 0.1, action: @escaping () -> Void) {
        self.action = action
        self.initialDelay = initialDelay
        self.repeatInterval = repeatInterval
        super.init(target: nil, action: nil)
        self.delegate = self
    }
    
    
    // MARK: - Properties

    private let action: () -> Void
    private let initialDelay: TimeInterval
    private let repeatInterval: TimeInterval
    private var timer: Timer?
    

    // MARK: - State
    
    public override var state: UIGestureRecognizer.State {
        didSet {
            switch state {
            case .began: startTimer()
            case .cancelled, .ended, .failed: stopTimer()
            case .changed, .possible: break
            @unknown default: break
            }
        }
    }
    
    
    // MARK: - Touch handling
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        state = .began
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if state == .failed { return }
        if state == .ended { return }
        state = .changed
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        state = .cancelled
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .ended
    }
}


// MARK: - Private Functions

private extension RepeatingGestureRecognizer {
    
    func delay(seconds: TimeInterval, function: @escaping ()->()) {
        let milliseconds = Int(seconds * 1000)
        delay(interval: .milliseconds(milliseconds), function: function)
    }
    
    func delay(interval: DispatchTimeInterval, function: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: function)
    }
    
    func startTimer() {
        action()
        let repeatInterval = self.repeatInterval
        delay(seconds: initialDelay) { [weak self] in
            self?.timer = Timer.scheduledTimer(withTimeInterval: repeatInterval, repeats: true) { _ in
                self?.action()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}


// MARK: - UIGestureRecognizerDelegate

extension RepeatingGestureRecognizer: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
