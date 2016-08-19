//
//  EmojiCollectionViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-08-19.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public class EmojiCollectionViewController: UITableViewController, UICollectionViewDataSource {
    
    
    // MARK: View lifecycle
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    

    
    // MARK: Properties
    
    public var keyboard: EmojiKeyboard!
    public var keyboardImages = [UIImage]()
    
    
    
    // MARK: Outlets
    
    @IBOutlet public weak var collectionView: UICollectionView!
    
    
    
    // MARK: Actions
    
    public func collectionViewCellLongPressed(gesture: UILongPressGestureRecognizer) {
        alertMissingImplementation("collectionViewCellLongPressed(...)")
    }
    
    public func collectionViewCellTapped(gesture: UITapGestureRecognizer) {
        alertMissingImplementation("collectionViewCellTapped(...)")
    }
    
 
    
    // MARK: Public functions
    
    public func createKeyboard() -> EmojiKeyboard! {
        alertMissingImplementation("createKeyboard()")
        return nil
    }
    
    public func emojiForCell(cell: UICollectionViewCell) -> String? {
        if let indexPath = collectionView.indexPathForCell(cell) {
            return keyboard.emojis[indexPath.row]
        }
        return nil
    }
    
    public func reloadData() {
        keyboard = createKeyboard()
        let keyboardImageNames = keyboard.emojis.map { keyboard.keyboardImageNameForEmoji($0) }
        keyboardImages = keyboardImageNames.map { UIImage(named: $0)! }
        collectionView.reloadData()
    }
    
    
    
    // MARK: Private functions
    
    private func alertMissingImplementation(functionName: String) {
        print("** WARNING! '\(functionName)\' not implemented in EmojiCollectionViewController subclass **")
    }
    
    private func setupLongPressGestureForCollectionViewCell(cell: UICollectionViewCell) {
        let longPressSelector = #selector(collectionViewCellLongPressed(_:))
        let longPress = UILongPressGestureRecognizer(target: self, action: longPressSelector)
        cell.addGestureRecognizer(longPress)
    }
    
    private func setupTapGestureForCollectionViewCell(cell: UICollectionViewCell) {
        let tapSelector = #selector(collectionViewCellTapped(_:))
        let tap = UITapGestureRecognizer(target: self, action: tapSelector)
        cell.addGestureRecognizer(tap)
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundView = UIImageView(image: keyboardImages[indexPath.row])
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        if (cell.gestureRecognizers == nil) {
            setupTapGestureForCollectionViewCell(cell)
            setupLongPressGestureForCollectionViewCell(cell)
        }
        
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboard.emojis.count
    }
}
