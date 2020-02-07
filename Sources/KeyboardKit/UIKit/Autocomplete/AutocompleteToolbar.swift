//
//  AutocompleteToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import UIKit

/**
 This toolbar can be used to present autocomplete suggestion
 to the user while she/he types into a text field.
 
 The toolbar is updated by calling `update(with: words)`. It
 resets the toolbar and populates it with new buttons, which
 are provided by the provided `buttonCreator`.
 
 The toolbar will by default distribute all suggestion views
 evenly within its available space. However, you can make it
 scrollable by calling `enableScrolling()`. This gives every
 suggestion view as much space as it needs and makes the bar
 scroll if needed. Call `disableScrolling()` to disable this
 behavior once again.
 
 Since this is a `KeyboardToolbar`, it has a stack view that
 you can configure in any way you like.
 
 Since the `buttonCreator` can provide any kind of views for
 any strings, you are not limited buttons. A toolbar can use
 views, buttons, separators etc.
 */
public class AutocompleteToolbar: KeyboardToolbar {

    
    // MARK: - Initialization

    /**
     Create a toolbar that uses a custom button creator. You
     must setup the buttons yourself if you use this option.
     */
    public init(
        height: CGFloat = .standardKeyboardRowHeight,
        buttonCreator: @escaping ButtonCreator,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        self.buttonCreator = buttonCreator
        super.init(height: height, alignment: alignment, distribution: distribution)
        stackView.spacing = 0
    }
    
    /**
     Create a toolbar that uses an `AutocompleteToolbarLabel`
     that when tapped sends text to a `UITextDocumentProxy`.
     */
    public convenience init(
        height: CGFloat = .standardKeyboardRowHeight,
        textDocumentProxy: UITextDocumentProxy,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        self.init(
            height: height,
            buttonCreator: { AutocompleteToolbarLabel(
                text: $0,
                textDocumentProxy: textDocumentProxy) },
            alignment: alignment,
            distribution: distribution
        )
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Types
    
    public typealias ButtonCreator = (String) -> (UIView)

    
    // MARK: - Properties
    
    private let buttonCreator: ButtonCreator
    
    private var scrollView: UIScrollView?
    
    private var suggestions: [String] = [] {
        didSet {
            if oldValue == suggestions { return }
            let buttons = suggestions.map { buttonCreator($0) }
            stackView.removeAllArrangedSubviews()
            stackView.addArrangedSubviews(buttons)
            tempAdjustLastSeparator(in: buttons)
        }
    }
    
    
    // MARK: - Functions
    
    /**
     Disable scrolling and make the stackview distribute its
     content evenly.
     */
    public func disableScrolling() {
        guard let scrollView = self.scrollView else { return }
        stackView.removeFromSuperview()
        scrollView.removeFromSuperview()
        stackView.removeAllConstraints()
        addSubview(stackView, fill: true)
    }
    
    /**
     Enable scrolling and make the entire toolbar scroll, if
     its content takes up too much space.
     */
    public func enableScrolling() {
        guard self.scrollView == nil else { return }
        let scrollView = UIScrollView(frame: .zero)
        addSubview(scrollView, fill: true)
        stackView.removeAllConstraints()
        scrollView.addSubview(stackView, fill: true)
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        self.scrollView = scrollView
    }
    
    
    /**
     Reset the toolbar by removing all suggestions.
     */
    public func reset() {
        update(with: [])
    }
    
    /**
     Update the toolbar with new suggestions.
     
     This will remove all views from the stack view and then
     create new views for the new suggestions.
     */
    public func update(with suggestions: [String]) {
        self.suggestions = suggestions
    }
}


// MARK: - Temporary Fixes

private extension AutocompleteToolbar {
    
    /**
     Adjust the last suggestion view, removing its separator
     if it has one.
     
     `TODO` Remove this when we have a better separator view
     handling in the stack view.
     */
    func tempAdjustLastSeparator(in views: [UIView]) {
        guard let view = views.last as? AutocompleteToolbarLabel else { return }
        view.separator.hide()
    }
}
