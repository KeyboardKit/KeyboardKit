import SwiftUI

public extension CalloutContext {

    @available(*, deprecated, renamed: "updateSecondaryActions(_:for:in:alignment:)")
    func updateSecondaryActions(
        for action: KeyboardAction,
        in geo: GeometryProxy,
        alignment: HorizontalAlignment? = nil
    ) {
        self.updateSecondaryActions(
            nil,
            for: action,
            in: geo,
            alignment: alignment
        )
    }
}

@available(*, deprecated, renamed: "Callouts")
public typealias KeyboardCallout = Callouts

@available(*, deprecated, renamed: "CalloutContext")
public typealias KeyboardCalloutContext = CalloutContext

@available(*, deprecated, renamed: "CalloutService")
public typealias KeyboardCalloutService = CalloutService

public extension CalloutService where Self == Callouts.BaseCalloutService {

    static var preview: CalloutService {
        Callouts.BaseCalloutService()
    }
}

public extension KeyboardPreviews {

    class CalloutService: Callouts.BaseCalloutService {
        public override func triggerFeedbackForSelectionChange() {}
    }
}
