//
//  EmojiKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-25.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 When you create your own emoji keyboard, you must make
 sure to override the properties and functions that are
 commented with "Implement in sub class"
 
 */


import UIKit


public class EmojiKeyboard: NSObject, Keyboard, UIScrollViewDelegate {
    
    
    // MARK: Init
    
    override public init() {
        super.init()
    }
    
    convenience public init(rowsPerPage: Int, emojisPerRow: Int) {
        self.init()
        self.rowsPerPage = rowsPerPage
        self.emojisPerRow = emojisPerRow
    }
    
    
    
    // MARK: Properties
    
    public weak var delegate: KeyboardDelegate?
    
    public var emojis: [String] {
        alertMissingImplementation("emojis")
        return [String]()
    }
    
    public var pageNumber: Int {
        get { return scrollView.pageNumber }
        set { scrollView.pageNumber = newValue }
    }
    
    public var systemButtons: [KeyboardButton] {
        alertMissingImplementation("systemButtons")
        return [KeyboardButton]()
    }
    
    private var rowsPerPage = 3
    private var emojisPerRow = 6
    
    private var pageControl: UIPageControl!
    private var scrollView: UIScrollView!
    
    
    
    // MARK: Actions
    
    public func buttonLongPressed(gesture: UILongPressGestureRecognizer) {
        if (gesture.state == .Began) {
            if let button = gesture.view as? KeyboardButton {
                delegate?.keyboard(self, buttonLongPressed: button)
            }
        }
    }
    
    public func buttonTapped(gesture: UITapGestureRecognizer) {
        if let button = gesture.view as? KeyboardButton {
            delegate?.keyboard(self, buttonTapped: button)
        }
    }
    
    
    
    // MARK: Public functions
    
    public func copyImageToPasteboard(image: UIImage) {
        alertMissingImplementation("copyImageToPasteboard(...)")
    }
    
    public func keyboardImageNameForEmoji(emoji: String) -> String {
        alertMissingImplementation("keyboardImageNameForEmoji(...)")
        return emoji
    }
    
    public func saveImageToPhotos(image: UIImage, completionTarget: AnyObject?, completionSelector: Selector) {
        alertMissingImplementation("saveEmojiToPhotos(...)")
    }
    
    public func setupKeyboardInViewController(vc: UIInputViewController) {
        resetKeyboardInViewController(vc)
        styleInputViewController(vc)
        
        let width = vc.view.bounds.width
        let height = vc.view.bounds.height
        let rowHeight = height / CGFloat(rowsPerPage + 1)
        let rows = batchArray(emojis, withBatchSize: emojisPerRow)
        
        scrollView = createScrollViewInView(vc.view)
        
        var lastIndexPath: NSIndexPath?
        
        for (index, emojis) in rows.enumerate() {
            let buttons = emojis.map { createEmojiButton($0) }
            let indexPath = getIndexPathForRowNumber(index)
            lastIndexPath = indexPath
            let x = CGFloat(indexPath.section) * width
            let y = CGFloat(indexPath.row) * rowHeight
            let row = UIView(frame: CGRectMake(x, y, width, rowHeight))
            for button in buttons {
                row.addSubview(button)
            }
            setupConstraintsForButtons(buttons, inRowView: row)
            scrollView.addSubview(row)
        }
        
        let systemRow = createSystemRowWithFrame(CGRectMake(0, 3*rowHeight, width, rowHeight))
        vc.view.addSubview(systemRow)
        
        let numberOfPages = (lastIndexPath?.section ?? 0) + 1
        scrollView.contentSize = CGSizeMake(CGFloat(numberOfPages) * width, height)
        pageControl = createPageControlInView(systemRow, numberOfPages: numberOfPages)
    }
    
    public func styleInputViewController(vc: UIInputViewController) {
        alertMissingImplementation("styleInputViewController(...)")
    }
    
