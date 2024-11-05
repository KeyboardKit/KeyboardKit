//
//  CalloutContext+ActionContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Combine
import SwiftUI

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use CalloutContext instead.")
public extension CalloutContext {

    class ActionContext: ObservableObject {

        public init(
            service: CalloutService?,
            tapAction: @escaping (KeyboardAction) -> Void
        ) {
            self.service = service
            self.tapAction = tapAction
        }

        public let coordinateSpace = "com.keyboardkit.coordinate.ActionCallout"

        public var service: CalloutService?

        public var tapAction: (KeyboardAction) -> Void

        @Published
        public private(set) var actions: [KeyboardAction] = []

        @Published
        public private(set) var alignment: HorizontalAlignment = .leading

        @Published
        public private(set) var buttonFrame: CGRect = .zero

        @Published
        public private(set) var selectedIndex: Int = -1
    }
}


@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use CalloutContext instead.")
public extension CalloutContext.ActionContext {

    var hasSelectedAction: Bool { selectedAction != nil }

    var isActive: Bool { !actions.isEmpty }

    var isLeading: Bool { !isTrailing }

    var isTrailing: Bool { alignment == .trailing }

    var selectedAction: KeyboardAction? {
        isIndexValid(selectedIndex) ? actions[selectedIndex] : nil
    }

    @discardableResult
    func handleSelectedAction() -> Bool {
        guard let action = selectedAction else { return false }
        tapAction(action)
        reset()
        return true
    }

    func reset() {
        actions = []
        selectedIndex = -1
        buttonFrame = .zero
    }

    func triggerHapticFeedbackForSelectionChange() {
        service?.triggerFeedbackForSelectionChange()
    }

    func updateInputs(for action: KeyboardAction?, in geo: GeometryProxy, alignment: HorizontalAlignment? = nil) {
        guard let action = action else { return reset() }
        guard let actions = service?.calloutActions(for: action) else { return }
        self.buttonFrame = geo.frame(in: .named(coordinateSpace))
        self.alignment = alignment ?? getAlignment(for: geo)
        self.actions = isLeading ? actions : actions.reversed()
        self.selectedIndex = startIndex
        guard isActive else { return }
        triggerHapticFeedbackForSelectionChange()
    }

    func updateSelection(with dragTranslation: CGSize?) {
        guard let value = dragTranslation, buttonFrame != .zero else { return }
        if shouldReset(for: value) { return reset() }
        guard shouldUpdateSelection(for: value) else { return }
        let translation = value.width
        let maxSize = Callouts.CalloutStyle.standard.actionItemMaxSize
        let buttonSize = buttonFrame.size.limited(to: maxSize)
        let indexWidth = 0.9 * buttonSize.width
        let offset = Int(abs(translation) / indexWidth)
        let index = isLeading ? offset : actions.count - offset - 1
        let currentIndex = self.selectedIndex
        let newIndex = isIndexValid(index) ? index : startIndex
        if currentIndex != newIndex { triggerHapticFeedbackForSelectionChange() }
        self.selectedIndex = newIndex
    }
}


@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use CalloutContext instead.")
public extension CalloutContext.ActionContext {

    static var disabled: CalloutContext.ActionContext {
        .init(
            service: nil,
            tapAction: { _ in }
        )
    }

    static var preview: CalloutContext.ActionContext {
        CalloutContext.ActionContext(
            service: .preview,
            tapAction: { _ in }
        )
    }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use CalloutContext instead.")
private extension CalloutContext.ActionContext {

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
