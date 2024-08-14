//
//  Feedback+StandardService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)
import AudioToolbox
#else
typealias SystemSoundID = Int
#endif

#if os(iOS)
import UIKit
#endif

extension Feedback {

    /// This standard service can be used to trigger various
    /// audio and haptic feedback, using system capabilities.
    ///
    /// KeyboardKit automatically creates an instance of the
    /// class when the keyboard is launched, then injects it
    /// into ``KeyboardInputViewController/services``.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// See <doc:Feedback-Article> for more information.
    open class StandardService: FeedbackService {

        /// Create a standard feedback service.
        public init() {}

        #if os(iOS)
        public let notificationGenerator = UINotificationFeedbackGenerator()
        public let lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
        public let mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
        public let heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
        public let selectionGenerator = UISelectionFeedbackGenerator()
        #endif

        open func triggerAudioFeedback(_ audio: Feedback.Audio) {
            switch audio {
            case .none: return
            case .customUrl(let url): playAudio(at: url)
            default: play(audio)
            }
        }

        open func triggerHapticFeedback(_ feedback: Feedback.Haptic) {
            #if os(iOS)
            switch feedback {
            case .error: triggerNotification(.error)
            case .success: triggerNotification(.success)
            case .warning: triggerNotification(.warning)
            case .lightImpact: lightImpactGenerator.impactOccurred()
            case .mediumImpact: mediumImpactGenerator.impactOccurred()
            case .heavyImpact: heavyImpactGenerator.impactOccurred()
            case .selectionChanged: selectionGenerator.selectionChanged()
            case .none: return
            }
            #endif
        }
    }
}


// MARK: - Audio

private extension Feedback.StandardService {

    static var systemSoundIDs: [URL: SystemSoundID] = [:]

    func play(_ audio: Feedback.Audio) {
        guard let id = audio.id else { return }
        #if os(iOS) || os(macOS) || os(tvOS)
        AudioServicesPlaySystemSound(id)
        #endif
    }

    func playAudio(at url: URL?) {
        guard let url else { return }
        #if os(iOS) || os(macOS) || os(tvOS)
        registerAudio(at: url)
        guard let id = Self.systemSoundIDs[url] else { return }
        AudioServicesPlaySystemSound(id)
        #endif
    }

    func registerAudio(at url: URL?) {
        guard let url else { return }
        #if os(iOS) || os(macOS) || os(tvOS)
        if Self.systemSoundIDs[url] != nil { return }
        var soundId: SystemSoundID = .init()
        AudioServicesCreateSystemSoundID(url as CFURL, &soundId)
        Self.systemSoundIDs[url] = soundId
        #endif
    }
}


// MARK: - Haptic

#if os(iOS)
private extension Feedback.StandardService {

    func triggerNotification(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(notification)
    }
}
#endif
