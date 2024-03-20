//
//  InputSet+Rows.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension InputSet {
    
    /// This typealias represents a row of input set items.
    typealias Row = [Item]
    
    /// This typealias represents a list of input set rows.
    typealias Rows = [Row]
}

public extension InputSet.Row {
    
    /// Create an input row from a character string.
    init(chars: String) {
        self.init(chars: chars.chars)
    }
    
    /// Create an input row from a character array.
    init(chars: [String]) {
        self = chars.map {
            InputSet.Item($0)
        }
    }

    /// Create an input row from two cased character strings.
    init(lowercased: String, uppercased: String) {
        self.init(
            lowercased: lowercased.chars,
            uppercased: uppercased.chars
        )
    }
    
    /// Create an input row from two cased character arrays.
    init(lowercased: [String], uppercased: [String]) {
        let equal = lowercased.count == uppercased.count
        assert(equal, "lowercased and uppercased must contain the same number of characters")
        self = lowercased.enumerated().map {
            InputSet.Item(
                neutral: lowercased[$0.offset],
                uppercased: uppercased[$0.offset],
                lowercased: lowercased[$0.offset]
            )
        }
    }

    /// Create an input row from device character strings.
    init(
        phone: String,
        pad: String,
        deviceType: DeviceType = .current
    ) {
        self.init(chars: deviceType == .pad ? pad : phone)
    }
    
    /// Create an input row from device character arrays.
    init(
        phone: [String],
        pad: [String],
        deviceType: DeviceType = .current
    ) {
        self.init(chars: deviceType == .pad ? pad : phone)
    }

    /// Create an input row from device character strings.
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
    
    /// Create an input row from device character arrays.
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
    
    /// Get all input characters for a certain keyboard case.
    func characters(
        for case: Keyboard.Case = .lowercased
    ) -> [String] {
        map { $0.character(for: `case`) }
    }
}

public extension InputSet.Rows {

    /// Get all input characters for a certain keyboard case.
    func characters(
        for case: Keyboard.Case = .lowercased
    ) -> [[String]] {
        map { $0.characters(for: `case`) }
    }
}
