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
 
 TODO: Remove this need of overriding. Instead, extract
 these parts to a new EmojiKeyboard protocol and rename
 this class to EmojiKeyboardBase. Then, make any custom
 emoji keyboards implement EmojiKeyboard.
 
 */


import UIKit


open class EmojiKeyboard: NSObject, Keyboard, UIScrollViewDelegate {
    
    
    // MARK: - Init
    
    public init(emojis: [String], rowsPerPage: Int, emojisPerRow: Int) {
        self.emojis = emojis
        self.rowsPerPage = rowsPerPage
        self.emojisPerRow = emojisPerRow
        super.init()
    }
    
    
    
    // MARK: - Properties
    
    open weak var delegate: KeyboardDelegate?
    
    open var emojis: [String]
    
    open var pageNumber: Int {
        get { return scrollView.pageNumber }
        set { scrollView.pageNumber = newValue }
    }
    
    open var systemButtons: [KeyboardButton] {
        alertMissingImplementation("systemButtons")
        return [KeyboardButton]()
    }
    
    fileprivate var rowsPerPage: Int
    fileprivate var emojisPerRow: Int
    
    fileprivate var pageControl: UIPageControl!
    fileprivate var scrollView: UIScrollView!
    
    
    
    // MARK: - Actions
    
    func buttonLongPressed(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        guard let button = gesture.view as? KeyboardButton else { return }
        delegate?.keyboard(self, buttonLongPressed: button)
    }
    
    func buttonTapped(_ gesture: UITapGestureRecognizer) {
        guard let button = gesture.view as? KeyboardButton else { return }
        delegate?.keyboard(self, buttonTapped: button)
    }
    
    
    
    // MARK: - Public functions
    
    open func keyboardImageName(forEmoji emoji: String) -> String {
        alertMissingImplementation("keyboardImageNameForEmoji(...)")
        return emoji
    }
    
    open func setupKeyboard(in vc: UIInputViewController) {
        resetKeyboard(in: vc)
        
        let view = UIView(frame: vc.view.frame)
        let width = view.bounds.width
        let height = view.bounds.height
        let rowHeight = height / CGFloat(rowsPerPage + 1)
        let rows = batch(array: emojis, inGroupsWithSize: emojisPerRow)
        
        vc.view.subviews.forEach { view in view.removeFromSuperview() }
        vc.view.addSubview(view)
        
        scrollView = createScrollView(in: view)
        
        var lastIndexPath: IndexPath?
        
        for (index, emojis) in rows.enumerated() {
            let buttons = emojis.map { createButton(forEmoji: $0) }
            let indexPath = getIndexPath(for: index)
            lastIndexPath = indexPath
            let x = CGFloat(indexPath.section) * width
            let y = CGFloat(indexPath.row) * rowHeight
            let row = UIView(frame: CGRect(x: x, y: y, width: width, height: rowHeight))
            buttons.forEach { row.addSubview($0) }
            setupConstraints(forButtons: buttons, inRowView: row)
            scrollView.addSubview(row)
        }
        
        let systemFrame = CGRect(x: 0, y: 3*rowHeight, width: width, height: rowHeight)
        let systemRow = createSystemRow(with: systemFrame)
        view.addSubview(systemRow)
        
        let numberOfPages = (lastIndexPath?.section ?? 0) + 1
        scrollView.contentSize = CGSize(width: CGFloat(numberOfPages) * width, height: height)
        pageControl = createPageControl(in: systemRow, numberOfPages: numberOfPages)
        
        style(containerView: view)
        style(inputViewController: vc)
    }
    
    open func style(containerView view: UIView) {
        alertMissingImplementation("styleContainerView(...)")
    }
    
    open func style(inputViewController vc: UIInputViewController) {
        alertMissingImplementation("styleInputViewController(...)")
    }
    
    open func style(keyboardButton button: KeyboardButton) {
        alertMissingImplementation("styleKeyboardButton(...)")
    }
    
    open func style(pageControl pageControl: UIPageControl) {
        alertMissingImplementation("stylePageControl(...)")
    }
    
    open func style(systemButton button: KeyboardButton) {
        alertMissingImplementation("styleSystemButton(...)")
    }
    
    open func style(systemRow row: UIView) {
        alertMissingImplementation("styleSystemRow(...)")
    }
    
    

    // MARK: - Private functions
    
    fileprivate func addLongPressGesture(to button: KeyboardButton) {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(buttonLongPressed(_:)))
        button.addGestureRecognizer(gesture)
    }
    
    fileprivate func addTapGesture(to button: KeyboardButton) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        button.addGestureRecognizer(gesture)
    }
    
    fileprivate func alertMissingImplementation(_ functionName: String) {
        print("** WARNING! '\(functionName)\' is not implemented in your emoji keyboard **")
    }
    
    fileprivate func createButton(forEmoji emoji: String) -> KeyboardButton {
        let imageName = keyboardImageName(forEmoji: emoji)
        let button = KeyboardButton.new(withEmoji: emoji, imageName: imageName)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        addTapGesture(to: button)
        addLongPressGesture(to: button)
        style(keyboardButton: button)
        return button
    }
    
    fileprivate func createPageControl(in view: UIView, numberOfPages: Int) -> UIPageControl {
        let width = view.frame.width
        let height = view.frame.height
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: width, height: height))
        pageControl.numberOfPages = numberOfPages
        pageControl.isUserInteractionEnabled = false
        view.addSubview(pageControl)
        style(pageControl: pageControl)
        return pageControl
    }
    
    fileprivate func createScrollView(in view: UIView) -> UIScrollView {
        let width = view.bounds.width
        let height = view.bounds.height
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentInset = UIEdgeInsets.zero
        view.addSubview(scrollView)
        return scrollView
    }
    
    fileprivate func createSystemRow(with frame: CGRect) -> UIView {
        let row = UIView(frame: frame)
        style(systemRow: row)

        let buttons = systemButtons
        for button in buttons {
            row.addSubview(button)
            style(systemButton: button)
            button.translatesAutoresizingMaskIntoConstraints = false
            addTapGesture(to: button)
        }
        
        setupConstraints(forButtons: buttons, inRowView: row)
        
        return row
    }
    
    fileprivate func getIndexPath(for rowNumber: Int) -> IndexPath {
        let row = rowNumber % rowsPerPage
        let section = rowNumber / rowsPerPage
        return IndexPath(row: row, section: section)
    }
    
    fileprivate func resetKeyboard(in vc: UIInputViewController) {
        for subview in vc.view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    fileprivate func setupConstraints(forButtons buttons: [UIButton], inRowView view: UIView) {
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
    
    
    
    // MARK: - UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alert = pageControl.currentPage != scrollView.pageNumber
        pageControl.currentPage = scrollView.pageNumber
        if (alert) {
            delegate?.keyboardDidChangePageNumber(self)
        }
    }
}
