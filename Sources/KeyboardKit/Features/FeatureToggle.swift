//
//  FeatureToggle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-23.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This singleton class can be used to toggle any experimental
 ``Feature`` on and off.

 You can use the static ``shared`` context to share a single
 instance in your code.
 */
public final class FeatureToggle {

    /**
     Create a new feature toggle instance.
     */
    public init() {
        defaultEnabledFeatures = []
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
     This shared instance can be used for convenience.
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
    enum Feature: String {

        /// This is a placeholder feature without effect.
        case placeholder

        /// The new KeyboardKit Pro autocomplete engine.
        case newAutocompleteEngine
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
