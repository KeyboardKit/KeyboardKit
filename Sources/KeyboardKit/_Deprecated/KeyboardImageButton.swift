import SwiftUI

@available(*, deprecated, message: "This view is deprecated and will be removed in the next major version.")
public struct KeyboardImageButton: View {
    
    /**
     Create a keyboard image button that uses the `image` of
     the provided `KeyboardAction`, if it has one.
     */
    public init(
        action: KeyboardAction,
        tapAction: @escaping () -> Void = {},
        longPressAction: @escaping () -> Void = {}
    ) {
        self.image = action.image ?? Image("")
        self.tapAction = tapAction
        self.longPressAction = longPressAction
    }
    
    /**
     Create a keyboard image button with a custom `Image`.
     */
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