    public func styleKeyboardButton(button: KeyboardButton) {
        alertMissingImplementation("styleKeyboardButton(...)")
    }
    
    public func stylePageControl(pageControl: UIPageControl) {
        alertMissingImplementation("stylePageControl(...)")
    }
    
    public func styleSystemButton(button: KeyboardButton) {
        alertMissingImplementation("styleSystemButton(...)")
    }
    
    public func styleSystemRow(row: UIView) {
        alertMissingImplementation("styleSystemRow(...)")
    }
    
    

    // MARK: Private functions
    
    private func addLongPressGestureToEmojiButton(button: KeyboardButton) {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(buttonLongPressed(_:)))
        button.addGestureRecognizer(gesture)
    }
    
    private func addTapGestureToButton(button: KeyboardButton) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        button.addGestureRecognizer(gesture)
    }
    
    private func alertMissingImplementation(functionName: String) {
        print("** WARNING! '\(functionName)\' is not implemented in your emoji keyboard **")
    }
    
    private func createEmojiButton(emoji: String) -> KeyboardButton {
        let imageName = keyboardImageNameForEmoji(emoji)
        let button = KeyboardButton.newWithEmoji(emoji, imageName: imageName)
        button.contentMode = .ScaleAspectFit
        button.imageView?.contentMode = .ScaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        addTapGestureToButton(button)
        addLongPressGestureToEmojiButton(button)
        styleKeyboardButton(button)
        return button
    }
    
    private func createPageControlInView(view: UIView, numberOfPages: Int) -> UIPageControl {
        let width = view.frame.width
        let height = view.frame.height
        let pageControl = UIPageControl(frame: CGRectMake(0, 0, width, height))
        pageControl.numberOfPages = numberOfPages
        pageControl.userInteractionEnabled = false
        view.addSubview(pageControl)
        stylePageControl(pageControl)
        return pageControl
    }
    
    private func createScrollViewInView(view: UIView) -> UIScrollView {
        let width = view.bounds.width
        let height = view.bounds.height
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, width, height))
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.contentInset = UIEdgeInsetsZero
        view.addSubview(scrollView)
        return scrollView
    }
    
    private func createSystemRowWithFrame(frame: CGRect) -> UIView {
        let row = UIView(frame: frame)
        styleSystemRow(row)

        let buttons = systemButtons
        for button in buttons {
            row.addSubview(button)
            styleSystemButton(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            addTapGestureToButton(button)
        }
        
        setupConstraintsForButtons(buttons, inRowView: row)
        
        return row
    }
    
    private func getIndexPathForRowNumber(rowNumber: Int) -> NSIndexPath {
        let row = rowNumber % rowsPerPage
        let section = rowNumber / rowsPerPage
        return NSIndexPath(forRow: row, inSection: section)
    }
    
    private func resetKeyboardInViewController(vc: UIInputViewController) {
        for subview in vc.view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    private func setupConstraintsForButtons(buttons: [UIButton], inRowView view: UIView) {
        for (index, button) in buttons.enumerate() {
            
            let top = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 1)
            
            let bottom = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -1)
            
            var left : NSLayoutConstraint!
            var right : NSLayoutConstraint!
            
            if index == 0 {
                left = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 1)
            } else {
                left = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: buttons[index-1], attribute: .Right, multiplier: 1.0, constant: 1)
                let width = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
                view.addConstraint(width)
            }
            
            if index == buttons.count - 1 {
                right = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: -1)
            } else {
                right = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: buttons[index+1], attribute: .Left, multiplier: 1.0, constant: -1)
            }
            
            view.addConstraints([top, bottom, right, left])
        }
    }
    
    
    
    // MARK: UIScrollViewDelegate
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let alert = pageControl.currentPage != scrollView.pageNumber
        pageControl.currentPage = scrollView.pageNumber
        if (alert) {
            delegate?.keyboardPageNumberDidChange(self)
        }
    }
}
