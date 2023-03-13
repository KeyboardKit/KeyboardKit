//
//  RepeatGestureTimer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This private class is used to handle repeating actions on a
 keyboard button.
 */
public class RepeatGestureTimer {

    public init() {}
    
    deinit { stop() }


    private var timer: Timer?
    
    private var startDate: Date?

    /**
     The timer tick interval.
     */
    public var timeInterval: TimeInterval = 0.1
}

public extension RepeatGestureTimer {

    /**
     This shared timer can be used if you only need to track
     a single thing.
     */
    static let shared = RepeatGestureTimer()
}

public extension RepeatGestureTimer {

    /**
     The time for how long the timer has been active.
     */
    var duration: TimeInterval? {
        guard let date = startDate else { return nil }
        return Date().timeIntervalSince(date)
    }

    /**
     Whether or not the timer is active.
     */
    var isActive: Bool { timer != nil }

    /**
     Start the timer.
     */
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

    /**
     Stop the timer.
     */
    func stop() {
        timer?.invalidate()
        timer = nil
        startDate = nil
    }
}

extension RepeatGestureTimer {
    
    func modifyStartDate(to date: Date) {
        startDate = date
    }
}
