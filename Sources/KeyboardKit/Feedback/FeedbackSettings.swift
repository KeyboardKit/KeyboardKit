//
//  FeedbackSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class can be used to specify what kind of feedback the
 current keyboard should give to the user.
 */
public class FeedbackSettings: ObservableObject {
    
    public init(
        audioConfiguration: AudioFeedbackConfiguration = .standard,
        hapticConfiguration: HapticFeedbackConfiguration = .standard) {
        self.audioConfiguration = audioConfiguration
        self.hapticConfiguration = hapticConfiguration
    }
    
    @Published public var audioConfiguration: AudioFeedbackConfiguration
    @Published public var hapticConfiguration: HapticFeedbackConfiguration
}
