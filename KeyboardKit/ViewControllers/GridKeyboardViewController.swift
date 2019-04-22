//
//  GridKeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This input view controller will layout the keyboard buttons
 in a horizontally scrolling grid. If there are more buttons
 than fit the screen, it will display a page indicator.
 
 This class is a good fit with emoji keyboards, since emojis
 are often evenly distributed with the same button size. You
 can modify the default grid presentation by subclassing the
 class and add your own behavior to the collection view.
 
 Note that you must register and dequeue your own collection
 view cells. This class has no built-in logic for doing this,
 to give you the full freedom to use whatever cells you want.
 
 To get the keyboard action at a certain index path, use the
 `action(at:)` function. It handles for the way a collection
 view distributes horizontally flowing cells, and calculates
 a correct source index. This is, however, just a workaround
 until we implement a correctly behaving horizontal layout.
 
 The `reloadData` in `viewWillAppear` is temp needed for now.
 It fixes a rendering bug in the collection view. Without it,
 the last four bottom-right buttons shows in incorrect order,
 but a log shows that everything is correctly setup. I guess
 it has to be caused by something in the collection view.
 
 If you want this view controller to automatically setup the
 keyboard switcher button, just set `keyboardSwitcherButton`
 to any custom button. It will be given the same size as the
 rest of the buttons, and will be placed bottom-left.
 
 This view controller supports top and bottom insets for the
 collection view, which means that you can support the space
 to the top and bottom edge. Left and right insets currently
 don't currently work.
 
 NOTE: For now, this class contains a bunch of logic that is
 probably to be shared among all keyboards. Whenever we find
 a good way to do this, let's create magic.
 
 */

import UIKit

