//
//  AlphabeticalKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This keyboard mimicks the default alphabetical iOS keyboard.
 
 It adjusts itself to the user interface idiom, but only has
 support for English. Its intention is not to provide a full
 replacement of the system keyboard, just to show you how to
 build a keyboard that can be mapped to keyboard button rows.
 
 */

import KeyboardKit

struct AlphabeticalKeyboard {
    
    init(
        for idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom,
        uppercased: Bool) {
        actions = type(of: self).actions(for: idiom, uppercased: uppercased)
    }

    let actions: [[KeyboardAction]]
    let distribution = UIStackView.Distribution.fillProportionally
}


// MARK: - Actions

private extension AlphabeticalKeyboard {
    
    static func actions(for idiom: UIUserInterfaceIdiom, uppercased: Bool) -> [[KeyboardAction]] {
        return characters(uppercased: uppercased)
            .mappedToActions()
            .adjusted(for: idiom)
    }
}


// MARK: - Characters

private extension AlphabeticalKeyboard {
    
    static var characterRows: [[String]] {
        return [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
            ["z", "x", "c", "v", "b", "n", "m"]
        ]
    }
    
    static func characters(uppercased: Bool) -> [[String]] {
        return uppercased ? characterRows.uppercased() : characterRows
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

private extension Sequence where Iterator.Element == [KeyboardAction] {
    
    func adjusted(for idiom: UIUserInterfaceIdiom) -> [Iterator.Element] {
        switch idiom {
        case .pad: return widthSideButtonsForIpad().withSystemButtonsForIpad()
        default: return widthSideButtonsForIphone().withSystemButtonsForIphone()
        }
    }
    
    func widthSideButtonsForIphone() -> [Iterator.Element] {
        var actions = map { $0 }
        actions[2].insert(.shift, at: 0)
        actions[2].insert(.none, at: 1)
        actions[2].append(.none)
        actions[2].append(.backspace)
        return actions
    }
    
    func widthSideButtonsForIpad() -> [Iterator.Element] {
        var actions = map { $0 }
        actions[0].append(.backspace)
        actions[1].append(.newLine)
        actions[2].insert(.shift, at: 0)
        actions[2].append(.shift)
        return actions
    }
    
    func withSystemButtonsForIphone() -> [Iterator.Element] {
        let systemActions: [KeyboardAction] = [.switchToNumericKeyboard, .space, .newLine]
        return map { $0 } + [systemActions]
    }
    
    func withSystemButtonsForIpad() -> [Iterator.Element] {
        let systemActions: [KeyboardAction] = [.switchToNumericKeyboard, .switchKeyboard, .space, .switchToNumericKeyboard, .dismissKeyboard]
        return map { $0 } + [systemActions]
    }
}
