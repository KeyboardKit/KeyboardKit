import SwiftUI

@available(*, deprecated, renamed: "Feedback")
public typealias KeyboardFeedback = Feedback

@available(*, deprecated, renamed: "FeedbackContext")
public typealias KeyboardFeedbackContext = FeedbackContext

@available(*, deprecated, renamed: "FeedbackService")
public typealias KeyboardFeedbackService = FeedbackService

@available(*, deprecated, renamed: "FeedbackSettings")
public typealias KeyboardFeedbackSettings = FeedbackSettings

public extension Feedback.Haptic {

    @available(*, deprecated, renamed: "selectionChanged")
    static let selection = selectionChanged
}
