import SwiftUI

public extension View {
    
    @available(*, deprecated, renamed: "actionCallout")
    func secondaryInputCallout(
        context: ActionCalloutContext,
        style: SecondaryInputCalloutStyle = .standard) -> some View {
        self.actionCallout(context: context, style: style)
    }
}
