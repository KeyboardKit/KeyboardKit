# Views and components

KeyboardKit comes with a bunch of built-in view and components that help you build both custom keyboards and keyboards that mimic a system keyboard.

From KeyboardKit 3.0, `SwiftUI` will be the main focus moving forward.


## SwiftUI

KeyboardKit has many SwiftUI views that can be composed into SwiftUI-based keyboards. For instance:

* `KeyboardGrid` can be used to list actions in a grid with a certain number of `columns`. 
* `KeyboardImageButton` shows an image with a tap and long press action.
* `NextKeyboardButton` switches to the next system keyboard when it is tapped and opens a system keyboard menu when it is pressed.
* `SystemKeyboardBottomRow` mimicks a system keyboard bottom row that is used for alphabetic, numeric and symbolic system keyboards.
* `SystemKeyboardButton` mimicks the system keyboard buttons that are used in all system keyboards.

Since these views are regular views, you can use them in your hosting application as well, provided that is also uses SwiftUI.

Take a look in `KeyboardKitSwiftUI` for a complete list of components. 

You can also check out `KeyboardKitSwiftUI`, since SwiftUI uses different views.


## UIKit

KeyboardKit has many UIKit views that can be composed into UIKit-based keyboards:

* `KeyboardButtonView` implements `KeyboardButton`. It's a regular `UIButton` that can be setup with a primary and secondary action. 
* `KeyboardSpacerView` implements `KeyboardButtonRowComponent`. It's a regular `UIView` that can be used to add additional spaces between components in a button row.
* `KeyboardButtonRow` implements `KeyboardStackViewComponent` and displays buttons horizontally within its `buttonStackView`. The stack view is a regular `UIStackView` that can be customized in any way you like. 
* `KeyboardToolbar` implements `KeyboardStackViewComponent` and displays views horizontally within its `stackView`. The stack view is a regular `UIStackView` that can be customized in any way you like. 
* `KeyboardCollectionView` implements `KeyboardStackViewComponent`. It's a regular `UICollectionView` that can be customized in any way you like. However, since it contains very little logic, you can use the `KeyboardButtonCollectionView` and `KeyboardButtonRowCollectionView` subclasses to get more features out of the box.

Since these views are regular views, you can use them in your hosting application as well.

SInce layout is much more complicated in UIKit than in SwiftUI, KeyboardKit also has many UIKit component that can be composed into UIKit-based keyboards:

* `VerticalKeyboardComponent` describe components that can be added to a vertical flow, e.g. a vertical stack view. It has a height constraint that.
* `HorizontalKeyboardComponent` describe components that can be added to a horizontal flow, e.g. a horizontal stack view. It has a width constraint.
* `KeyboardStackViewComponent` specializes `VerticalKeyboardComponent` and describe components that can be added to the main `keyboardStackView`.
* `KeyboardToolbarComponent` specializes `HorizontalKeyboardComponent` and describe components that can be added to toolbars.
* `PagedKeyboardComponent` can be implemented by any view that display pages of keyboard buttons, e.g. collection views. It has functionality for persisting and restoring the current page index.

Take a look in `UIKit/Views` and `UIKit/Components` for a complete list of views and components.
