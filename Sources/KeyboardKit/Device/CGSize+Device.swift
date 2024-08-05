//
//  CGSize+Device.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-08.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension CGSize {
    
    /// The (classic) large iPad Pro portrait screen size.
    static let iPadProLargeScreenPortrait = CGSize(width: 1024, height: 1366)

    /// The (classic) large iPad Pro landscape screen size.
    static let iPadProLargeScreenLandscape = iPadProLargeScreenPortrait.flipped()

    /// The (classic) small iPad Pro portrait screen size.
    static let iPadProSmallScreenPortrait = CGSize(width: 834, height: 1194)

    /// The (classic) small iPad Pro landscape screen size.
    static let iPadProSmallScreenLandscape = iPadProSmallScreenPortrait.flipped()

    /// The regular iPad portrait screen size.
    static let iPadScreenPortrait = CGSize(width: 768, height: 1024)

    /// The regular iPad landscape screen size.
    static let iPadScreenLandscape = iPadScreenPortrait.flipped()
    
    /// The iPhone Pro Max portrait screen size.
    static let iPhoneProMaxScreenPortrait = CGSize(width: 428, height: 926)

    /// The iPhone Pro Max landscape screen size.
    static let iPhoneProMaxScreenLandscape = iPhoneProMaxScreenPortrait.flipped()
    
    /// Flip the size's height and width.
    func flipped() -> CGSize {
        CGSize(width: height, height: width)
    }

    /// Whether the size matches a size in any orientation.
    func isScreenSize(_ size: CGSize) -> Bool {
        self == size || self == size.flipped()
    }

    /// Whether the size matches a size in any orientation.
    func isScreenSize(
        _ size: CGSize,
        withTolerance points: CGFloat
    ) -> Bool {
        self.isEqual(to: size, withTolerance: points) ||
        self.isEqual(to: size.flipped(), withTolerance: points)
    }
}

extension CGSize {

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
