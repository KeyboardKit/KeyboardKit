//
//  EmojiCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-08-19.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit


public protocol EmojiCollectionViewDelegate: class {
    
    func collectionView(_ view: UICollectionView, didTapEmoji emoji: String)
    func collectionView(_ view: UICollectionView, didLongPressEmoji emoji: String)
}



open class EmojiCollectionView: UICollectionView, UICollectionViewDataSource {
    
    
    // MARK: - Properties
    
    weak open var emojiDelegate: EmojiCollectionViewDelegate?
    
    open var emojiCellIdentifier = "Cell"
    open var keyboard: EmojiKeyboard?
    
    fileprivate var keyboardImages: [UIImage]?
    
    
    
    // MARK: - Public functions
    
    open func emojiForCell(_ cell: UICollectionViewCell) -> String? {
        let row = (indexPath(for: cell) as NSIndexPath?)?.row ?? 0
        return keyboard?.emojis[row]
    }
    
    open override func reloadData() {
        dataSource = self
        let imageNames = keyboard?.emojis.map { keyboard!.keyboardImageName(forEmoji: $0) }
        keyboardImages = imageNames?.map { UIImage(named: $0)! }
        super.reloadData()
    }
    
    
    
    // MARK: - Private functions
    
    func cellLongPressed(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        guard let cell = gesture.view as? UICollectionViewCell else { return }
        guard let emoji = emojiForCell(cell) else { return }
        emojiDelegate?.collectionView(self, didLongPressEmoji: emoji)
    }
    
    func cellTapped(_ gesture: UITapGestureRecognizer) {
        guard let cell = gesture.view as? UICollectionViewCell else { return }
        guard let emoji = emojiForCell(cell) else { return }
        emojiDelegate?.collectionView(self, didTapEmoji: emoji)
    }
    
    fileprivate func setupGestures(for cell: UICollectionViewCell) {
        guard cell.gestureRecognizers == nil else { return }
        setupTapGesture(for: cell)
        setupLongPressGesture(for: cell)
    }
    
    fileprivate func setupLongPressGesture(for cell: UICollectionViewCell) {
        let selector = #selector(cellLongPressed(_:))
        let longPress = UILongPressGestureRecognizer(target: self, action: selector)
        cell.addGestureRecognizer(longPress)
    }
    
    fileprivate func setupTapGesture(for cell: UICollectionViewCell) {
        let selector = #selector(cellTapped(_:))
        let tap = UITapGestureRecognizer(target: self, action: selector)
        cell.addGestureRecognizer(tap)
    }
    
    
    
    // MARK: - UICollectionViewDataSource
    
    open func collectionView(_ view: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = view.dequeueReusableCell(withReuseIdentifier: emojiCellIdentifier, for: indexPath)
        cell.backgroundView = UIImageView(image: keyboardImages?[(indexPath as NSIndexPath).row])
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        setupGestures(for: cell)
        return cell
    }
    
    open func collectionView(_ view: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboard?.emojis.count ?? 0
    }
}
