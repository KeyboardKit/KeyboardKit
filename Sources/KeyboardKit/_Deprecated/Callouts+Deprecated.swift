import SwiftUI

public extension KeyboardCalloutContext {

    @available(*, deprecated, message: "Use the function with an actions parameter instead.")
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
