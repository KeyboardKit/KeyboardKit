//
//  GestureButtonTimer.swift
//  GestureButton
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This internal class can be used to repeat an action when
/// a button is kept pressed.
public class GestureButtonTimer: ObservableObject {

    /// Create a custom gesture button timer.
    ///
    /// - Parameters:
    ///   - interval: The trigger interval, by default `0.1`.
    public init(
        interval: TimeInterval = 0.1
    ) {
        self.interval = interval
    }

    deinit { stop() }

    var interval: TimeInterval

    private var timer: Timer?

    private var startDate: Date?
}

extension GestureButtonTimer {

    /// The elapsed time since the timer was started.
    var duration: TimeInterval? {
        guard let date = startDate else { return nil }
        return Date().timeIntervalSince(date)
    }

    /// Whether the timer is active.
    var isActive: Bool { timer != nil }

    /// Start the repeat gesture timer with a certain action.
    func start(action: @escaping @Sendable () -> Void) {
        if isActive { return }
        stop()
        startDate = Date()
        timer = Timer.scheduledTimer(
            withTimeInterval: interval,
            repeats: true
        ) { _ in action() }
    }

    /// Stop the repeat gesture timer.
    func stop() {
        timer?.invalidate()
        timer = nil
        startDate = nil
    }
}

extension GestureButtonTimer {

    func modifyStartDate(to date: Date) {
        startDate = date
    }
}
