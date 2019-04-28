//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 In the demo app, the keyboard will handle system actions as
 normal (e.g. change keyboard, space, new line etc.), inject
 plain string characters into the proxy and handle emojis by
 copying them on tap and saving them to photos on long press.
 
 IMPORTANT: To use this demo keyboard, you have to enable it
 in system settings ("Settings/General/Keyboards") then give
 it full access (this requires enabling `RequestsOpenAccess`
 in `Info.plist`) if you want to use image buttons. You must
 also add a `NSPhotoLibraryAddUsageDescription`  to the host
 app's `Info.plist` if you want to be able to save images to
 the photo album. This is already taken care of in this demo
 app, so you can just copy the setup.
 
 */

import UIKit
import KeyboardKit


class KeyboardView: KeyboardCollectionView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 500)
    }
}

class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    
    var keyboardView: KeyboardView!
    var view1: KeyboardButtonRowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridPresenter = DemoPresenter(id: "foo", viewController: self)

        
        view1 = KeyboardButtonRowView(rowHeight: 70)
        view1.backgroundColor = .green
        view1.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view1.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        keyboardStackView.addArrangedSubview(view1)

        keyboardView = KeyboardView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        keyboardView.backgroundColor = .yellow
        keyboardView.setContentHuggingPriority(.defaultLow, for: .vertical)
        keyboardView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        keyboardStackView.addArrangedSubview(keyboardView)
////
//        let view3 = KeyboardButtonRowView(rowHeight: 60)
//        view3.backgroundColor = .green
//        view3.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        view3.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
//        stackView.addArrangedSubview(view3)
//
//        view.addSubview(gridPresenter.collectionView)
//        gridPresenter.collectionView.backgroundColor = .yellow
//        gridPresenter.collectionView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
//        setupKeyboard(for: UIScreen.main.bounds.size)
//        setupSystemButtons()
//        keyboardActionHandler = DemoKeyboardActionHandler(inputViewController: self)
        
        
        
//        let expandedHeight = CGFloat(500)
//        let heightConstraint =
//            NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: expandedHeight)
//        stackView.addConstraint(heightConstraint)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//        setupKeyboard(for: size)
        view1.heightConstraint.constant = 20
    }
    
    override func viewWillSyncWithTextDocumentProxy() {
        super.viewWillSyncWithTextDocumentProxy()
//        let isDark = textDocumentProxy.keyboardAppearance == .dark
//        view.tintColor = isDark ? .white : .black
    }
    
    
    // MARK: - Setup
    
//    func setupGridPresenter() {
//        let view = gridPresenter.collectionView
//        view.contentInset.top = 5
//        view.contentInset.bottom = 10
//        view.register(DemoCell.defaultNib, forCellWithReuseIdentifier: "Cell")
//    }
//    
//    func setupKeyboard(for size: CGSize) {
//        let isLandscape = size.width > 400
//        let height: CGFloat = isLandscape ? 150 : 200
//        let rowsPerPage = isLandscape ? 3 : 4
//        let buttonsPerRow = isLandscape ? 8 : 6
//        gridPresenter.setup(withHeight: height, rowsPerPage: rowsPerPage, buttonsPerRow: buttonsPerRow)
//    }
//    
//    func setupSystemButtons() {
//        setupLeftSystemButtons()
//        setupRightSystemButtons()
//    }
//    
//    func setupLeftSystemButtons() {
//        gridPresenter.leftSystemButtons = [
//            gridPresenter.createSystemButton(image: Asset.globe.image, action: .nextKeyboard),
//            gridPresenter.createSystemButton(image: Asset.space.image, action: .space)
//            ].compactMap { $0 }
//    }
//    
//    func setupRightSystemButtons() {
//        gridPresenter.rightSystemButtons = [
//            gridPresenter.createSystemButton(image: Asset.backspace.image, action: .backspace),
//            gridPresenter.createSystemButton(image: Asset.newline.image, action: .newLine)
//            ].compactMap { $0 }
//    }
    
    
    // MARK: - Properties
    
    var alerter = ToastAlert()
    
    var gridPresenter: GridKeyboardPresenter!
    
    
    // MARK: - Layout
    
    /*override func layoutSystemButtons(_ buttons: [UIView], buttonSize: CGSize, startX: CGFloat, y: CGFloat) {
        super.layoutSystemButtons(buttons, buttonSize: buttonSize, startX: startX, y: y)
        buttons.forEach {
            let center = $0.center
            $0.frame.size = CGSize(width: 25, height: 25)
            $0.center = center
        }
    }*/
    
    
    // MARK: - UICollectionViewDataSource
    
//    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//        guard
//            let action = keyboardAction(at: indexPath),
//            let buttonCell = cell as? DemoCell
//            else { return cell }
//        buttonCell.setup(with: action, appearance: keyboardAppearance, tintColor: collectionView.tintColor)
//        addLongPressGesture(for: action, to: buttonCell)
//        return cell
//    }
}


// MARK: - Private Functions

extension KeyboardViewController {
    
    func image(for action: KeyboardAction) -> UIImage? {
        switch action {
        case .image(_, _, let imageName): return UIImage(named: imageName)
        default: return nil
        }
    }
}


class DemoPresenter: GridKeyboardPresenter {
    
//    public override init(id: String? = nil, viewController: KeyboardKit.KeyboardViewController) {
//        super.init(id: id, viewController: viewController)
//        setupPageControl()
//    }
//
//    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//        guard
//            let action = keyboardAction(at: indexPath),
//            let buttonCell = cell as? DemoCell
//            else { return cell }
//        let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .light
//        buttonCell.setup(with: action, appearance: appearance, tintColor: viewController.view.tintColor)
//        viewController.addLongPressGesture(for: action, to: buttonCell)
//        return cell
//    }
}
