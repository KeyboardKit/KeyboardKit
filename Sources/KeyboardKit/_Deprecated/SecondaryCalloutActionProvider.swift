import Foundation

@available(*, deprecated, renamed: "CalloutActionProvider")
public typealias SecondaryCalloutActionProvider = CalloutActionProvider

public extension CalloutActionProvider {
    
    @available(*, deprecated, renamed: "calloutActions")
    func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        calloutActions(for: action)
    }
}

@available(*, deprecated, renamed: "DisabledCalloutActionProvider")
typealias DisabledSecondaryCalloutActionProvider = DisabledCalloutActionProvider

@available(*, deprecated, renamed: "PreviewCalloutActionProvider")
public typealias PreviewSecondaryCalloutActionProvider = PreviewCalloutActionProvider
