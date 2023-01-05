import SwiftUI

#if os(iOS) || os(tvOS)
import Foundation

@available(*, deprecated, renamed: "KeyboardInputComponent")
public typealias KeyboardInputTextComponent = KeyboardInputComponent
#endif

@available(*, deprecated, message: "This view is deprecated and will be removed in the next major version.")
public struct KeyboardImageButton: View {

    public init(
        action: KeyboardAction,
        tapAction: @escaping () -> Void = {},
        longPressAction: @escaping () -> Void = {}
    ) {
        self.image = action.image ?? Image("")
        self.tapAction = tapAction
        self.longPressAction = longPressAction
    }

    public init(
        image: Image,
        tapAction: @escaping () -> Void = {},
        longPressAction: @escaping () -> Void = {}
    ) {
        self.image = image
        self.tapAction = tapAction
        self.longPressAction = longPressAction
    }

    private let image: Image
    private let tapAction: () -> Void
    private let longPressAction: () -> Void

    public var body: some View {
        image
            .resizable()
            .scaledToFit()
            .accessibility(addTraits: .isButton)
            #if os(iOS) || os(macOS) || os(watchOS)
            .onTapGesture(perform: tapAction)
            .onLongPressGesture(perform: longPressAction)
            #endif
    }
}

public extension View {
    
    @ViewBuilder
    @available(*, deprecated, message: "context is no longer needed")
    func keyboardGestures(
        for action: KeyboardAction,
        context: KeyboardContext,
        actionHandler: KeyboardActionHandler,
        isPressed: Binding<Bool> = .constant(false)
    ) -> some View {
        self.keyboardGestures(
            for: action,
            actionHandler: actionHandler,
            isPressed: isPressed)
    }

    #if os(iOS) || os(macOS) || os(watchOS)
    @ViewBuilder
    @available(*, deprecated, message: "Use KeyboardContext-based extension instead.")
    func localeContextMenu<ButtonView: View>(
        locales: [Locale],
        buttonViewBuilder: @escaping (Locale) -> ButtonView
    ) -> some View {
        if locales.count < 2 {
            self
        } else {
            self.contextMenu(
                ContextMenu {
                    ForEach(locales, id: \.identifier) {
                        buttonViewBuilder($0)
                    }
                }
            )
        }
    }
    #endif

    /**
     Apply the size of a `CGSize` to the view.
     */
    @available(*, deprecated, message: "Use the native frame modifier instead")
    func frame(size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
}
