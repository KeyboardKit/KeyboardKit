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


open class EmojiKeyboard: NSObject, Keyboard, UIScrollViewDelegate {
    
    
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
    
    open weak var delegate: KeyboardDelegate?
    
    open var emojis: [String] {
        alertMissingImplementation("emojis")
        return [String]()
    }
    
    open var pageNumber: Int {
        get { return scrollView.pageNumber }
        set { scrollView.pageNumber = newValue }
    }
    
    open var systemButtons: [KeyboardButton] {
        alertMissingImplementation("systemButtons")
        return [KeyboardButton]()
    }
    
    fileprivate var rowsPerPage = 3
    fileprivate var emojisPerRow = 6
    
    fileprivate var pageControl: UIPageControl!
    fileprivate var scrollView: UIScrollView!
    
    
    
    // MARK: Actions
    
    open func buttonLongPressed(_ gesture: UILongPressGestureRecognizer) {
        if (gesture.state == .began) {
            if let button = gesture.view as? KeyboardButton {
                delegate?.keyboard(self, buttonLongPressed: button)
            }
        }
    }
    
    open func buttonTapped(_ gesture: UITapGestureRecognizer) {
        if let button = gesture.view as? KeyboardButton {
            delegate?.keyboard(self, buttonTapped: button)
        }
    }
    
    
    
    // MARK: Public functions
    
    open func keyboardImageNameForEmoji(_ emoji: String) -> String {
        alertMissingImplementation("keyboardImageNameForEmoji(...)")
        return emoji
    }
    
    open func setupKeyboardInViewController(_ vc: UIInputViewController) {
        resetKeyboardInViewController(vc)
        
        vc.view.subviews.forEach { view in view.removeFromSuperview() }
        
        let view = UIView(frame: vc.view.frame)
        vc.view.addSubview(view)
        
        let width = view.bounds.width
        let height = view.bounds.height
        let rowHeight = height / CGFloat(rowsPerPage + 1)
        let rows = batch(array: emojis, inGroupsWithSize: emojisPerRow)
        
        scrollView = createScrollViewInView(view)
        
        var lastIndexPath: IndexPath?
        
        for (index, emojis) in rows.enumerated() {
            let buttons = emojis.map { createEmojiButton($0) }
            let indexPath = getIndexPathForRowNumber(index)
            lastIndexPath = indexPath
            let x = CGFloat((indexPath as NSIndexPath).section) * width
            let y = CGFloat((indexPath as NSIndexPath).row) * rowHeight
            let row = UIView(frame: CGRect(x: x, y: y, width: width, height: rowHeight))
            for button in buttons {
                row.addSubview(button)
            }
            setupConstraintsForButtons(buttons, inRowView: row)
            scrollView.addSubview(row)
        }
        
        let systemRow = createSystemRowWithFrame(CGRect(x: 0, y: 3*rowHeight, width: width, height: rowHeight))
        view.addSubview(systemRow)
        
        let numberOfPages = ((lastIndexPath as NSIndexPath?)?.section ?? 0) + 1
        scrollView.contentSize = CGSize(width: CGFloat(numberOfPages) * width, height: height)
        pageControl = createPageControlInView(systemRow, numberOfPages: numberOfPages)
        
        styleContainerView(view)
        styleInputViewController(vc)
    }
    
    open func styleContainerView(_ view: UIView) {
        alertMissingImplementation("styleContainerView(...)")
    }
    
    open func styleInputViewController(_ vc: UIInputViewController) {
        alertMissingImplementation("styleInputViewController(...)")
    }
    
    open func styleKeyboardButton(_ button: KeyboardButton) {
        alertMissingImplementation("styleKeyboardButton(...)")
    }
    
    open func stylePageControl(_ pageControl: UIPageControl) {
        alertMissingImplementation("stylePageControl(...)")
    }
    
    open func styleSystemButton(_ button: KeyboardButton) {
        alertMissingImplementation("styleSystemButton(...)")
    }
    
    open func styleSystemRow(_ row: UIView) {
        alertMissingImplementation("styleSystemRow(...)")
    }
    
    

    // MARK: Private functions
    
    fileprivate func addLongPressGestureToEmojiButton(_ button: KeyboardButton) {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(buttonLongPressed(_:)))
        button.addGestureRecognizer(gesture)
    }
    
    fileprivate func addTapGestureToButton(_ button: KeyboardButton) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        button.addGestureRecognizer(gesture)
    }
    
    fileprivate func alertMissingImplementation(_ functionName: String) {
        print("** WARNING! '\(functionName)\' is not implemented in your emoji keyboard **")
    }
    
    fileprivate func createEmojiButton(_ emoji: String) -> KeyboardButton {
        let imageName = keyboardImageNameForEmoji(emoji)
        let button = KeyboardButton.newWithEmoji(emoji, imageName: imageName)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        addTapGestureToButton(button)
        addLongPressGestureToEmojiButton(button)
        styleKeyboardButton(button)
        return button
    }
    
    fileprivate func createPageControlInView(_ view: UIView, numberOfPages: Int) -> UIPageControl {
        let width = view.frame.width
        let height = view.frame.height
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: width, height: height))
        pageControl.numberOfPages = numberOfPages
        pageControl.isUserInteractionEnabled = false
        view.addSubview(pageControl)
        stylePageControl(pageControl)
        return pageControl
    }
    
    fileprivate func createScrollViewInView(_ view: UIView) -> UIScrollView {
        let width = view.bounds.width
        let height = view.bounds.height
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentInset = UIEdgeInsets.zero
        view.addSubview(scrollView)
        return scrollView
    }
    
    fileprivate func createSystemRowWithFrame(_ frame: CGRect) -> UIView {
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
    
    fileprivate func getIndexPathForRowNumber(_ rowNumber: Int) -> IndexPath {
        let row = rowNumber % rowsPerPage
        let section = rowNumber / rowsPerPage
        return IndexPath(row: row, section: section)
    }
    
    fileprivate func resetKeyboardInViewController(_ vc: UIInputViewController) {
        for subview in vc.view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    fileprivate func setupConstraintsForButtons(_ buttons: [UIButton], inRowView view: UIView) {
        for (index, button) in buttons.enumerated() {
            
            let top = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 1)
            
            let bottom = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -1)
            
            var left : NSLayoutConstraint!
            var right : NSLayoutConstraint!
            
            if index == 0 {
                left = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 1)
            } else {
                left = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: buttons[index-1], attribute: .right, multiplier: 1.0, constant: 1)
                let width = NSLayoutConstraint(item: buttons[0], attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
                view.addConstraint(width)
            }
            
            if index == buttons.count - 1 {
                right = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -1)
            } else {
                right = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: buttons[index+1], attribute: .left, multiplier: 1.0, constant: -1)
            }
            
            view.addConstraints([top, bottom, right, left])
        }
    }
    
    
    
    // MARK: UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alert = pageControl.currentPage != scrollView.pageNumber
        pageControl.currentPage = scrollView.pageNumber
        if (alert) {
            delegate?.keyboardPageNumberDidChange(self)
        }
    }
}
