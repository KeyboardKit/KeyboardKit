//
//  KeyboardViewController+Setup.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func setupKeyboard() {
        setupKeyboard(for: view.bounds.size)
    }
    
    func setupKeyboard(for size: CGSize) {
        DispatchQueue.main.async {
            self.setupKeyboardAsync(for: size)
        }
    }
    
    func setupKeyboardAsync(for size: CGSize) {
        keyboardStackView.removeAllArrangedSubviews()
        switch keyboardType {
        case .alphabetic(let uppercased): setupAlphabeticKeyboard(uppercased: uppercased)
        case .emojis: setupEmojiKeyboard(for: size)
        case .images: setupImageKeyboard(for: size)
        case .numeric: setupNumericKeyboard()
        case .symbolic: setupSymbolicKeyboard()
        default: return
        }
    }
    
    func setupAlphabeticKeyboard(uppercased: Bool = false) {
        let keyboard = AlphabeticKeyboard(uppercased: uppercased, in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
    
    func setupEmojiKeyboard(for size: CGSize) {
        var keyboard = EmojiKeyboard(in: self)
        let config = keyboard.gridConfig
        //let emojis = keyboard.orderEmojis(rowsPerPage: config.rowsPerPage, pageSize: config.pageSize) /** this function changes the order as the emojis are shown from top to bottom */
        let view = KeyboardButtonRowCollectionView(id: "EmojiKeyboard", actions: [], configuration: config) { [unowned self] in return self.button(for: $0) }
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        
        // let pageIndex = EmojiKeyboard.currentPageIndex
        emojiCategoryTitleLabel.text = "HEJ" /// keyboard.getNameCategoryEmoji(currentPage: 0, bottomActions: bottomActions)
        
        view.panGestureRecognizer.addTarget(self, action: #selector(checkCategoryEmoji(_:)))/** a gesture is added to detect each time the category is changed*/
        
        keyboardStackView.addArrangedSubview(emojiCategoryTitleLabel)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
        emojiCollectionView = view
    }
    
    func setupImageKeyboard(for size: CGSize) {
        let keyboard = ImageKeyboard(in: self)
        let view = KeyboardButtonRowCollectionView(actions: keyboard.actions, configuration: keyboard.gridConfig) { [unowned self] in return self.button(for: $0) }
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
    }
    
    func setupNumericKeyboard() {
        let keyboard = NumericKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
    
    func setupSymbolicKeyboard() {
        let keyboard = SymbolicKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
    
    @objc func checkCategoryEmoji(_ recognizer: UIPanGestureRecognizer){
        guard recognizer.state == .ended else { return }
        guard let view = emojiCollectionView else { return }
        ///let pageIndex = view.currentPageIndex
        ///emojiCategoryTitleLabel.text = EmojiKeyboard(in: self).getNameCategoryEmoji(currentPage: pageIndex, bottomActions: emojiBottomActions)
    }
}
