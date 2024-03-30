//
//  CalloutContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-24.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Combine
import SwiftUI


/// This class has observable, callout-related state.
///
/// The ``inputContext`` property is used for input callouts,
/// and ``actionContext`` for action callouts. This class is
/// used to have a single way to access both states.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value
/// into the view hierarchy. 
public class CalloutContext: ObservableObject {

    /// Create a callout context, with separate contexts for
    /// the different callout types.
    ///
    /// - Parameters:
    ///   - actionContext: The action context to use.
    ///   - inputContext: The input context to use.
    public init(
        actionContext: ActionContext,
        inputContext: InputContext
    ) {
        self.actionContext = actionContext
        self.inputContext = inputContext
    }

    /// The action context that is bound to the context.
    public var actionContext: ActionContext

    /// The input context that is bound to the context.
    public var inputContext: InputContext
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
