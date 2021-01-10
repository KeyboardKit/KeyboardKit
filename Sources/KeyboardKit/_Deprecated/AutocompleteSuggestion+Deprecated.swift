import Foundation

@available(*, deprecated, message: "This is a temporary extension to avoid breaking changes in KK 3.5 and later. You should implement your own AutocompleteSuggestion type instead")
extension String: AutocompleteSuggestion {
    
    public var replacement: String { self }
    public var title: String { self }
    public var subtitle: String? { nil }
    public var additionalInfo: [String : Any] { [:] }
}

@available(*, deprecated, message: "This typealias is no longer used and will be removed in KK 4")
public typealias AutocompleteSuggestions = [AutocompleteSuggestion]
