//
//  MigrationTypes.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-09-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This file contains TEMPORARY typealiases, that are meant
/// to help developers who upgrade from 7.0.

@available(*, deprecated, renamed: "Callouts.ActionCallout", message: "This will be removed in KeyboardKit 8.1.")
public typealias ActionCallout = Callouts.ActionCallout

@available(*, deprecated, renamed: "InputSet", message: "This will be removed in KeyboardKit 8.1.")
public typealias AlphabeticInputSet = InputSet

@available(*, deprecated, renamed: "AudioFeedback.Configuration", message: "This will be removed in KeyboardKit 8.1.")
public typealias AudioFeedbackConfiguration = AudioFeedback.Configuration

@available(*, deprecated, renamed: "AudioFeedback.Engine", message: "This will be removed in KeyboardKit 8.1.")
public typealias AudioFeedbackEngine = AudioFeedback.Engine

@available(*, deprecated, renamed: "Callouts.ButtonArea", message: "This will be removed in KeyboardKit 8.1.")
public typealias CalloutButtonArea = Callouts.ButtonArea

@available(*, deprecated, renamed: "Dictation.AuthorizationStatus", message: "This will be removed in KeyboardKit 8.1.")
public typealias DictationAuthorizationStatus = Dictation.AuthorizationStatus

@available(*, deprecated, renamed: "Dictation.Configuration", message: "This will be removed in KeyboardKit 8.1.")
public typealias DictationConfiguration = Dictation.Configuration

@available(*, deprecated, renamed: "Gestures.GestureButton", message: "This will be removed in KeyboardKit 8.1.")
public typealias GestureButton = Gestures.GestureButton

@available(*, deprecated, renamed: "Gestures.Defaults", message: "This will be removed in KeyboardKit 8.1.")
public typealias GestureButtonDefaults = Gestures.Defaults

@available(*, deprecated, renamed: "HapticFeedback.Configuration", message: "This will be removed in KeyboardKit 8.1.")
public typealias HapticFeedbackConfiguration = HapticFeedback.Configuration

@available(*, deprecated, renamed: "HapticFeedback.Engine", message: "This will be removed in KeyboardKit 8.1.")
public typealias HapticFeedbackEngine = HapticFeedback.Engine

@available(*, deprecated, renamed: "Callouts.InputCallout", message: "This will be removed in KeyboardKit 8.1.")
public typealias InputCallout = Callouts.InputCallout

@available(*, deprecated, renamed: "InputSet.Item", message: "This will be removed in KeyboardKit 8.1.")
public typealias InputSetItem = InputSet.Item

@available(*, deprecated, renamed: "InputSet.Row", message: "This will be removed in KeyboardKit 8.1.")
public typealias InputSetRow = InputSet.Row

@available(*, deprecated, renamed: "InputSet.Row", message: "This will be removed in KeyboardKit 8.1.")
public typealias InputSetRows = InputSet.Rows

@available(*, deprecated, renamed: "Gestures.KeyboardGesture", message: "This will be removed in KeyboardKit 8.1.")
public typealias KeyboardGesture = Gestures.KeyboardGesture

@available(*, deprecated, renamed: "KeyboardStateContext", message: "This will be removed in KeyboardKit 8.1.")
public typealias KeyboardEnabledContext = KeyboardStateContext

@available(*, deprecated, renamed: "KeyboardStateLabel", message: "This will be removed in KeyboardKit 8.1.")
public typealias KeyboardEnabledLabel = KeyboardStateLabel

@available(*, deprecated, renamed: "KeyboardStateInspector", message: "This will be removed in KeyboardKit 8.1.")
public typealias KeyboardEnabledStateInspector = KeyboardStateInspector

@available(*, deprecated, renamed: "KeyboardLayout.Configuration", message: "This will be removed in KeyboardKit 8.1.")
public typealias KeyboardLayoutConfiguration = KeyboardLayout.Configuration

