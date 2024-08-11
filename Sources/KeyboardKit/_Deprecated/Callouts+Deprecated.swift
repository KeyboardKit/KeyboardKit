import Foundation

@available(*, deprecated, renamed: "AutocompleteService")
public typealias CalloutActionProvider = CalloutService

public extension Callouts {

    @available(*, deprecated, renamed: "StandardService")
    typealias StandardActionProvider = StandardService

    @available(*, deprecated, renamed: "BaseService")
    typealias BaseActionProvider = BaseService

    @available(*, deprecated, renamed: "DisabledService")
    typealias DisabledActionProvider = DisabledService
}

@available(*, deprecated, renamed: "Callouts.BaseService")
public typealias BaseCalloutActionProvider = Callouts.BaseService

@available(*, deprecated, renamed: "Callouts.StandardService")
public typealias StandardCalloutActionProvider = Callouts.StandardService
