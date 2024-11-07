import Foundation
import SwiftUI

public extension InputSet {

    @available(*, deprecated, renamed: "ItemRow", message: "Migration Deprecation, will be removed in 9.1!")
    typealias Row = ItemRow

    @available(*, deprecated, renamed: "ItemRows", message: "Migration Deprecation, will be removed in 9.1!")
    typealias Rows = ItemRows
}

public extension InputSet.ItemRow {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! This is destructive, and can't be used to dynamically resolve a device-specific layout. Use the variations-based initializer instead.")
    init(
        phone: String,
        pad: String,
        deviceType: DeviceType = .current
    ) {
        self.init(chars: deviceType == .pad ? pad : phone)
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! This is destructive, and can't be used to dynamically resolve a device-specific layout. Use the variations-based initializer instead.")
    init(
        phone: [String],
        pad: [String],
        deviceType: DeviceType = .current
    ) {
        self.init(chars: deviceType == .pad ? pad : phone)
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! This is destructive, and can't be used to dynamically resolve a device-specific layout. Use the variations-based initializer instead.")
    init(
        phoneLowercased: String,
        phoneUppercased: String,
        padLowercased: String,
        padUppercased: String,
        deviceType: DeviceType = .current
    ) {
        self.init(
            lowercased: deviceType == .pad ? padLowercased : phoneLowercased,
            uppercased: deviceType == .pad ? padUppercased : phoneUppercased
        )
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! This is destructive, and can't be used to dynamically resolve a device-specific layout. Use the variations-based initializer instead.")
    init(
        phoneLowercased: [String],
        phoneUppercased: [String],
        padLowercased: [String],
        padUppercased: [String],
        deviceType: DeviceType = .current
    ) {
        self.init(
            lowercased: deviceType == .pad ? padLowercased : phoneLowercased,
            uppercased: deviceType == .pad ? padUppercased : phoneUppercased
        )
    }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
public extension KeyboardLayoutService where Self == KeyboardLayout.DisabledService {

    static var disabled: Self {
        KeyboardLayout.DisabledService()
    }
}

extension KeyboardLayout {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
    open class DisabledService: KeyboardLayout.BaseService {

        public init() {
            super.init(
                alphabeticInputSet: .qwerty,
                numericInputSet: .numeric(currency: "$"),
                symbolicInputSet: .symbolic(currencies: ["€£¥"])
            )
        }
    }
}

