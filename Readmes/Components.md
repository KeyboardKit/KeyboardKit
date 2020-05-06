# Components

Components are protocols that describe various types of components that can be composed into a complete keyboard. Some components include:

* `VerticalKeyboardComponent` describe components that can be added to a vertical flow, e.g. a vertical stack view. It has a height constraint that.

* `HorizontalKeyboardComponent` describe components that can be added to a horizontal flow, e.g. a horizontal stack view. It has a width constraint.

* `KeyboardStackViewComponent` specializes `VerticalKeyboardComponent` and describe components that can be added to the main `keyboardStackView`.

* `KeyboardToolbarComponent` specializes `HorizontalKeyboardComponent` and describe components that can be added to toolbars.

* `PagedKeyboardComponent` can be implemented by any view that display pages of keyboard buttons, e.g. collection views. It has functionality for persisting and restoring the current page index.

Take a look in `UIKit/Components` for a complete list of components. You can also check out `KeyboardKitSwiftUI`, since SwiftUI uses different components.