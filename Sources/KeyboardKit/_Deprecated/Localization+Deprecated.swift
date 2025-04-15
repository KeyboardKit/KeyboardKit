import Foundation

public extension KKL10n {
    
    @available(*, deprecated, message: "Just use text(for:) with the locale directly.")
    func text(for context: KeyboardContext) -> String {
        text(for: context.locale)
    }

    @available(*, deprecated, message: "Just use text(for:) with the locale directly.")
    func text(forContext context: KeyboardContext) -> String {
        text(for: context)
    }
}
