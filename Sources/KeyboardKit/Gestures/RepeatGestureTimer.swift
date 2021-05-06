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
public class RepeatGestureTimer {
    
    deinit { stop() }
    
    
    public static let shared = RepeatGestureTimer()
    
    
    private var timer: Timer?
    
    private var startDate: Date?
}

public extension RepeatGestureTimer {
    
    var duration: TimeInterval? {
        guard let date = startDate else { return nil }
        return Date().timeIntervalSince(date)
    }
    
    var isActive: Bool { timer != nil }
    
    var timeInterval: TimeInterval { 0.1 }
    
    func start(action: @escaping () -> Void) {
        stop()
        startDate = Date()
        timer = Timer.scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: true) { _ in action() }
    }
    
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
