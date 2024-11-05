//
//  Callouts+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-07-01.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
public extension CalloutService where Self == Callouts.DisabledService {

    static var disabled: Self {
        Callouts.DisabledService()
    }
}

extension Callouts {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
    open class DisabledService: CalloutService {

        public init() {}

        open func calloutActions(
            for action: KeyboardAction
        ) -> [KeyboardAction] {
            []
        }

        open func triggerFeedbackForSelectionChange() {}
    }
}


public extension Callouts.CalloutStyle {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use the new initializer instead.")
    init(
        backgroundColor: Color = .keyboardButtonBackground,
        borderColor: Color = Color.black.opacity(0.5),
        buttonCornerRadius: CGFloat = 5,
        buttonInset: CGSize = CGSize.zero,
        cornerRadius: CGFloat = 10,
        curveSize: CGSize = CGSize(width: 8, height: 15),
        shadowColor: Color = Color.black.opacity(0.1),
        shadowRadius: CGFloat = 5,
        textColor: Color
    ) {
        self.init(
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            buttonOverlayCornerRadius: buttonCornerRadius,
            buttonOverlayInset: buttonInset,
            cornerRadius: cornerRadius,
            curveSize: curveSize,
            foregroundColor: textColor,
            shadowColor: shadowColor,
            shadowRadius: shadowRadius
        )
    }

    @available(*, deprecated, renamed: "foregroundColor", message: "Migration Deprecation, will be removed in 9.1!")
    var textColor: Color {
        get { foregroundColor }
        set { foregroundColor = newValue }
    }

    @available(*, deprecated, renamed: "buttonOverlayCornerRadius", message: "Migration Deprecation, will be removed in 9.1!")
    var buttonCornerRadius: CGFloat {
        get { buttonOverlayCornerRadius ?? 5 }
        set { buttonOverlayCornerRadius = newValue }
    }

    @available(*, deprecated, renamed: "buttonOverlayInset", message: "Migration Deprecation, will be removed in 9.1!")
    var buttonInset: CGSize {
        get { buttonOverlayInset }
        set { buttonOverlayInset = newValue }
    }
}

public extension Callouts {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use Callouts.CalloutStyle instead.")
    struct InputCalloutStyle: Codable, Equatable {

        public init(
            callout: Callouts.CalloutStyle = .standard,
            calloutPadding: CGFloat = 2,
            calloutSize: CGSize = CGSize(width: 0, height: 55),
            font: KeyboardFont = .init(.largeTitle, .light)
        ) {
            var callout = callout
            callout.inputItemFont = font
            callout.inputItemMinSize = calloutSize
            self.callout = callout
            self.calloutPadding = calloutPadding
        }

        public var callout: Callouts.CalloutStyle
        public var calloutPadding: CGFloat

        public static var standard: Self { .init() }
    }
}


@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use Callouts.CalloutStyle instead.")
public extension Callouts.InputCalloutStyle {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use callout.inputItemMinSize instead.")
    var calloutSize: CGSize {
        get { callout.inputItemMinSize }
        set { callout.inputItemMinSize = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use callout.inputItemFont instead.")
    var font: KeyboardFont {
        get { callout.inputItemFont }
        set { callout.inputItemFont = newValue }
    }
}

public extension Callouts {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use Callouts.CalloutStyle instead.")
    struct ActionCalloutStyle: Codable, Equatable {

        public init(
            callout: Callouts.CalloutStyle = .standard,
            font: KeyboardFont = .init(.title3),
            maxButtonSize: CGSize = CGSize(width: 50, height: 50),
            selectedBackgroundColor: Color? = nil,
            selectedForegroundColor: Color? = nil,
            verticalOffset: CGFloat? = nil,
            verticalTextPadding: CGFloat = 6
        ) {
            var callout = callout
            callout.actionItemFont = font
            callout.actionItemMaxSize = maxButtonSize
            if let verticalOffset { callout.offset = .init(x: 0, y: verticalOffset) }
            callout.selectedBackgroundColor = selectedBackgroundColor ?? .blue
            callout.selectedForegroundColor = selectedForegroundColor ?? .white
            callout.actionItemPadding = .init(width: 0, height: verticalTextPadding)
            self.callout = callout
        }

        public var callout: Callouts.CalloutStyle

        public static var standard: Self { .init() }
    }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use Callouts.CalloutStyle instead.")
public extension Callouts.ActionCalloutStyle {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use callout.actionItemFont instead.")
    var font: KeyboardFont {
        get { callout.actionItemFont }
        set { callout.actionItemFont = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use callout.actionItemMaxSize instead.")
    var maxButtonSize: CGSize {
        get { callout.actionItemMaxSize }
        set { callout.actionItemMaxSize = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use callout.selectedBackgroundColor instead.")
    var selectedBackgroundColor: Color {
        get { callout.selectedBackgroundColor }
        set { callout.selectedBackgroundColor = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use callout.selectedForegroundColor instead.")
    var selectedForegroundColor: Color {
        get { callout.selectedForegroundColor }
        set { callout.selectedForegroundColor = newValue }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use callout.offset instead.")
    var verticalOffset: CGFloat? {
        get { callout.offset?.y }
        set { callout.offset = .init(x: 0, y: newValue ?? 0) }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use callout.actionItemPadding instead.")
    var verticalTextPadding: CGFloat {
        get { callout.actionItemPadding.height }
        set { callout.actionItemPadding = .init(width: 0, height: newValue) }
    }
}

public extension View {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .calloutStyle instead.")
    func actionCalloutStyle(
        _ style: Callouts.ActionCalloutStyle
    ) -> some View {
        self.environment(\.calloutStyle, style.callout)
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .calloutStyle instead.")
    func inputCalloutStyle(
        _ style: Callouts.InputCalloutStyle
    ) -> some View {
        self.environment(\.inputCalloutStyle, style)
    }
}

public extension EnvironmentValues {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .calloutStyle instead.")
    @Entry var actionCalloutStyle = Callouts
        .ActionCalloutStyle.standard

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use .calloutStyle instead.")
    @Entry var inputCalloutStyle = Callouts
        .InputCalloutStyle.standard
}
