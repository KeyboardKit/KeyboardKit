//
//  EmojiCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-08-19.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit


public protocol EmojiCollectionViewDelegate: class {
    
    func collectionView(collectionView: UICollectionView, didTapEmoji emoji: String)
    func collectionView(collectionView: UICollectionView, didLongPressEmoji emoji: String)
}




public class EmojiCollectionView: UICollectionView, UICollectionViewDataSource {
    
    
    // MARK: Properties
    
    weak public var emojiDelegate: EmojiCollectionViewDelegate?
    
    public var emojiCellIdentifier = "Cell"
    public var keyboard: EmojiKeyboard?
    
    private var keyboardImages: [UIImage]?
    
    
    
    // MARK: Public functions
    
    public func emojiForCell(cell: UICollectionViewCell) -> String? {
        let row = indexPathForCell(cell)?.row ?? 0
        return keyboard?.emojis[row]
    }
    
    public override func reloadData() {
        dataSource = self
        let imageNames = keyboard?.emojis.map { keyboard!.keyboardImageNameForEmoji($0) }
        keyboardImages = imageNames?.map { UIImage(named: $0)! }
        super.reloadData()
    }
    
    
    
    // MARK: Private functions
    
    func handleCellLongPressed(gesture: UILongPressGestureRecognizer) {
        if (gesture.state == .Began) {
            if let cell = gesture.view as? UICollectionViewCell {
                if let emoji = emojiForCell(cell) {
                    emojiDelegate?.collectionView(self, didLongPressEmoji: emoji)
                }
            }
        }
    }
    
    func handleCellTapped(gesture: UITapGestureRecognizer) {
        if let cell = gesture.view as? UICollectionViewCell {
            if let emoji = emojiForCell(cell) {
                emojiDelegate?.collectionView(self, didTapEmoji: emoji)
            }
        }
    }
    
    private func setupGesturesForCell(cell: UICollectionViewCell) {
        if (cell.gestureRecognizers == nil) {
            setupTapGestureForCell(cell)
            setupLongPressGestureForCell(cell)
        }
    }
    
    private func setupLongPressGestureForCell(cell: UICollectionViewCell) {
        let selector = #selector(handleCellLongPressed(_:))
        let longPress = UILongPressGestureRecognizer(target: self, action: selector)
        cell.addGestureRecognizer(longPress)
    }
    
    private func setupTapGestureForCell(cell: UICollectionViewCell) {
        let selector = #selector(handleCellTapped(_:))
        let tap = UITapGestureRecognizer(target: self, action: selector)
        cell.addGestureRecognizer(tap)
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(emojiCellIdentifier, forIndexPath: indexPath)
        cell.backgroundView = UIImageView(image: keyboardImages?[indexPath.row])
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        setupGesturesForCell(cell)
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboard?.emojis.count ?? 0
    }
}