@available(*, deprecated, renamed: "InputSet", message: "This will be removed in KeyboardKit 8.1.")
public typealias NumericInputSet = InputSet

@available(*, deprecated, renamed: "Gestures.RepeatTimer", message: "This will be removed in KeyboardKit 8.1.")
public typealias RepeatGestureTimer = Gestures.RepeatTimer

@available(*, deprecated, renamed: "Gestures.ScrollViewGestureButton", message: "This will be removed in KeyboardKit 8.1.")
public typealias ScrollViewGestureButton = Gestures.ScrollViewGestureButton

@available(*, deprecated, renamed: "Gestures.SpaceDragSensitivity", message: "This will be removed in KeyboardKit 8.1.")
public typealias SpaceDragSensitivity = Gestures.SpaceDragSensitivity

@available(*, deprecated, renamed: "Gestures.SpaceLongPressBehavior", message: "This will be removed in KeyboardKit 8.1.")
public typealias SpaceLongPressBehavior = Gestures.SpaceLongPressBehavior

@available(*, deprecated, renamed: "InputSet", message: "This will be removed in KeyboardKit 8.1.")
public typealias SymbolicInputSet = InputSet

@available(*, deprecated, renamed: "KeyboardButton.Button", message: "This will be removed in KeyboardKit 8.1.")
public typealias SystemKeyboardButton = KeyboardButton.Button

@available(*, deprecated, renamed: "KeyboardButton.Key", message: "This will be removed in KeyboardKit 8.1.")
public typealias SystemKeyboardButtonBody = KeyboardButton.Key

@available(*, deprecated, renamed: "KeyboardButton.Content", message: "This will be removed in KeyboardKit 8.1.")
public typealias SystemKeyboardButtonContent = KeyboardButton.Content

@available(*, deprecated, renamed: "KeyboardButton.Shadow", message: "This will be removed in KeyboardKit 8.1.")
public typealias SystemKeyboardButtonShadow = KeyboardButton.Shadow

@available(*, deprecated, renamed: "KeyboardButton.Title", message: "This will be removed in KeyboardKit 8.1.")
public typealias SystemKeyboardButtonText = KeyboardButton.Title

@available(*, deprecated, renamed: "SystemKeyboardItem", message: "This will be removed in KeyboardKit 8.1.")
public typealias SystemKeyboardButtonRowItem = SystemKeyboardItem

@available(*, deprecated, renamed: "KeyboardButton.SpaceContent", message: "This will be removed in KeyboardKit 8.1.")
public typealias SystemKeyboardSpaceContent = KeyboardButton.SpaceContent

public extension KeyboardLayoutItem {
    
    var insets: EdgeInsets { edgeInsets }
}

public extension View {
    
    @available(*, deprecated, renamed: "keyboardActionCalloutContainer", message: "This will be removed in KeyboardKit 8.1.")
    func actionCallout(
        calloutContext: CalloutContext.ActionContext,
        keyboardContext: KeyboardContext,
        style: KeyboardStyle.ActionCallout = .standard
    ) -> some View {
        keyboardActionCalloutContainer(
            calloutContext: calloutContext,
            keyboardContext: keyboardContext,
            style: style)
    }
    
    @available(*, deprecated, renamed: "keyboardInputCalloutContainer", message: "This will be removed in KeyboardKit 8.1.")
    func inputCallout(
        calloutContext: CalloutContext.InputContext,
        keyboardContext: KeyboardContext,
        style: KeyboardStyle.InputCallout = .standard
    ) -> some View {
        keyboardInputCalloutContainer(
            calloutContext: calloutContext,
            keyboardContext: keyboardContext,
            style: style)
    }
    
    @available(*, deprecated, renamed: "keyboardButtonStyle", message: "This will be removed in KeyboardKit 8.1.")
    func systemKeyboardButtonStyle(_ style: KeyboardStyle.Button) -> some View {
        keyboardButtonStyle(style)
    }
}
