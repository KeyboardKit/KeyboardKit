# Components

Components are protocols that describe various types of components that can be composed into a complete keyboard.

* `VerticalKeyboardComponent` describe components that can be added to a vertical flow, e.g. a vertical stack view. It has a height constraint that resizes the component correctly within the flow.

* `HorizontalKeyboardComponent` describe components that can be added to a horizontal flow, e.g. a horizontal stack view. It has a width constraint that resizes the component correctly within the flow.

* `KeyboardStackViewComponent` specializes `VerticalKeyboardComponent` and describe components that can be added to the main `keyboardStackView`.

* `KeyboardButtonRowComponent` specializes `HorizontalKeyboardComponent` and describe components that can be added to button rows.

* `KeyboardButton` specializes `KeyboardButtonRowComponent` and describe a keyboard button that has a primary and secondary action. It also provides standard tap, press and release animations.

* `KeyboardToolbarComponent` specializes `HorizontalKeyboardComponent` and describe components that can be added to toolbars.

* `PagedKeyboardComponent` can be implemented by any view that display pages of keyboard buttons, e.g. collection views. It has functionality for persisting and restoring the current page index.

You can use these components to create modular keyboards.