//
//  InputSetRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This typealias represents a row of input set items.
 */
public typealias InputSetRow = [InputSetItem]

public extension InputSetRow {
    
    /**
     Create an input row from a string, where each character
     is mapped to a ``InputSetItem``.
     */
    init(_ chars: String) {
        self.init(chars.chars)
    }
    
    /**
     Create an input row from an array, where each character
     is mapped to a ``InputSetItem``.
     */
    init(_ row: [String]) {
        self = row.map { InputSetItem($0) }
    }

    /**
     Create an input row from a lowercased and an uppercased
     string, where each char is mapped to a ``InputSetItem``.

     Both arrays must contain the same amount of characters.
     */
    init(lowercased: String, uppercased: String
    ) {
        self.init(
            lowercased: lowercased.chars,
            uppercased: uppercased.chars
        )
    }

    /**
     Create an input row from a lowercased and an uppercased
     array, where each char is mapped to a ``InputSetItem``.

     Both arrays must contain the same amount of characters.
     */
    init(lowercased: [String], uppercased: [String]) {
        assert(lowercased.count == uppercased.count, "The lowercased and uppercased string arrays must contain the same amount of characters")
        self = lowercased.enumerated().map {
            InputSetItem(
                neutral: lowercased[$0.offset],
                uppercased: uppercased[$0.offset],
                lowercased: lowercased[$0.offset])
        }
    }

    /**
     Create an input row from phone and pad-specific strings,
     where each character is mapped to a ``InputSetItem``.
     */
    init(phone: String, pad: String, deviceType: DeviceType = .current) {
        self.init(deviceType == .pad ? pad.chars : phone.chars)
    }

    /**
     Create an input row from phone and pad-specific strings,
     where each character is mapped to a ``InputSetItem``.
     */
    init(phone: [String], pad: [String], deviceType: DeviceType = .current) {
        self.init(deviceType == .pad ? pad : phone)
    }

    /**
     Create an input row from phone and pad-specific strings,
     where each character is mapped to a ``InputSetItem``.
     */
    init(
        phoneLowercased: String,
        phoneUppercased: String,
        padLowercased: String,
        padUppercased: String,
        deviceType: DeviceType = .current
    ) {
        self.init(
            lowercased: deviceType == .pad ? padLowercased.chars : phoneLowercased.chars,
            uppercased: deviceType == .pad ? padUppercased.chars : phoneUppercased.chars)
    }

    /**
     Create an input row from phone and pad-specific strings,
     where each character is mapped to a ``InputSetItem``.
     */
    init(
        phoneLowercased: [String],
        phoneUppercased: [String],
        padLowercased: [String],
        padUppercased: [String],
        deviceType: DeviceType = .current
    ) {
        self.init(
            lowercased: deviceType == .pad ? padLowercased : phoneLowercased,
            uppercased: deviceType == .pad ? padUppercased : phoneUppercased)
    }
    
    /**
     Get all input characters for a certain keyboard casing.
     */
    func characters(for casing: KeyboardCasing = .lowercased) -> [String] {
        map { $0.character(for: casing) }
    }
}
