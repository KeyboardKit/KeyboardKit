//
//  CustomButtonRowCollectionView.swift
//  KeyboardKitDemoKeyboard
//
//  Created by 于留传 on 2021/1/16.
//

import Foundation
import UIKit
import KeyboardKit

struct EnhancedEmojiKeyboard: DemoKeyboard {
    
    init(context: KeyboardContext) {
        let isLandscape = context.deviceOrientation.isLandscape
        let rowsPerPage = isLandscape ? 3 : 5
        gridConfig = HFloatingHeaderButtonCollectionView.Configuration(headerSize: CGSize(width: 200, height: 30), itemSize: CGSize(width: 48, height: 48), rowsCount: rowsPerPage, titleColor: nil, titleFont: nil, headerWidthToFitText: true, itemFont: UIFont.preferredFont(forTextStyle: .callout), itemWidthToFitText: true,  edgeInsets: .standardKeyboardButtonInsets())
        bottomActions = Self.createBottomActions(for: categories)
        categoryActions = Self.createCategoryActions(for: categories)
    }

    let categoryActions: [(String, KeyboardActions)]
    let bottomActions: KeyboardActions
    let categories = EmojiCategory.all
    let gridConfig: HFloatingHeaderButtonCollectionView.Configuration
    
    private var emoji: [KeyboardAction] = []
}

private extension EnhancedEmojiKeyboard {
    
    static func createBottomActions(for categories: [EmojiCategory]) -> KeyboardActions {
        var actions = categories.map { KeyboardAction.emojiCategory($0) }
        actions.insert(.keyboardType(.alphabetic(.lowercased)), at: 0)
        actions.append(.backspace)
        return actions
    }
    
    static func createCategoryActions(for categories: [EmojiCategory]) -> [(String, KeyboardActions)]{
        // Remove empty frequent
        categories.filter { $0.rawValue != "frequent"}.compactMap {
            ($0.title, $0.emojis.map { KeyboardAction.emoji($0) })
        }
    }
}
