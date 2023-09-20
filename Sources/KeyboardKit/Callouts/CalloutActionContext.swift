//
//  CalloutContext+ActionContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Combine
import SwiftUI

/**
 This type can be used as action callout state.
 */
public class CalloutActionContext: ObservableObject {
    
    /**
     Create a new action callout context instance.
     
     - Parameters:
       - actionHandler: The action handler to use.
       - actionProvider: The action provider to use, if any.
     */
    public init(
        actionHandler: KeyboardActionHandler,
        actionProvider: CalloutActionProvider?
    ) {
        self.actionHandler = actionHandler
        self.actionProvider = actionProvider
    }
    
    
    /// The coordinate space to use for callout.
    public static let coordinateSpace = "com.keyboardkit.coordinate.ActionCallout"
    
    
    /// The action handler to use when tapping buttons.
    public let actionHandler: KeyboardActionHandler
    
    /// The action provider to use for resolving actions.
    public let actionProvider: CalloutActionProvider?
    
    
    /// The currently active actions.
    @Published
    public private(set) var actions: [KeyboardAction] = []
    
    /// The callout bubble alignment.
    @Published
    public private(set) var alignment: HorizontalAlignment = .leading
    
    /// The frame of the currently pressed button.
    @Published
    public private(set) var buttonFrame: CGRect = .zero
    
    /// The currently selected action index.
    @Published
    public private(set) var selectedIndex: Int = -1
}


// MARK: - Public functionality

public extension CalloutActionContext {
    
    /// Whether or not the context has a selected action.
    var hasSelectedAction: Bool { selectedAction != nil }
    
    /// Whether or not the context currently has actions.
    var isActive: Bool { !actions.isEmpty }
    
    /// Whether or not the action callout is leading.
    var isLeading: Bool { !isTrailing }
    
    /// Whether or not the action callout is trailing.
    var isTrailing: Bool { alignment == .trailing }
    
    /// The currently selected callout action, if any.
    var selectedAction: KeyboardAction? {
        isIndexValid(selectedIndex) ? actions[selectedIndex] : nil
    }
    
    
    /// End the drag gesture by commiting and resetting.
    func endDragGesture() {
        handleSelectedAction()
        reset()
    }
    
    /// Handle the currently selected action, if any.
    func handleSelectedAction() {
        guard let action = selectedAction else { return }
        actionHandler.handle(.release, on: action)
    }
    
    /// Reset the context. This will dismiss the callout.
    func reset() {
        actions = []
        selectedIndex = -1
        buttonFrame = .zero
    }
    
    /// Trigger haptic feedback for selection change.
    func triggerHapticFeedbackForSelectionChange() {
        HapticFeedback.selectionChanged.trigger()
    }
    
    /// Update the input actions for a certain action.
    func updateInputs(for action: KeyboardAction?, in geo: GeometryProxy, alignment: HorizontalAlignment? = nil) {
        guard let action = action else { return reset() }
        guard let actions = actionProvider?.calloutActions(for: action) else { return }
        self.buttonFrame = geo.frame(in: .named(Self.coordinateSpace))
        self.alignment = alignment ?? getAlignment(for: geo)
        self.actions = isLeading ? actions : actions.reversed()
        self.selectedIndex = startIndex
        guard isActive else { return }
        triggerHapticFeedbackForSelectionChange()
    }
    
    /// Update the selected action for a drag gesture.
    func updateSelection(with dragTranslation: CGSize?) {
        guard let value = dragTranslation, buttonFrame != .zero else { return }
        if shouldReset(for: value) { return reset() }
        guard shouldUpdateSelection(for: value) else { return }
        let translation = value.width
        let standardStyle = KeyboardStyle.ActionCallout.standard
        let maxButtonSize = standardStyle.maxButtonSize
        let buttonSize = buttonFrame.size.limited(to: maxButtonSize)
        let indexWidth = 0.9 * buttonSize.width
        let offset = Int(abs(translation) / indexWidth)
        let index = isLeading ? offset : actions.count - offset - 1
        let currentIndex = self.selectedIndex
        let newIndex = isIndexValid(index) ? index : startIndex
        if currentIndex != newIndex { triggerHapticFeedbackForSelectionChange() }
        self.selectedIndex = newIndex
    }
}


// MARK: - Context builders

public extension CalloutActionContext {
    
    /// This context can be used to disable action callouts.
    static var disabled: CalloutActionContext {
        .init(
            actionHandler: .preview,
            actionProvider: nil
        )
    }
}


// MARK: - Private functionality

private extension CalloutActionContext {
    
    var startIndex: Int {
        isLeading ? 0 : actions.count - 1
    }
    
    func isIndexValid(_ index: Int) -> Bool {
        index >= 0 && index < actions.count
    }
    
    func getAlignment(for geo: GeometryProxy) -> HorizontalAlignment {
        #if os(iOS)
        let center = UIScreen.main.bounds.size.width / 2
        let isTrailing = buttonFrame.origin.x > center
        return isTrailing ? .trailing : .leading
        #else
        return .leading
        #endif
    }
    
    func shouldReset(for dragTranslation: CGSize) -> Bool {
        dragTranslation.height > buttonFrame.height
    }
    
    func shouldUpdateSelection(for dragTranslation: CGSize) -> Bool {
        let translation = dragTranslation.width
        if translation == 0 { return true }
        return isLeading ? translation > 0 : translation < 0
    }
}
