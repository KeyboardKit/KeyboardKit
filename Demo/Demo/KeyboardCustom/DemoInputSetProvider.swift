//
//  DemoInputSetProvider.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo-specific input set provider can be used to create
 a custom input set that contains "KEYBOARD", "KIT", "YEAH!".

 ``KeyboardViewController`` registers it to show how you can
 register and use a custom input set provider. 

 This is just a very simple and silly way to demonstrate how
 to use a custom input set provider with a custom layout.
 */
class DemoInputSetProvider: InputSetProvider {

    let baseProvider = EnglishInputSetProvider()

    var alphabeticInputSet: AlphabeticInputSet {
        AlphabeticInputSet(rows: [
            .init(chars: "KEYBOARD"),
            .init(chars: "KIT"),
            .init(chars: "YEAH!")
        ])
    }

    let numericInputSet: NumericInputSet = .standard(
        currency: "฿")

    let symbolicInputSet: SymbolicInputSet = .standard(
        currencies: ["₵", "₲", "₭"])
}
