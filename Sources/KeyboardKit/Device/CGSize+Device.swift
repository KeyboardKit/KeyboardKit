//
//  CGSize+Device.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-08.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension CGSize {
    
    /// The large iPad portrait threshold size.
    static let iPadLargeScreen = CGSize(width: 1024, height: 1366)

    /// The large iPad landscape threshold size.
    static let iPadLargeScreenLandscape = iPadLargeScreen.flipped()

    /// The large iPhone portrait threshold size.
    static let iPhoneLargeScreen = CGSize(width: 428, height: 926)

    /// The large iPhone landscape threshold size.
    static let iPhoneLargeScreenLandscape = iPhoneLargeScreen.flipped()

    /// Flip the size's height and width.
    func flipped() -> CGSize {
        CGSize(width: height, height: width)
    }

    /// Whether a size is at least a size in any orientation.
    func isAtLeastScreenSize(
        _ size: CGSize
    ) -> Bool {
        isAtLeast(size) || isAtLeast(size.flipped())
    }

    /// Whether the size matches a size in any orientation.
    ///
    /// To handle small variations when new devices come out,
    /// this function automatically adds 50 points tolerance.
    func isScreenSize(
        _ size: CGSize,
        withTolerance points: CGFloat = 50
    ) -> Bool {
        self.isEqual(to: size, withTolerance: points) ||
        self.isEqual(to: size.flipped(), withTolerance: points)
    }
}

extension CGSize {

    func isAtLeast(
        _ size: CGSize
    ) -> Bool {
        width >= size.width || height >= size.height
    }

    func isEqual(
        to size: CGSize,
        withTolerance points: CGFloat
    ) -> Bool {
        width.isEqual(to: size.width, withTolerance: points) &&
        height.isEqual(to: size.height, withTolerance: points)
    }
}

extension CGFloat {

    func isEqual(
        to value: CGFloat,
        withTolerance points: CGFloat
    ) -> Bool {
        self > value - points && self < value + points
    }
}
