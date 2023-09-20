//
//  CalloutContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-24.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Combine
import SwiftUI

/**
 This observable context can be used to handle callout state
 for a keyboard.

 The class wraps contexts for both action and input callouts,
 so that we only have to pass around a single instance.

 KeyboardKit automatically creates an instance of this class
 and binds the created instance to the keyboard controller's
 ``KeyboardInputViewController/calloutContext``.
 */
public class CalloutContext: ObservableObject {

    /**
     Create a new callout context instance, using a separate
     set of contexts for the different callout types.

     - Parameters:
       - actionContext: The action context to use.
       - inputContext: The input context to use.
     */
    public init(
        actionContext: CalloutActionContext,
        inputContext: CalloutInputContext
    ) {
        self.actionContext = actionContext
        self.inputContext = inputContext
    }

    /// The action context that is bound to the context.
    public var actionContext: CalloutActionContext

    /// The input context that is bound to the context.
    public var inputContext: CalloutInputContext
}

public extension CalloutContext {

    /// This context can be used to disable callouts.
    static var disabled: CalloutContext {
        .init(
            actionContext: .disabled,
            inputContext: .disabled
        )
    }
}
