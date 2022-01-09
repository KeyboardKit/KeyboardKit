import SwiftUI

public extension View {
    
    /**
     This modifier can be applied to any view that should be
     able to present a secondary input callout.
     
     - Parameters:
       - context: The context to bind against.
       - style: The style to apply to the view, by default `.standard`.
     */
    @available(*, deprecated, renamed: "actionCallout")
    func secondaryInputCallout(
        context: ActionCalloutContext,
        style: SecondaryInputCalloutStyle = .standard) -> some View {
        self.actionCallout(context: context, style: style)
    }
}
