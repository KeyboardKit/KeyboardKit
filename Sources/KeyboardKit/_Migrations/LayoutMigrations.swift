import Foundation
import SwiftUI

public extension InputSet {

    @available(*, deprecated, renamed: "RowItem", message: "Migration Deprecation, will be removed in 9.1!")
    typealias Item = RowItem
}

public extension InputSet.Row {

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
