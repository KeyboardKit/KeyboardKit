//
//  SystemKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-15.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

public extension SystemKeyboardLayoutProvider {
    
    /**
     The number of alphabetic inputs on each input row.
     */
    var alphabeticInputCount: [Int] {
        inputSetProvider.alphabeticInputSet.rows.map { $0.count }
    }
    
    /**
     Whether or not the alphabetic input set uses an 11-11-X
     layout, which is used by e.g. `German` keyboards.
     */
    var hasElevenElevenAlphabeticInput: Bool {
        alphabeticInputCount.prefix(2) == [11, 11]
    }

    /**
     Whether or not the alphabetic input set uses an 11-10-9
     layout, which is used by `Turkish` iPhone keyboards.
     */
    var hasTwelveElevenNineAlphabeticInput: Bool {
        alphabeticInputCount.prefix(3) == [12, 11, 9]
    }
    
    /**
     Whether or not the context keyboard type is alphabetic.
     */
    func isAlphabetic(_ context: KeyboardContext) -> Bool {
        context.keyboardType.isAlphabetic
    }
    
    /**
     Whether or not to use an Arabic alphabetic keyboard.
     */
    func isArabic(_ context: KeyboardContext) -> Bool {
        context.locale.identifier == "ar"
    }
    
    /**
     Whether or not to use an Arabic alphabetic keyboard.
     */
    func isArabicAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && isArabic(context)
    }
    
    /**
     Whether or not to use an Belarusian alphabetic keyboard.
     */
    func isBelarusianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == "be"
    }
    
    /**
     Whether or not to use an Czech alphabetic keyboard.
     */
    func isCzechAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == "cs"
    }
    
    /**
     Whether or not to use an Greek alphabetic keyboard.
     */
    func isGreek(_ context: KeyboardContext) -> Bool {
        context.locale.identifier == "el"
    }
    
    /**
     Whether or not to use an Greek alphabetic keyboard.
     */
    func isGreekAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && isGreek(context)
    }
    
    /**
     Whether or not to use an Persian alphabetic keyboard.
     */
    func isPersianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == "fa"
    }
    
    /**
     Whether or not to use an Russian alphabetic keyboard.
     */
    func isRussianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == "ru"
    }
    
    /**
     Whether or not to use an Russian alphabetic keyboard.
     */
    func isUkrainianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == "uk"
    }
    
    /**
     Get the leading margin action for a certain action row.
     */
    func leadingMarginAction(for actions: KeyboardActions) -> KeyboardAction {
        marginAction(for: actions.first { $0.isInputAction })
    }
    
    /**
     Get the trailing margin action for a certain action row.
     */
    func trailingMarginAction(for actions: KeyboardActions) -> KeyboardAction {
        marginAction(for: actions.last { $0.isInputAction })
    }
    
    /**
     Get a margin action for a certain action, if any.
     
     This function returns `characterMargin` for `character`
     and `none` for all other action types.
     */
    func marginAction(for action: KeyboardAction?) -> KeyboardAction {
        guard let action = action else { return .none }
        switch action {
        case .character(let char): return .characterMargin(char)
        default: return .none
        }
    }
}
