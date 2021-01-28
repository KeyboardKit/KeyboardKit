//
//  RepeatGestureTimer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This private class is used to handle repeating actions on a
 keyboard button.
 */
class RepeatGestureTimer {
    
    private var timer: Timer?
    
    deinit { stop() }
    
    func start(action: @escaping () -> Void) {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in action() }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
