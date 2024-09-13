//
//  Gestures+RepeatTimer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Gestures {
    
    @available(*, deprecated, message: "This is no longer used and will be removed in KeyboardKit 9.0")
    class RepeatTimer {
        
        public init() {}
        
        deinit { stop() }
        
        private var timer: Timer?
        
        private var startDate: Date?
        
        /// The timer tick interval.
        public var timeInterval: TimeInterval = 0.1
    }
}

@available(*, deprecated, message: "This is no longer used")
public extension Gestures.RepeatTimer {

    /// This is a shared timer instance.
    static let shared = Gestures.RepeatTimer()
}

@available(*, deprecated, message: "This is no longer used")
public extension Gestures.RepeatTimer {

    /// The time for how long the timer has been active.
    var duration: TimeInterval? {
        guard let date = startDate else { return nil }
        return Date().timeIntervalSince(date)
    }

    /// Whether or not the timer is active.
    var isActive: Bool { timer != nil }

    /// Start the timer.
    func start(action: @escaping () -> Void) {
        if isActive { return }
        stop()
        startDate = Date()
        let timer = Timer.scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: true) { _ in action() }
        self.timer = timer
        RunLoop.current.add(timer, forMode: .common)
    }

    /// Stop the timer.
    func stop() {
        timer?.invalidate()
        timer = nil
        startDate = nil
    }
}

@available(*, deprecated, message: "This is no longer used")
extension Gestures.RepeatTimer {
    
    func modifyStartDate(to date: Date) {
        startDate = date
    }
}
