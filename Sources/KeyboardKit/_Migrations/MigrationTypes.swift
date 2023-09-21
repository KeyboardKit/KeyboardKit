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
///
/// The typealiases will be removed in the 8.1 minor upgrade.

@available(*, deprecated, renamed: "Callouts.ActionCallout")
public typealias ActionCallout = Callouts.ActionCallout

@available(*, deprecated, renamed: "InputSet")
public typealias AlphabeticInputSet = InputSet

@available(*, deprecated, renamed: "AudioFeedback.Configuration")
public typealias AudioFeedbackConfiguration = AudioFeedback.Configuration

@available(*, deprecated, renamed: "AudioFeedback.Engine")
public typealias AudioFeedbackEngine = AudioFeedback.Engine

@available(*, deprecated, renamed: "Callouts.ButtonArea")
public typealias CalloutButtonArea = Callouts.ButtonArea

@available(*, deprecated, renamed: "Dictation.AuthorizationStatus")
public typealias DictationAuthorizationStatus = Dictation.AuthorizationStatus

@available(*, deprecated, renamed: "Dictation.Configuration")
public typealias DictationConfiguration = Dictation.Configuration

@available(*, deprecated, renamed: "Gestures.GestureButton")
public typealias GestureButton = Gestures.GestureButton

@available(*, deprecated, renamed: "Gestures.Defaults")
public typealias GestureButtonDefaults = Gestures.Defaults

@available(*, deprecated, renamed: "HapticFeedback.Configuration")
public typealias HapticFeedbackConfiguration = HapticFeedback.Configuration

@available(*, deprecated, renamed: "HapticFeedback.Engine")
public typealias HapticFeedbackEngine = HapticFeedback.Engine

@available(*, deprecated, renamed: "Callouts.InputCallout")
public typealias InputCallout = Callouts.InputCallout

@available(*, deprecated, renamed: "InputSet.Item")
public typealias InputSetItem = InputSet.Item

@available(*, deprecated, renamed: "InputSet.Row")
public typealias InputSetRow = InputSet.Row

@available(*, deprecated, renamed: "InputSet.Row")
public typealias InputSetRows = InputSet.Rows

@available(*, deprecated, renamed: "Gestures.KeyboardGesture")
public typealias KeyboardGesture = Gestures.KeyboardGesture

@available(*, deprecated, renamed: "KeyboardStateContext")
public typealias KeyboardEnabledContext = KeyboardStateContext

@available(*, deprecated, renamed: "KeyboardStateLabel")
public typealias KeyboardEnabledLabel = KeyboardStateLabel

@available(*, deprecated, renamed: "KeyboardStateInspector")
public typealias KeyboardEnabledStateInspector = KeyboardStateInspector

@available(*, deprecated, renamed: "InputSet")
public typealias NumericInputSet = InputSet

@available(*, deprecated, renamed: "Gestures.RepeatTimer")
public typealias RepeatGestureTimer = Gestures.RepeatTimer

@available(*, deprecated, renamed: "Gestures.ScrollViewGestureButton")
public typealias ScrollViewGestureButton = Gestures.ScrollViewGestureButton

@available(*, deprecated, renamed: "Gestures.SpaceDragSensitivity")
public typealias SpaceDragSensitivity = Gestures.SpaceDragSensitivity

@available(*, deprecated, renamed: "Gestures.SpaceLongPressBehavior")
public typealias SpaceLongPressBehavior = Gestures.SpaceLongPressBehavior

@available(*, deprecated, renamed: "InputSet")
public typealias SymbolicInputSet = InputSet

@available(*, deprecated, renamed: "KeyboardButton.Button")
public typealias SystemKeyboardButton = KeyboardButton.Button

@available(*, deprecated, renamed: "KeyboardButton.Key")
public typealias SystemKeyboardButtonBody = KeyboardButton.Key

@available(*, deprecated, renamed: "KeyboardButton.Content")
public typealias SystemKeyboardButtonContent = KeyboardButton.Content

@available(*, deprecated, renamed: "KeyboardButton.Shadow")
public typealias SystemKeyboardButtonShadow = KeyboardButton.Shadow

@available(*, deprecated, renamed: "KeyboardButton.Title")
public typealias SystemKeyboardButtonText = KeyboardButton.Title

@available(*, deprecated, renamed: "SystemKeyboardItem")
public typealias SystemKeyboardButtonRowItem = SystemKeyboardItem

@available(*, deprecated, renamed: "KeyboardButton.SpaceContent")
public typealias SystemKeyboardSpaceContent = KeyboardButton.SpaceContent

public extension KeyboardLayoutItem {
    
    var insets: EdgeInsets { edgeInsets }
}

public extension View {
    
    @available(*, deprecated, renamed: "keyboardActionCalloutContainer")
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
    
    @available(*, deprecated, renamed: "keyboardInputCalloutContainer")
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
    
    @available(*, deprecated, renamed: "keyboardButtonStyle")
    func systemKeyboardButtonStyle(_ style: KeyboardStyle.Button) -> some View {
        keyboardButtonStyle(style)
    }
}
