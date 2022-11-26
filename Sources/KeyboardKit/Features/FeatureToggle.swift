//
//  FeatureToggle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-23.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This singleton class can be used to toggle any experimental
 ``Feature`` on and off.

 You can use the static ``shared`` context to share a single
 instance in your code.

 Use ``toggleFeature(_:isOn:)`` to toggle any feature on and
 off. Use ``isFeatureEnabled(_:)`` to check whether or not a
 certain feature is enabled. Use the ``Feature/allFeatures``
 property if you want a list with all the available features.
 */
public final class FeatureToggle {

    /**
     Create a new feature toggle instance.
     */
    public init() {
        defaultEnabledFeatures = [.newButtonGestureEngine]
        enabledFeatures = []
        reset()
    }

    /**
     This enum defined the available toggle states.
     */
    public enum State: String {

        /// The feature is enabled.
        case on

        /// The feature is disabled.
        case off
    }


    // MARK: - Shared

    /**
     The shared instance is resolved by returning the context
     of ``KeyboardInputViewController/shared``.
     */
    public static var shared = FeatureToggle()

    /**
     The features that are enabled by default.
     */
    public private(set) var defaultEnabledFeatures: [Feature]

    /**
     The currently enabled features.
     */
    public private(set) var enabledFeatures: [Feature]
}

public extension FeatureToggle {

    /**
     This enum defines the currently available features that
     can be toggled on and off in the ``FeatureToggle``.
     */
    enum Feature: String, CaseIterable {

        /**
         This feature controls the new button gesture engine.

         The new button gesture engine aims at making typing
         better and more precise, and also unlocks many more
         gestures and features in the emoji keyboards.

         This feature is `disabled` by default.
         */
        case newButtonGestureEngine

        /// Get all available feature toggle features
        public static var allFeatures: [Feature] { allCases }
    }
}

public extension FeatureToggle {

    /**
     Toggle a certain ``Feature`` on or off.
     */
    func isFeatureEnabled(_ feature: Feature) -> Bool {
        enabledFeatures.contains(feature)
    }

    /**
     Reset the feature toggle state.
     */
    func reset() {
        enabledFeatures = defaultEnabledFeatures
    }

    /**
     Toggle a certain ``Feature`` on or off.
     */
    func toggleFeature(_ feature: Feature, _ state: State) {
        let value = state == .on ? true : false
        if isFeatureEnabled(feature) == value { return }
        if value {
            enabledFeatures.append(feature)
        } else {
            enabledFeatures = enabledFeatures.filter { $0 != feature }
        }
    }
}
