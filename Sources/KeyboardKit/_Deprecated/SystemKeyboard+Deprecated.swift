import Foundation

public extension SystemKeyboard {
    
    @available(*, deprecated, message: "This is no longer used. Use the toolbar-based controller to customize the toolbar instead.")
    enum AutocompleteToolbarMode {

        /// Show the autocomplete toolbar if the keyboard context prefers it.
        case automatic

        /// Never show the autocomplete toolbar.
        case none
    }
}

#if os(iOS)
public extension SystemKeyboard {
    
    @available(*, deprecated, message: "Use the toolbar-based controller to customize the toolbar instead. WARNING! This will produce incorrect results here.")
    init(
        controller: KeyboardInputViewController,
        autocompleteToolbar: SystemKeyboard.AutocompleteToolbarMode,
        renderBackground: Bool
    )
    where ButtonContent == StandardButtonContent,
    ButtonView == StandardButtonView,
    EmojiKeyboard == StandardEmojiKeyboard,
    Toolbar == StandardToolbarView
    {
        self.init(
            state: controller.state,
            services: controller.services,
            renderBackground: renderBackground,
            buttonContent: { $0.view },
            buttonView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { $0.view }
        )
    }
}
#endif
