//
//  KeyboardInputViewController+State.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
public extension KeyboardInputViewController {
    
    @available(*, deprecated, renamed: "state.autocompleteContext")
    var autocompleteContext: AutocompleteContext { state.autocompleteContext }
    
    @available(*, deprecated, renamed: "state.calloutContext")
    var calloutContext: CalloutContext { state.calloutContext }
    
    @available(*, deprecated, renamed: "state.dictationConfig")
    var dictationConfig: Dictation.KeyboardConfiguration {
        .init(
            appGroupId: state.dictationContext.appGroupId ?? "",
            appDeepLink: state.dictationContext.appDeepLink ?? ""
        )
    }
    
    @available(*, deprecated, renamed: "state.dictationContext")
    var dictationContext: DictationContext { state.dictationContext }
    
    @available(*, deprecated, renamed: "state.feedbackConfiguration")
    var feedbackConfiguration: FeedbackConfiguration {
        get { state.feedbackConfiguration }
        set { state.feedbackConfiguration = newValue }
    }
    
    @available(*, deprecated, renamed: "state.keyboardContext")
    var keyboardContext: KeyboardContext { state.keyboardContext }
    
    @available(*, deprecated, renamed: "feedbackConfiguration")
    var keyboardFeedbackSettings: FeedbackConfiguration {
        get { feedbackConfiguration }
        set { feedbackConfiguration = newValue }
    }
}
#endif
