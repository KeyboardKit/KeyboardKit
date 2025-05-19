//
//  KeyboardViewItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view renders button item for a ``KeyboardView``.
///
/// Unlike ``Keyboard/Button`` this view applies more insets
/// and configurations to make it work in a ``KeyboardView``.
///
/// You can style the component with the style view modifier
/// ``keyboardButtonStyle(builder:)``.
public struct KeyboardViewItem<Content: View>: View, KeyboardButtonStyleResolver {

    /// Create a keyboard view item.
    ///
    /// - Parameters:
    ///   - item: The layout item to use within the item.
    ///   - actionHandler: The button style to apply.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - styleService: The style service to use.
    ///   - keyboardContext: The keyboard context to which the item should apply.,
    ///   - calloutContext: The callout context to affect, if any.
    ///   - keyboardWidth: The total width of the keyboard.
    ///   - inputWidth: The input width within the keyboard.
    ///   - isNextProbability: The probability (0-1) that the button will be tapped next.
    ///   - isGestureAutoCancellable: Whether an aborted gesture will auto-cancel itself, by default `false`.
    ///   - content: The content view to use within the item.
    init(
        item: KeyboardLayout.Item,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        styleService: KeyboardStyleService,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat,
        isNextProbability: Double = 0,
        isGestureAutoCancellable: Bool? = nil,
        content: Content
    ) {
        self.item = item
        self.actionHandler = actionHandler
        self.repeatTimer = repeatTimer
        self.styleService = styleService
        self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        self.calloutContext = calloutContext
        self.keyboardWidth = keyboardWidth
        self.inputWidth = inputWidth
        self.isNextProbability = isNextProbability
        self.isGestureAutoCancellable = isGestureAutoCancellable
        self.content = content
    }

    var action: KeyboardAction { item.action }

    private let item: KeyboardLayout.Item
    private let actionHandler: KeyboardActionHandler
    private let repeatTimer: GestureButtonTimer?
    let styleService: KeyboardStyleService
    private let calloutContext: KeyboardCalloutContext?
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let isNextProbability: Double
    private let isGestureAutoCancellable: Bool?
    private let content: Content

    @Environment(\.keyboardButtonStyleBuilder)
    var buttonStyleBuilder

    @Environment(\.keyboardSpaceContextMenuLeading)
    private var spaceContextMenuLeadingEnv
    
    @Environment(\.keyboardSpaceContextMenuTrailing)
    private var spaceContextMenuTrailingEnv
    
    @ObservedObject var keyboardContext: KeyboardContext
    
    @State var isPressed = false
    
    public var body: some View {
        ZStack(alignment: item.alignment) {
            Color.clearInteractable
            content
        }
        .opacity(contentOpacity)
        .animation(.default, value: keyboardContext.isSpaceDragGestureActive)
        .keyboardLayoutItemSize(
            for: item,
            rowWidth: keyboardWidth,
            inputWidth: inputWidth
        )
        .keyboardButton(
            for: item.action,
            style: buttonStyle,
            actionHandler: actionHandler,
            repeatTimer: repeatTimer,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            additionalTapArea: isNextProbability * 5,
            edgeInsets: item.edgeInsets,
            isPressed: $isPressed,
            isGestureAutoCancellable: isGestureAutoCancellable
        )
        .overlay(alignment: .bottomLeading) { spaceContextMenuLeadingOverlay }
        .overlay(alignment: .bottomTrailing) { spaceContextMenuTrailingOverlay }
    }
}

private extension KeyboardViewItem {
    
    var buttonStyle: Keyboard.ButtonStyle {
        item.action.isSpacer ? .spacer : keyboardButtonStyle(isPressed: isPressed)
    }

    var contentOpacity: Double {
        keyboardContext.isSpaceDragGestureActive ? 0 : 1
    }
    
    var shouldAddSpaceContextMenu: Bool {
        item.action == .space && keyboardContext.hasMultipleEnabledLocales
    }
    
    var spaceContextMenuLeading: Keyboard.SpaceMenuType? {
        spaceContextMenuLeadingEnv ?? keyboardContext.settings.spaceContextMenuLeading
    }
    
    var spaceContextMenuTrailing: Keyboard.SpaceMenuType? {
        spaceContextMenuTrailingEnv ?? keyboardContext.settings.spaceContextMenuTrailing
    }
}

private extension KeyboardViewItem {
    
    @ViewBuilder
    var spaceContextMenuLeadingOverlay: some View {
        if shouldAddSpaceContextMenu && spaceContextMenuLeading == .locale {
            spaceContextMenu(.bottomLeading)
        }
    }
    
    @ViewBuilder
    var spaceContextMenuTrailingOverlay: some View {
        if shouldAddSpaceContextMenu && spaceContextMenuTrailing == .locale {
            spaceContextMenu(.bottomTrailing)
        }
    }
    
    func spaceContextMenu(_ alignment: Alignment) -> some View {
        spaceContextMenuTitle(alignment)
            .padding(item.edgeInsets)
            .localeContextMenu(for: keyboardContext) {
                actionHandler.handle(.release, on: .space)
                actionHandler.triggerFeedback(for: .press, on: .space)
            }
    }
    
    func spaceContextMenuTitle(_ alignment: Alignment) -> some View {
        typealias Content = Keyboard.SpaceContextMenuTitle
        let title = keyboardContext.locale.shortDisplayName
        let style = styleService.buttonStyle(for: .space, isPressed: false)
        return Content(title, alignment: alignment, style: style)
    }
}

#Preview {
    
    struct Preview: View {
        
        let action = KeyboardAction.space
        
        @State
        var keyboardContext: KeyboardContext = {
            let context = KeyboardContext()
            context.locales = .keyboardKitSupported
            context.settings.addedLocales = [.english, .swedish, .finnish].map { .init($0) }
            context.localePresentationLocale = .swedish
            context.settings.spaceContextMenuLeading = .locale
            context.settings.spaceContextMenuTrailing = .locale
            return context
        }()
        
        var body: some View {
            KeyboardViewItem(
                item: .init(
                    action: action,
                    size: .init(width: .points(200), height: 100)
//                    alignment: .bottomLeading,
//                    edgeInsets: .init(horizontal: 10, vertical: 10)
                ),
                actionHandler: .preview,
                styleService: .preview,
                keyboardContext: keyboardContext,
                calloutContext: .preview,
                keyboardWidth: 200,
                inputWidth: 200,
                isGestureAutoCancellable: false,
                content: Text("Hello, world!")
            )
            .padding()
            .background(Color.keyboardBackground)
            .keyboardButtonStyle { params in
                var style = params.standardButtonStyle(for: context)
            }
        }
    }
    
    return Preview()
        // .keyboardSpaceTrailingAction(.localeContextMenu)
}
