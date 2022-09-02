//
//  DemoInputSetProvider.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo-specific `InputSetProvider` can be used to create
 a keyboard that has three button rows with custom keys.

 This is just a very simple and silly way to demonstrate how
 to use a custom input set provider with a custom layout.
 */
class DemoInputSetProvider: InputSetProvider {

    let baseProvider = EnglishInputSetProvider()

    var alphabeticInputSet: AlphabeticInputSet {
        AlphabeticInputSet(rows: [
            .init("KEYBOARD"),
            .init("KIT"),
            .init("YEAH!")
        ])
    }

    let numericInputSet: NumericInputSet = .standard(
        currency: "฿")

    let symbolicInputSet: SymbolicInputSet = .standard(
        currencies: ["₵", "₲", "₭"])
}
