# Views

KeyboardKit comes with a bunch of views that implement one or many of the component protocols.

* `KeyboardButtonView` implements `KeyboardButton`. It's a regular `UIButton` that can be setup with a primary and secondary action. 

* `KeyboardSpacerView` implements `KeyboardButtonRowComponent`. It's a regular `UIView` that can be used to add additional spaces between components in a button row.

* `KeyboardButtonRow` implements `KeyboardStackViewComponent` and displays buttons horizontally within its `buttonStackView`. The stack view is a regular `UIStackView` that can be customized in any way you like. 

* `KeyboardToolbar` implements `KeyboardStackViewComponent` and displays views horizontally within its `stackView`. The stack view is a regular `UIStackView` that can be customized in any way you like. 

* `KeyboardCollectionView` implements `KeyboardStackViewComponent`. It's a regular `UICollectionView` that can be customized in any way you like. However, since it contains very little logic, you can use the `KeyboardButtonCollectionView` and `KeyboardButtonRowCollectionView` subclasses to get more features out of the box.

Since these views are regular views, you can use them in your hosting application as well.