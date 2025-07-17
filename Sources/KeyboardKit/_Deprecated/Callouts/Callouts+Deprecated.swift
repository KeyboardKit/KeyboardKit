import SwiftUI

public extension KeyboardCalloutContext {

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
