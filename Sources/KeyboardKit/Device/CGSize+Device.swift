//
//  CGSize+Device.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-08.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This extension specifies screen sizes, as they are reported
 when the keyboard prints out the size.
 */
public extension CGSize {
    
    /**
     Whether or not the size is a large iPad Pro screen size
     in portrait orientation.
     */
    static let iPadProLargeScreenPortrait = CGSize(width: 1024, height: 1366)

    /**
     Whether or not the size is a large iPad Pro screen size
     in landscape orientation.
     */
    static let iPadProLargeScreenLandscape = iPadProLargeScreenPortrait.flipped()

    /**
     Whether or not the size is a small iPad Pro screen size
     in portrait orientation.
     */
    static let iPadProSmallScreenPortrait = CGSize(width: 834, height: 1194)

    /**
     Whether or not the size is a small iPad Pro screen size
     in landscape orientation.
     */
    static let iPadProSmallScreenLandscape = iPadProSmallScreenPortrait.flipped()

    /**
     Whether or not the size is a "regular" iPad screen size
     in portrait orientation.
     */
    static let iPadScreenPortrait = CGSize(width: 768, height: 1024)

    /**
     Whether or not the size is a "regular" iPad screen size
     in landscape orientation.
     */
    static let iPadScreenLandscape = iPadScreenPortrait.flipped()
    
    /**
     Whether or not the size is an iPhone ProMax screen size
     in portrait orientation.
     */
    static let iPhoneProMaxScreenPortrait = CGSize(width: 428, height: 926)

    /**
     Whether or not the size is an iPhone ProMax screen size
     in portrait orientation.
     */
    static let iPhoneProMaxScreenLandscape = iPhoneProMaxScreenPortrait.flipped()
    
    /**
     Flip the size's height and width.
     */
    func flipped() -> CGSize {
        CGSize(width: height, height: width)
    }

    /**
     Whether or not the size matches another screen size, in
     any orientation.
     */
    func isScreenSize(_ size: CGSize) -> Bool {
        self == size || self == size.flipped()
    }

    /**
     Whether or not the size matches another screen size, in
     any orientation.
     */
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
