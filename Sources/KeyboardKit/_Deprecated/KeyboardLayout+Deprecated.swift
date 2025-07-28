import Foundation
import SwiftUI

@available(*, deprecated, renamed: "KeyboardLayout.InputSet")
public typealias InputSet = KeyboardLayout.InputSet

public extension KeyboardLayout {
    
    @available(*, deprecated, renamed: "init(itemRows:ipadProLayout:idealItemHeight:idealItemInsets:inputToolbarInputSet:)")
    init(
        itemRows: ItemRows,
        iPadProLayout: Bool = false,
        idealItemHeight: Double? = nil,
        idealItemInsets: EdgeInsets? = nil,
        numberInputToolbarInputSet: InputSet
    ) {
        self.init(
            itemRows: itemRows,
            iPadProLayout: iPadProLayout,
            idealItemHeight: idealItemHeight,
            idealItemInsets: idealItemInsets,
            inputToolbarInputSet: numberInputToolbarInputSet
        )
    }

    @available(*, deprecated, renamed: "inputToolbarInputSet")
    var numberInputToolbarInputSet: InputSet? {
        get { inputToolbarInputSet }
        set { inputToolbarInputSet = newValue }
    }
}

public extension KeyboardLayout {
    
    @available(*, deprecated, renamed: "DeviceConfiguration")
    typealias Configuration = DeviceConfiguration
}

public extension KeyboardLayout {

    @available(*, deprecated, renamed: "isIpadProLayout")
    var ipadProLayout: Bool {
        get { isIpadProLayout }
        set { isIpadProLayout = newValue }
    }
}

public extension KeyboardLayout.DeviceConfiguration {

    @available(*, deprecated, message: "Use the configuration height instead.")
    static var standardPadRowHeight: Double { 64.0 }

    @available(*, deprecated, message: "Use the configuration height instead.")
    static var standardPadLandscapeRowHeight: Double { 86.0 }

    @available(*, deprecated, message: "Use the configuration height instead.")
    static var standardPadProLargeRowHeight: Double { 69.0 }

    @available(*, deprecated, message: "Use the configuration height instead.")
    static var standardPadProLargeLandscapeRowHeight: Double { 88.0 }

    @available(*, deprecated, message: "Use the configuration height instead.")
    static var standardPhoneRowHeight: Double { 54 }      /// !

    @available(*, deprecated, message: "Use the configuration height instead.")
    static var standardPhoneLandscapeRowHeight: Double { 40.0 }

    @available(*, deprecated, message: "Use the configuration height instead.")
    static var standardPhoneProMaxRowHeight: Double { 56.0 }

    @available(*, deprecated, message: "Use the configuration height instead.")
    static var standardPhoneProMaxLandscapeRowHeight: Double { 40.0 }


    @available(*, deprecated, renamed: "standardPadLarge")
    static var standardPadProLarge = standardPadLarge

    @available(*, deprecated, renamed: "standardPadLargeLandscape")
    static var standardPadProLargeLandscape = standardPadLargeLandscape

    @available(*, deprecated, renamed: "standardPhoneLarge")
    static var standardPhoneProMax = standardPhoneLarge

    @available(*, deprecated, renamed: "standardPhoneLargeLandscape")
    static var standardPhoneProMaxLandscape = standardPhoneLargeLandscape
}

public extension CGSize {

    @available(*, deprecated, renamed: "iPadLargeScreen")
    static let iPadProLargeScreenPortrait = iPadLargeScreen

    @available(*, deprecated, renamed: "iPadLargeScreenLandscape")
    static let iPadProLargeScreenLandscape = iPadLargeScreenLandscape

    @available(*, deprecated, renamed: "iPhoneLargeScreen")
    static let iPhoneProMaxScreenPortrait = iPhoneLargeScreen

    @available(*, deprecated, renamed: "iPhoneLargeScreenLandscape")
    static let iPhoneProMaxScreenLandscape = iPhoneLargeScreenLandscape

    @available(*, deprecated, message: "This will be removed in KeyboardKit 10.")
    static let iPadProSmallScreenPortrait = CGSize(width: 834, height: 1194)

    @available(*, deprecated, message: "This will be removed in KeyboardKit 10.")
    static let iPadProSmallScreenLandscape = iPadProSmallScreenPortrait.flipped()

    @available(*, deprecated, message: "This will be removed in KeyboardKit 10.")
    static let iPadScreenPortrait = CGSize(width: 768, height: 1024)

    @available(*, deprecated, message: "This will be removed in KeyboardKit 10.")
    static let iPadScreenLandscape = iPadScreenPortrait.flipped()
}
