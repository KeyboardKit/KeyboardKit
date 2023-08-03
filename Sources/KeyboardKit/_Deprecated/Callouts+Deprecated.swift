import Foundation

@available(*, deprecated, renamed: "CalloutContext")
public typealias KeyboardCalloutContext = CalloutContext

public extension CalloutContext {
    
    @available(*, deprecated, message: "Use the initializer with actionContext and inputContext instead")
    convenience init(
        action: ActionContext,
        input: InputContext
    ) {
        self.init(
            actionContext: action,
            inputContext: input
        )
    }
    
    @available(*, deprecated, renamed: "actionContext")
    var action: ActionContext {
        get { actionContext }
        set { actionContext = newValue }
    }

    @available(*, deprecated, renamed: "inputContext")
    var input: InputContext {
        get { inputContext }
        set { inputContext = newValue }
    }
}

@available(*, deprecated, renamed: "CalloutContext.ActionContext")
public typealias ActionCalloutContext = CalloutContext.ActionContext

@available(*, deprecated, renamed: "CalloutContext.InputContext")
public typealias InputCalloutContext = CalloutContext.InputContext


@available(*, deprecated, renamed: "KeyboardCalloutStyle")
public typealias CalloutStyle = KeyboardCalloutStyle

@available(*, deprecated, renamed: "KeyboardActionCalloutStyle")
public typealias ActionCalloutStyle = KeyboardActionCalloutStyle

@available(*, deprecated, renamed: "KeyboardInputCalloutStyle")
public typealias InputCalloutStyle = KeyboardInputCalloutStyle
