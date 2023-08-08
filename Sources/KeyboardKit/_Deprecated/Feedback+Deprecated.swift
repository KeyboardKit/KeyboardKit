import Foundation

#if os(iOS)
import UIKit
#endif

#if os(iOS) || os(macOS) || os(tvOS)
import AudioToolbox
#endif

public extension AudioFeedback {
    
    @available(*, deprecated, message: "This property is no longer used")
    static var engine: AudioFeedbackEngine = {
        #if os(iOS) || os(macOS) || os(tvOS)
        StandardAudioFeedbackEngine.shared
        #else
        DisabledAudioFeedbackEngine()
        #endif
    }()
}

@available(*, deprecated, message: "This engine is no longer used.")
public class DisabledAudioFeedbackEngine: AudioFeedbackEngine {

    public override func trigger(_ audio: AudioFeedback) {}
}

@available(*, deprecated, message: "This engine is no longer used.")
public class DisabledHapticFeedbackEngine: HapticFeedbackEngine {
    
    public override func prepare(_ feedback: HapticFeedback) {}
    public override func trigger(_ feedback: HapticFeedback) {}
}

public extension HapticFeedback {
    
    @available(*, deprecated, message: "This property is no longer used")
    static var engine: HapticFeedbackEngine = {
        #if os(iOS)
        StandardHapticFeedbackEngine.shared
        #else
        DisabledHapticFeedbackEngine()
        #endif
    }()
}

#if os(iOS) || os(macOS) || os(tvOS)
@available(*, deprecated, renamed: "AudioFeedbackEngine")
open class StandardAudioFeedbackEngine: AudioFeedbackEngine {}
#endif


// MARK: - KeyboardFeedbackHandler

@available(*, deprecated, message: "This protocol is replaced by KeyboardActionHandler")
public protocol KeyboardFeedbackHandler {
    
    func triggerFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    )
 
    func triggerAudioFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    )
    
    func triggerHapticFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    )
}


@available(*, deprecated, message: "This class is replaced by StandardKeyboardActionHandler")
open class StandardKeyboardFeedbackHandler: KeyboardFeedbackHandler {
    
    /**
     Create a standard keyboard feedback handler instance.
     
     - Parameters:
       - settings: The feedback settings to use.
     */
    public init(settings: KeyboardFeedbackSettings) {
        self.settings = settings
    }
    
    /**
     The feedback settings to use.
     */
    public let settings: KeyboardFeedbackSettings
    
    public var audioConfig: AudioFeedbackConfiguration { settings.audioConfiguration }
    
    public var hapticConfig: HapticFeedbackConfiguration { settings.hapticConfiguration }
    
    /**
     The audio feedback to use for a certain action gesture.
     */
    open func audioFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> AudioFeedback? {
        let config = settings.audioConfiguration
        let custom = config.actions.first { $0.action == action }
        if let custom = custom { return custom.feedback }
        if action == .space && gesture == .longPress { return nil }
        if action == .backspace { return config.delete }
        if action.isInputAction { return config.input }
        if action.isSystemAction { return config.system }
        return nil
    }
    
    /**
     The haptic feedback to use for a certain action gesture.
     */
    open func hapticFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> HapticFeedback? {
        let config = settings.hapticConfiguration
        let custom = config.actions.first { $0.action == action && $0.gesture == gesture }
        if let custom = custom { return custom.feedback }
        if action == .space && gesture == .longPress { return config.longPressOnSpace }
        switch gesture {
        case .doubleTap: return config.doubleTap
        case .longPress: return config.longPress
        case .press: return config.press
        case .release: return config.release
        case .repeatPress: return config.repeat
        }
    }
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    open func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        triggerAudioFeedback(for: gesture, on: action)
        triggerHapticFeedback(for: gesture, on: action)
    }
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        let feedback = audioFeedback(for: gesture, on: action)
        feedback?.trigger()
    }
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        let feedback = hapticFeedback(for: gesture, on: action)
        feedback?.trigger()
    }
}


#if os(iOS)
@available(*, deprecated, renamed: "HapticFeedbackEngine")
open class StandardHapticFeedbackEngine: HapticFeedbackEngine {}
#endif
