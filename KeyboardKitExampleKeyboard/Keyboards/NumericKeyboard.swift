//
//  NumericKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This keyboard mimicks the default numeric keyboard for iOS,
 just like `AlphabeticalKeyboard` mimics the alphabetical.
 
 */

import KeyboardKit

struct NumericKeyboard {
    
    init(
        for idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom,
        uppercased: Bool) {
        actions = type(of: self).actions(for: idiom, uppercased: uppercased)
    }
    
    let actions: [[KeyboardAction]]
    let distribution = UIStackView.Distribution.fillProportionally
}


// MARK: - Actions

private extension NumericKeyboard {
    
    static func actions(for idiom: UIUserInterfaceIdiom, uppercased: Bool) -> [[KeyboardAction]] {
        return characters(uppercased: uppercased)
            .mappedToActions()
            .adjusted(for: idiom)
    }
}


// MARK: - Characters

private extension NumericKeyboard {
    
    static var characterRows: [[String]] {
        return [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
            ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""],
            [".", ",", "?", "!", "´"]
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
        actions[2].insert(.switchToSymbolKeyboard, at: 0)
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
        let systemActions: [KeyboardAction] = [.switchToAlphabeticalKeyboard, .space, .newLine]
        return map { $0 } + [systemActions]
    }
    
    func withSystemButtonsForIpad() -> [Iterator.Element] {
        let systemActions: [KeyboardAction] = [.switchToAlphabeticalKeyboard, .switchKeyboard, .space, .switchToAlphabeticalKeyboard, .dismissKeyboard]
        return map { $0 } + [systemActions]
    }
}
