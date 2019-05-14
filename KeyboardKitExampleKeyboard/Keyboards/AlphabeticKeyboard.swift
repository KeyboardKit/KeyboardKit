//
//  AlphabeticKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This keyboard mimicks the English alphabetic phone keyboard.
 It does not adjust itself to other device types or language
 layouts, since its intention isn't to be a fully functional
 keyboard, but rather to show you how to make keyboards that
 behaves like the system keyboards.
 
 */

import KeyboardKit

struct AlphabeticKeyboard: DemoKeyboard {
    
    init(
        uppercased: Bool,
        for idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom,
        in viewController: KeyboardViewController) {
        actions = type(of: self).actions(uppercased: uppercased, for: idiom, in: viewController)
    }

    let actions: KeyboardActionRows
}


// MARK: - Actions

private extension AlphabeticKeyboard {
    
    static func actions(
        uppercased: Bool,
        for idiom: UIUserInterfaceIdiom,
        in viewController: KeyboardViewController) -> KeyboardActionRows {
        let bottom = bottomActions(leftmost: .switchToNumericKeyboard, for: idiom, in: viewController)
        return characters(uppercased: uppercased)
            .mappedToActions()
            .adjusted(for: idiom, in: viewController, uppercased: uppercased)
            .appending(bottom)
    }
}


// MARK: - Characters

private extension AlphabeticKeyboard {
    
    static var characters: [[String]] {
        return [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
            ["z", "x", "c", "v", "b", "n", "m"]
        ]
    }
    
    static func characters(uppercased: Bool) -> [[String]] {
        return uppercased ? characters.uppercased() : characters
    }
}


// MARK: - Character Extensions

private extension Sequence where Iterator.Element == [String] {
    
    func uppercased() -> [Iterator.Element] {
        return map { $0.map { $0.uppercased() } }
    }
    
    func mappedToActions() -> [[KeyboardAction]] {
        return map { $0.map { .character($0) } }
    }
}


// MARK: - Action Extensions

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func adjusted(
        for idiom: UIUserInterfaceIdiom,
        in viewController: UIInputViewController,
        uppercased: Bool) -> [Iterator.Element] {
        switch idiom {
        case .pad: return adjustedForIpad(uppercased: uppercased)
        default: return adjustedForIphone(uppercased: uppercased)
        }
    }
    
    func adjustedForIphone(uppercased: Bool) -> [Iterator.Element] {
        var result = map { $0 }
        result[2].insert(uppercased ? .shiftDown : .shift, at: 0)
        result[2].insert(.none, at: 1)
        result[2].append(.none)
        result[2].append(.backspace)
        return result
    }
    
    func adjustedForIpad(uppercased: Bool) -> [Iterator.Element] {
        var result = map { $0 }
        result[2].insert(uppercased ? .shiftDown : .shift, at: 0)
        result[2].insert(.none, at: 1)
        result[2].append(.none)
        result[2].append(.backspace)
        return result
    }
    
    func appending(_ actions: KeyboardActionRow) -> KeyboardActionRows {
        var result = map { $0 }
        result.append(actions)
        return result
    }
}
