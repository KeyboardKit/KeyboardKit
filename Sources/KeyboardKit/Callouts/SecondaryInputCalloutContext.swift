//
//  SecondaryInputCalloutContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This context can be used to control secondary input callout
 views that can show secondary actions for a keyboard action.
 
 The context will automatically dismiss itself when the user
 ends the secondary gesture or drags too far down.
  
 You can inherit this class and override any `open` function
 to modify the callout behavior.
 */
open class SecondaryInputCalloutContext: ObservableObject {
    
    
    // MARK: - Initialization
    
    public init(
        actionProvider: SecondaryCalloutActionProvider,
        actionHandler: KeyboardActionHandler) {
        self.actionProvider = actionProvider
        self.actionHandler = actionHandler
    }
    
    
    // MARK: - Dependencies
    
    public let actionHandler: KeyboardActionHandler
    public let actionProvider: SecondaryCalloutActionProvider
    
    
    // MARK: - Properties
    
    static let coordinateSpace = "com.keyboardkit.coordinate.SecondaryInputCallout"
    
    public var isActive: Bool { !actions.isEmpty }
    public var isLeading: Bool { !isTrailing }
    public var isTrailing: Bool { alignment.horizontal == .trailing }
    public var selectedAction: KeyboardAction? { isIndexValid(selectedIndex) ? actions[selectedIndex] : nil }
    
    @Published private(set) var actions: [KeyboardAction] = []
    @Published private(set) var alignment: Alignment = .leading
    @Published private(set) var buttonFrame: CGRect = .zero
    @Published private(set) var selectedIndex: Int = -1
    
    
    // MARK: - Functions
    
    /**
     The visible button frame for the button view's geometry
     proxy. You can apply an inset by subclassing this class
     or adjusting the style.
     */
    open func buttonFrame(for geo: GeometryProxy) -> CGRect {
        geo.frame(in: .named(Self.coordinateSpace))
    }
    
    /**
     Handle the end of a secondary input drag gesture, which
     should commit the selected action and reset the context.
     */
    open func endDragGesture() {
        handleSelectedAction()
        reset()
    }
    
    /**
     Handle the selected action, if any. By default, it will
     be handled by the context's action handler.
     */
    open func handleSelectedAction() {
        guard let action = selectedAction else { return }
        actionHandler.handle(.tap, on: action, sender: nil)
    }
    
    /**
     Reset the context, which will reset all state and cause
     any callouts to dismiss.
     */
    open func reset() {
        actions = []
        selectedIndex = -1
        buttonFrame = .zero
    }
    
    /**
     Trigger a haptic feedback for selection change. You can
     override this to change or disable the haptic feedback.
     */
    open func triggerHapticFeedbackForSelectionChange() {
        HapticFeedback.selectionChanged.trigger()
    }
    
    /**
     Update the input actions for a certain keyboard action.
     */
    open func updateInputs(for action: KeyboardAction?, geo: GeometryProxy, alignment: Alignment? = nil) {
        guard let action = action else { return reset() }
        let actions = actionProvider.secondaryCalloutActions(for: action)
        self.buttonFrame = self.buttonFrame(for: geo)
        self.alignment = alignment ?? getAlignment(for: geo)
        self.actions = isLeading ? actions : actions.reversed()
        self.selectedIndex = startIndex
        guard isActive else { return }
        triggerHapticFeedbackForSelectionChange()
    }
    
    /**
     Update the selected input action when a drag gesture is
     changed by a drag gesture.
     */
    open func updateSelection(with dragValue: DragGesture.Value?) {
        guard let value = dragValue, buttonFrame != .zero else { return }
        if shouldReset(for: value) { return reset() }
        guard shouldUpdateSelection(with: value) else { return }
        let translation = value.translation.width
        let buttonWidth = buttonFrame.size.width
        let offset = Int(abs(translation) / buttonWidth)
        let index = isLeading ? offset : actions.count - offset - 1
        let currentIndex = self.selectedIndex
        let newIndex = isIndexValid(index) ? index : startIndex
        if currentIndex != newIndex { triggerHapticFeedbackForSelectionChange() }
        self.selectedIndex = newIndex
    }
}


// MARK: - Private functionality

private extension SecondaryInputCalloutContext {
    
    var startIndex: Int {
        isLeading ? 0 : actions.count - 1
    }
    
    func isIndexValid(_ index: Int) -> Bool {
        index >= 0 && index < actions.count
    }
    
    func getAlignment(for geo: GeometryProxy) -> Alignment {
        let center = UIScreen.main.bounds.size.width / 2
        let isTrailing = buttonFrame.origin.x > center
        return isTrailing ? .trailing : .leading
    }
    
    func shouldReset(for dragValue: DragGesture.Value) -> Bool {
        dragValue.translation.height > buttonFrame.height
    }
    
    func shouldUpdateSelection(with dragValue: DragGesture.Value) -> Bool {
        let translation = dragValue.translation.width
        if translation == 0 { return true }
        return isLeading ? translation > 0 : translation < 0
    }
}