open class GridKeyboardViewController: CollectionKeyboardViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutPageControl()
        layoutKeyboardButtons()
        layoutSystemButtons()
        restoreCurrentPageIndex()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        restoreCurrentPageIndex()
    }
    
    
    // MARK: - View Properties
    
    open var leftSystemButtons: [UIButton] = [] {
        didSet { oldValue.forEach { $0.removeFromSuperview() } }
    }
    
    open lazy var pageControl = UIPageControl(frame: .zero)
    
    open var rightSystemButtons: [UIButton] = [] {
        didSet { oldValue.forEach { $0.removeFromSuperview() } }
    }
    
    
    // MARK: - Properties
    
    public var gridLayout = GridKeyboardLayout(rowsPerPage: 3, buttonsPerRow: 6) {
        didSet { collectionViewLayout = gridLayout }
    }
    
    public var hasMultiplePages: Bool {
        return keyboardPages.count > 1
    }
    
    public var hasSystemButtons: Bool {
        return leftSystemButtons.count + rightSystemButtons.count > 0
    }
    
    public var keyboardButtonsPerPage: Int {
        return gridLayout.rowsPerPage * gridLayout.buttonsPerRow
    }
    
    public private(set) var keyboardPages: [[KeyboardAction]] = [[]] {
        didSet { pageControl.numberOfPages = keyboardPages.count }
    }
    
    open var needsSystemButtons: Bool {
        return needsInputModeSwitchKey || hasSystemButtons || hasMultiplePages
    }
    
    open var systemAreaHeight: CGFloat {
        let itemHeight = collectionViewLayout.itemSize.height
        return needsSystemButtons ? itemHeight : 0
    }
    
    
    // MARK: - Setup
    
    open func setup(withKeyboard keyboard: Keyboard, height: CGFloat, rowsPerPage: Int, buttonsPerRow: Int) {
        gridLayout = GridKeyboardLayout(rowsPerPage: rowsPerPage, buttonsPerRow: buttonsPerRow)
        self.keyboard = keyboard
        setupKeyboardButtons(from: keyboard)
        setHeight(to: height)
    }
    
    open func setupPageControl() {
        view.insertSubview(pageControl, belowSubview: collectionView)
        pageControl.isUserInteractionEnabled = false
    }
    
    open func setupSystemButtonGesture(for button: UIButton, action: KeyboardAction) {
        switch action {
        case .nextKeyboard:
            button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        default:
            button.addTapGestureRecognizer { [weak self] in self?.handleTap(on: action) }
            button.addLongPressGestureRecognizer { [weak self] in self?.handleLongPress(on: action) }
        }
    }
    
    
    // MARK: - Layout
    
    open func layoutKeyboardButtons() {
        gridLayout.adjustButtonSize(for: collectionView)
        collectionView.layoutIfNeeded()
    }
    
    open func layoutSystemButtons() {
        let buttonSize = gridLayout.itemSize
        layoutLeftSystemButtons(buttonSize: buttonSize)
        layoutRightSystemButtons(buttonSize: buttonSize)
    }
    
    open func layoutLeftSystemButtons(buttonSize: CGSize) {
        let x = collectionView.frame.origin.x
        let y = collectionView.frame.maxY
        layoutSystemButtons(leftSystemButtons, buttonSize: buttonSize, startX: x, y: y)
    }
    
    open func layoutRightSystemButtons(buttonSize: CGSize) {
        let buttonCount = CGFloat(rightSystemButtons.count)
        let x = collectionView.frame.maxX - buttonCount * buttonSize.width
        let y = collectionView.frame.maxY
        layoutSystemButtons(rightSystemButtons, buttonSize: buttonSize, startX: x, y: y)
    }
    
    open func layoutSystemButtons(_ buttons: [UIView], buttonSize: CGSize, startX: CGFloat, y: CGFloat) {
        var x = startX
        buttons.forEach {
            view.addSubview($0)
            $0.frame.size = buttonSize
            $0.frame.origin.x = x
            $0.frame.origin.y = y
            x += buttonSize.width
        }
    }
    
    open func layoutPageControl() {
        pageControl.frame.size.height = gridLayout.itemSize.height
        pageControl.center = collectionView.center
        pageControl.frame.origin.y = collectionView.frame.maxY
    }
    
    
    // MARK: - Public Functions
    
    open override func action(at indexPath: IndexPath) -> KeyboardAction? {
        let indexPath = gridLayout.sourceIndexPathForItem(at: indexPath)
        let section = indexPath.section
        let row = indexPath.row
        guard keyboardPages.count > section else { return nil }
        let buttons = keyboardPages[section]
        guard buttons.count > row else { return nil }
        return buttons[row]
    }
    
    open func createSystemButton(image: UIImage?, action: KeyboardAction) -> UIButton? {
        if action == .nextKeyboard && !needsInputModeSwitchKey { return nil }
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        setupSystemButtonGesture(for: button, action: action)
        return button
    }
    
    open override func setHeight(to height: CGFloat) {
        super.setHeight(to: height + systemAreaHeight)
        collectionViewHeightAnchorConstraint?.constant = height
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keyboardPages.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboardPages[section].count
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.currentPageIndex)
        let key = KeyboardSetting.currentPageIndex
        let defaults = UserDefaults.standard
        defaults.set(index, forKey: key.key)
        defaults.synchronize()
        pageControl.currentPage = index
    }
}


// MARK: - Private Functions

private extension GridKeyboardViewController {
    
    func setupKeyboardButtons(from keyboard: Keyboard) {
        let pageSize = keyboardButtonsPerPage
        var buttons = keyboard.actions
        while buttons.count % pageSize > 0 {
            buttons.append( .none)
        }
        keyboardPages = buttons.batched(withBatchSize: pageSize)
        collectionView.reloadData()
    }
    
    func restoreCurrentPageIndex() {
        if collectionView.isDragging { return }
        let defaults = UserDefaults.standard
        let key = KeyboardSetting.currentPageIndex.key(for: self)
        let maxPageIndex = pageControl.numberOfPages - 1
        let index = defaults.integer(forKey: key).limit(min: 0, max: maxPageIndex)
        collectionView.currentPageIndex = index
        pageControl.currentPage = index
    }
}
