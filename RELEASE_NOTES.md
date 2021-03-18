# Release Notes

KeyboardKit tries to honor the following rules when new versions are released:

* Only deprecate code in `minor` versions.
* Only remove deprecated code in `major` versions.
* Avoid introducing breaking changes in `minor` versions. 

Breaking changes can still occur in minor versions, if the alternative is to not release new critical features.


## 4.1

[Milestone](https://github.com/KeyboardKit/KeyboardKit/milestone/30).

### ✨ New features:

* `AutocompleteSuggestion` has new `isAutocomplete` and `isUnknown` properties.
* `AutocompleteSuggestionProvider` has new functions for ignoring and learning words.
* `AutocompleteToolbar` has a new `itemBuilder` initializer.
* `AutocompleteToolbarItem` is a new view that replicates a native autocomplete item.
* `AutocompleteToolbarItemText` is a new view that replicates the text of a native autocomplete item.
* `KeyboardAction` has a new `shouldApplyAutocompleteSuggestion` property.
* `KeyboardLocale` now implementes `Identifiable`.
* `KeyboardLocale` has new `flag`, `id` and `localeIdentifier` properties.
* `KeyboardInputViewController` has a new `autocompleteSuggestionProvider` property.
* `KeyboardInputViewController` has now implemented `performAutocomplete` and `resetAutocomplete`.
* `SystemKeyboardSpaceButtonContent` has a new initializer that lets you inject a custom space view.
* `UITextDocumentProxy` has a new `insertAutocompleteSuggestion` function.
* `UITextDocumentProxy` has a new `isOpenAlternateQuotationBeforeInput(for:)` function.
* `UITextDocumentProxy` has a new `isOpenQuotationBeforeInput(for:)` function.

### ✨ Changed behavior

* `KeyboardInputViewController` now uses combine observation to keep locale in sync.

### 🚚 Renamed:

* `AutocompleteSuggestion+replacement` has been renamed to `text`.
* `AutocompleteToolbar+ButtonBuilder` has been renamed to `ItemBuilder`.


static func standardButton(for suggestion: AutocompleteSuggestion) -> AnyView {
    AnyView(AutocompleteToolbarItem(suggestion: suggestion))
}

* `KeyboardLocale+key` has been renamed to `id`.
* `LocaleKey` has been renamed to `KeyboardLocale`.

### 🗑 Deprecated (removed in 5.0):

* `AutocompleteSuggestion+replacement` has been deprecated due to the name change above.
* `AutocompleteToolbar` - the `buttonBuilder` item  has been deprecated and replaced with the `itemBuilder` one.
* `LocaleKey` has been deprecated due to the name change above.
* `KeyboardLocale+key` has been deprecated.
* `KeyboardInputViewController+changeKeyboardLocale` has been deprecated.
* `KeyboardInputViewController+changeKeyboardType` has been deprecated.

### 💥 Breaking changes:

* `AutocompleteSuggestionProvider` has new properties and functions that must be implemented. If you have an instance that breaks, just create dummy implementations that does nothing.



## 4.0.3

### 🐛 Bug fixes

This patch fixes a bug with the numeric/symbolic auto-switch back to alphabetic, that could cause a keyboard to get stuck in alpha.



## 4.0.2

This patch fixes a few minor things.

### 🌐 Localization

* Italian localization has been added.
* German localization has been added.
* `.done` was accidentally missing a localized text.


### 🐛 Bug fixes

* English, German and Italian keyboards used an invalid double quote key text.
* Title1 font is now used for input keys with two characters, e.g. Swedish "kr" currency.
* Numeric and symbolic keyboards didn't auto-switch to alphabetic when tapping space.



## 4.0.1

This patch fixes a few minor things:

### ✨ New features

* `LocaleKey` now implements `CaseIterable`.

### 🚑 Critical fixes

* `StandardKeyboardActionHandler` had a memory leak that has been fixed.



## 4.0

[Milestone](https://github.com/danielsaidi/KeyboardKit/milestone/16?closed=1).

SwiftUI: Rising. In the shadows no more! 

It's time for `SwiftUI` to rise and become the unrelenting force we always knew it would become. 

`KeyboardKitSwiftUI` has been merged into this repository and the deployment target is raised to `iOS 13`. 

SwiftUI support is a first-class citizen from now on. `UIKit` support is still around, but will no longer be actively developed. The future is a bright, declarative one!

Although these release notes aim at covering everything that has changes in this major version, some things will most probably be missed.


### ✨ New features

Besides the new things listed below, there are a bunch of new extensions, images etc. 

* `Callouts` has new types and providers for working with callouts.
* `Image.emoji` no longer requires iOS 14, but uses `person.crop.circle` as fallback on iOS 13.
* `Input` has new types and providers for working with keyboard layouts.
* `KeyboardAction` has new actions - `go`, `nextLocale`, `ok` and `return`.
* `KeyboardAction` has new, localized standard button texts for some actions.
* `KeyboardAction` has new `isPrimaryAction` property.
* `KeyboardAction` has new `standardButtonFontWeight` property.
* `KeyboardAppearance` has a new `image(for:)`.
* `KeyboardCasing` has a new `neutral` case that can be used to show the original state of the inputs.
* `KeyboardContext` has a new  `locales` list and a new `selectNextLocale` function.
* `KeyboardGesture` has new `press` and `release` gestures.
* `KeyboardInput` is a new input type that simplifies building unicode-based keyboards.
* `KeyboardInputSet` is now based on `KeyboardInput`s instead of strings.
* `KeyboardInputViewController` has a new static `shared` instance.
* `KeyboardInputViewController` has a new `keyboardActionHandler`.
* `KeyboardInputViewController` has a new `keyboardAppearance`.
* `KeyboardInputViewController` has a new `keyboardBehavior`.
* `KeyboardInputViewController` has a new `keyboardContext`.
* `KeyboardInputViewController` has a new `keyboardInputCalloutContext`.
* `KeyboardInputViewController` has a new `keyboardInputSetProvider`.
* `KeyboardInputViewController` has a new `keyboardLayoutProvider`.
* `KeyboardInputViewController` has a new `keyboardSecondaryInputActionProvider`.
* `KeyboardInputViewController` has a new `keyboardSecondaryInputCalloutContext`.
* `KeyboardInputViewController` `setup(with:)` is now open and overridable.
* `KeyboardEnabledState` is a new observable class that keeps in sync with the keyboard enabled state.
* `KeyboardLayoutProvider` has a new `register(inputSetProvider:)` to simplify changing global input set provider.
* `Layout` has new types and providers for working with keyboard layouts.
* `Locale` is a new namespace with a few new locale-specific utils.
* `LocaleDictionary` is a simple dictionary wrapper to work with localized resources.
* `LocaleKey` is a simple enum to gather top-level locale identifiers.
* `KKL10n` is a new enum that provides localized strings from KeyboardKit.
* `SystemKeyboard` now highlights buttons when typing on iPad.
* `View` has new `keyboardInputViewController` convenience extensions.
* `View+keyboardToast` has new context-based function.
* `View+localeContextMenu` can be applied to any view to let the user change locale.
* There are new preview-specific implementations that can help you preview keyboard-based views.


### ✨ Changed behavior

* `AutocompleteContext` is now an observable object and not a protocol.
* `AutocompleteToolbar` is now generic, which makes your .
* `AutocompleteToolbar` now uses identifiable bar items, which leads to better separator handling.
* `AutocompleteToolbar` now takes suggestions at init and doesn't require an environment injected `AutocompleteContext`. 
* `AutocompleteToolbar` no longer requires an environment injected `ObservableKeyboardContext`, nor does its builder functions.
* `EmojiCategory` now uses the `Emoji` type instead of a char.
* `FrequentEmojiProvider` now uses the `Emoji` type instead of a char.
* `KeyboardAction` `standardButtonFont` has been coverted to a function.
* `KeyboardAction` `standardButtonText` has been coverted to a function.
* `KeyboardAction` `standardButtonTextStyle` has been coverted to a function.
* `KeyboardAction.emoji` now uses the `Emoji` type instead of a char.
* `KeyboardAction.emojiCategory` no longer has a  standard tap action.
* `KeyboardActionRow` `standardButtonImage` no longer takes a context.
* `KeyboardBehavior` no longer takes a context as function input.
* `KeyboardContext` is now an observable object and not a protocol.
* `KeyboardContext` no longer has any services, just inspectable properties.
* `KeyboardGestures` now handles the new press and release gestures.
* `KeyboardInputSetProvider` implementations now provides punctuation as well.
* `KeyboardInputSetProvider` no longer takes a context as function input.
* `KeyboardInputViewController` `context` is now an `ObservableKeyboardContext`.
* `KeyboardInputViewController` `context` is now called `keyboardContext`.
* `SecondaryCalloutActionProvider` no longer takes a context as function input.
* `SecondaryInputCalloutContext` no longer requires a context init parameter.
* `StandardKeyboardActionHandler` no longer depends on an input view controller.
* `StandardKeyboardActionHandler` now requires an injected keyboard context and behavior.
* `StandardKeyboardActionHandler` now requires an injected autocomplete and keyboard change action.
* `StandardKeyboardActionHandler` now handles the new press and release gestures.
* `StandardKeyboardActionHandler` `triggerAutocomplete` is replaced by an injectable function.
* `StandardKeyboardAppearance` will use `isPrimaryAction` to apply a blue color to those actions.
* `StandardKeyboardAppearance` will fallback to the action's standard font weight instead of `nil`.
* `StandardKeyboardBehavior` now requires an injected keyboard context.
* `StandardKeyboardInputSetProvider` now requires an injected keyboard context.
* `View+KeyboardGestures` now handles the new press and release gestures.


### 🚚 Removed/renamed

* All unused extensions have been removed.
* All previous deprecations have been removed.
* All internal-only used extensions have been made internal.
* `InputCalloutContext.shared` has been removed. Use the environment object instead.
* `KeyboardAction+SecondaryCalloutActions` has been replaced with new `Callouts/Providers` providers.
* `KeyboardActionRow` has been removed, since it's confusing to have two aliases for the same thing.
* `KeyboardAppearance` button properties are prefixed with `button`.
* `KeyboardAppearance` `font` and `fontWeight` have been merged into a single `font` property.
* `KeyboardAppearanceProvider` has been renamed to `KeyboardAppearance`.
* `KeyboardButtonWidth` has been renamed to `KeyboardLayoutWidth`.
* `KeyboardContext` `actionHandler` has been moved to the input vc.
* `KeyboardContext` `keyboardAppearanceProvider` has been moved to the input vc.
* `KeyboardContext` `keyboardBehavior` has been moved to the input vc.
* `KeyboardContext` `keyboardInputSetProvider` has been moved to the input vc.
* `KeyboardContext` `keyboardLayoutProvider` has been moved to the input vc.
* `KeyboardDimensions` is no longer used and has been removed.
* `KeyboardInputSet` locale extensions have been removed.
* `KeyboardInputSet` standard input set extensions have been removed.
* `KeyboardInputViewController` `addKeyboardGestures` has been converted to `KeyboardButton+Gestures`.
* `KeyboardInputViewController` `context` has been renamed to `keyboardContext`.
* `KeyboardInputViewController` `keyboardType` has been removed - use the context directly!
* `KeyboardInputViewController` `setupKeyboard` has been removed and moved to the UIKit demo.
* `KeyboardInputViewController+Gestures` has been converted to `KeyboardButton+Gestures`.
* `KeyboardLayout` `actionRows` has been renamed to `items` and are of a new `KeyboardLayoutItemRows` type.
* `KeyboardCasing` has been renamed to `KeyboardCasing`
* `KeyboardStateInspector` has been renamed to `KeyboardEnabledStateInspector`.
* `ObservableAutocompleteContext` has been renamed to `AutocompleteContext`.
* `ObservableKeyboardContext` has been renamed to `KeyboardContext`. 
* `PhotosImageService` and `StandardPhotosImageService` have been removed.
* `Settings` has been entirely removed.
* `SecondaryInputCalloutContext.shared` has been removed. Use the environment object instead.
* `StandardKeyboardContext` has been replaced by `ObservableKeyboardContext`.
* `StandardKeyboardActionHandler` has a new vc-based initializer.
* `StandardKeyboardActionHandler` no longer takes an optional sender for keyboard actions.
* `StandardKeyboardActionHandler` gesture actions has been gathered in a single `action(for:on)`.
* `StandardKeyboardAppearanceProvider` has been renamed to `StandardKeyboardAppearance`.
* `StandardKeyboardLayoutProvider` no longer has left and right space actions. Implement this in a custom provider instead.
* `SystemKeyboardDimensions` is no longer used and has been removed.
* `UIImage+pasteboard` has been moved to the demo.
* `UIImage+photos` has been moved to the demo.
* `UIImage+resized` has been removed.
* `UIImage+tinted` has been removed.
* `UIInputViewController+NextKeyboard` has been made an internal extension in `UIView+Keyboard`.
* `View+Button` "standard button" functions have been replaced by a single `keyboardButtonStyle` function.
* `View+ClearInteractable` has been removed.
* `View` `keyboardAction(...)` has been renamed to `keyboardGestures(for: ...)`.
* `UIEdgeInsets+Keyboard` `standardKeyboardButtonInsets` has been renamed to `standardKeyboardButtonInsets`.


### 💥 UIKit changes

In this version, `UIKit` is replaced by `SwiftUI` as the primary layout engine.

As such, to avoid `UIKit` parts blocking SwiftUI, types in the `UIKit` folder will be renamed to start with `UI`:

* `AutocompleteToolbarLabel` -> `UIAutocompleteToolbarLabel`
* `AutocompleteToolbarSeparator` -> `UIAutocompleteToolbarSeparator`
* `AutocompleteToolbarView` -> `UIAutocompleteToolbar` (OBS! Name change as well.)
* `HorizontalKeyboardComponent` -> `UIHorizontalKeyboardComponent`
* `KeyboardAlert` -> `UIKeyboardAlert`
* `KeyboardButton` -> `UIKeyboardButton`
* `KeyboardButtonCollectionView` -> `UIKeyboardButtonCollectionView`
* `KeyboardButtonRowCollectionView` -> `UIKeyboardButtonRowCollectionView`
* `KeyboardButtonView` -> `UIKeyboardButtonView`
* `KeyboardButtonRowComponent` -> `UIKeyboardButtonRowComponent`
* `KeyboardCollectionView` -> `UIKeyboardCollectionView`
* `KeyboardToolbarComponent` -> `UIKeyboardToolbarComponent`
* `KeyboardToolbarView` -> `UIKeyboardToolbarView`
* `KeyboardSpacerView` -> `UIKeyboardSpacerView`
* `KeyboardStackViewComponent` -> `UIKeyboardStackViewComponent`
* `PagedKeyboardComponent` -> `UIPagedKeyboardComponent`
* `RepeatingGestureRecognizer` -> `UIRepeatingGestureRecognizer`
* `Shadow` -> `UIShadow`
* `ToastAlert` -> `UIKeyboardToastAlert` (OBS! Name change as well.)
* `VerticalKeyboardComponent` -> `UIVerticalKeyboardComponent`

Their functionality remains intact, however.

There are a new extension as well, as UIKit support moves away from the core layer:

* `UIView+Keyboard` is now used to apply button gestures to a view, instead of having this functionality in the view controller. 



## 3.6.3

This release adds fake protocol implementations, to simplify creating SwiftUI previews.

The release also adds some things for the future:

* `KeyboardButtonWidth` is a new way to express the width of a keyboard button.
* `View+KeyboardButtonWidth` is a new way to apply a width to a keyboard button.

Although not used by the standard keyboards yet, I still wanted to add them before starting working on 4.0.



## 3.6.2

This release rolls back some changes to try improve dark appearance keyboards in SwiftUI. 

Seems like dark appearance can't be detected, since this also enables dark mode. Hopefully this is easier to fix in KK 4.0.



## 3.6.1

This release adds a time threshold to the end sentence action.

This release also fixes so that `CalloutCurve` and `CustomRoundedRect` handles invalid rects.



## 3.6

This release fixes so that the secondary input gesture triggers a tap if there were no secondary actions in the callout.

### New features

* `Emoji` is a new struct that in the future will let us work more with emojis in a more structured and type-safe way.
* `EmojiCategory` now lets you register a `frequentEmojiProvider`, and uses that to populate the frequent category.
* There is a new `EmojiProvider` protocol
* There is a new `FrequentEmojiProvider` protocol
* There is a new `MostRecentEmojiProvider` class
* There is a new `String+Delimiters` extension with word and sentence delimiters.
* There are new `UITextDocumentProxu+Content` extensions to get previous sentences and words.

* `AutocompleteToolbar` has a new, static  `standardReplacement` function.
* `AutocompleteToolbar` has a new, static  `standardReplacementAction` function.
* `AutocompleteToolbar` now lets you provide an optional, custom  `replacementAction` in init.
* `Color+Resources` is a new extension that provides asset-based colors that adapt to dark mode.
* `EmojiCategoryKeyboard` is a new view that lists the emojis of a selected category and a menu.
* `EmojiCategoryKeyboardMenu` is a new view that lets the user select one of multiple categories.
* `EmojiKeyboard` is a new view that renders a set of emojis in a lazy grid. The item action is customizable.

### Behavior changes

* `EmojiCategory` now implements `EmojiProvider`
* `EmojiCategory.frequent` now returns emojis from the `frequentEmojiProvider`.
* `StandardKeyboardActionHandler` now tries to register emojis with the `EmojiCategory` frequent emoji provider.

* `Color+Button` uses the new asset-based colors.
* `SystemKeyboardButtonBody` now only offsets small caps texts.
* The emoji action has a filled standard image instead of an outlined one.
* Due to a secondary callout action bug, the secondary context is now created by the vc.

### Bug fixes

* The `´` accent was accidentally used in standard numeric keyboards. It has now been replaced with `’`, which is the correct one.

### Deprecations

* `KeyboardContext.emojiCategory` has been deprecated. This should be persisted by the view instead.
* `PhotosImageService` and the standard implementation has been deprecated. Copy it to your own project if you want to keep on using it.
* `UIImage+Photos` has been deprecated. Copy it to your own project if you want to keep on using it.

* Some button-specific `Color` extensions have been deprecated.
* `View+keyboardAction(:context:)` has been deprecated. 

### Breaking changes

* `secondaryCalloutInputProvider` has been removed from `KeyboardContext`. It's now only in the secondary context.



## 3.5.2

This release fixes so that the secondary input gesture triggers a tap if there were no secondary actions in the callout.

The release also makes the entire autocomplete button tappable, instead of just the text.



## 3.5.1

This release fixes so that upper-cased chars gets secondary callout actions and that the input callout isn't dismissed if there are no secondary actions.  



## 3.5

This release makes it easier to inject custom views into the `SwiftUI`-based `SystemKeyboard` and `AutocompleteToolbar`. 

There is also a new `SystemKeyboardSpaceButton` which lets you present the current locale before fading to "space".

The release also adds a spacebar drag gesture and deprecates some `haptic` properties as well as some `system` properties in favor of the `standard` naming concept (since the system behavior *is* the standard behavior).

### New features
 
* `AutocompleteSuggestion` is a new protocol that makes the autocomplete provider concept more general.
* `HapticFeedback` has a new `longPressOnSpace` case.
* `KeyboardAppearanceProvider` is a protocol for providing button content and style.
* `KeyboardContext` has a new `keyboardAppearanceProvider` property.
* `StandardKeyboardActionHandler` has new functionality for handling the space drag gesture.
* `StandardKeyboardAppearanceProvider` is a standard appearance provider that returns standard values.

* `SystemKeyboardButtonContent` is new view that extracts content logic from `SystemKeyboardButton`.
* `SystemKeyboardButtonRowItem` can now be created with generic views. 
* `SystemKeyboardSpaceButton` is new view that wraps `SystemKeyboardSpaceButtonContent` and applied a style and gestures to it.
* `SystemKeyboardSpaceButtonContent` is new view that animates between a locale text and a space text.

### Behavior changes

* `HapticFeedback.standard` has almost no haptic feedback now, since that *is* the standard behavior. 
* `SystemKeyboard` now wraps the `buttonBuilder` generated views in a `SystemKeyboardButtonRowItem`.
* `SystemKeyboardButton` now applies a fallback text from the new appearance provider.
* The standard `SystemKeyboard` button builder generates `SystemKeyboardButtonContent` instead of `SystemKeyboardButton`.

### Deprecations

* `HapticFeedback` standard cases have been deprecated, since native keyboards have almost no haptic feedback.
* `KeyboardAction` `systemFont` is renamed to `standardButtonFont`.
* `KeyboardAction` `systemKeyboardButtonText` is renamed to `standardButtonText`.
* `KeyboardAction` `systemTextStyle` is renamed to `standardButtonTextStyle`.
* `KeyboardType` `systemKeyboardButtonText` is deprecated.
* `String` implements `AutocompleteSuggestion` to avoid breaking changes in KK 3.5+. You should provide your own custom types, though.

* `Color` `systemKeyboardButtonBackgroundColorDark` has been renamed to `standardDarkButtonBackgroundColor` 
* `Color` `systemKeyboardButtonBackgroundColorLight` has been renamed to `standardLightButtonBackgroundColor` 
* `Color` `systemKeyboardButtonForegroundColor` has been renamed to `standardButtonForegroundColor` 
* `Color` `systemKeyboardButtonShadowColor` has been renamed to `standardButtonShadowColor`
* `KeyboardAction` `systemKeyboardButtonBackgroundColor` has been renamed to `standardButtonBackgroundColor` 
* `KeyboardAction` `systemKeyboardButtonImage` has been renamed to `standardButtonImage` 
* `KeyboardAction` `systemKeyboardButtonShadowColor` has been renamed to `standardButtonShadowColor`
* `KeyboardCasing` `systemImage` has been renamed to `standardButtonImage`
* `KeyboardCasing` `systemKeyboardButtonImage` was unused and has been deprecated.
* `KeyboardType` `systemKeyboardButtonImage` has been renamed to `standardButtonImage`
* `View` `systemKeyboardButtonStyle` has been renamed to `standardButtonStyle`
* `View` `systemKeyboardButtonBackground` has been renamed to `standardButtonBackground`
* `View` `systemKeyboardButtonFont` has been renamed to `standardButtonFont`
* `View` `systemKeyboardButtonForeground` has been renamed to `standardButtonForeground`
* `View` `systemKeyboardButtonShadow` has been renamed to `standardButtonShadow`

### Breaking changes

* `AutocompleteToolbarView` and `AutocompleteToolbar` now use `AutocompleteSuggestion` instead of `String`. It makes them MUCH more powerful, so I hope this breaking change is acceptable.
* `SystemKeyboardButtonRowItem` has been made generic.
* `SystemKeyboard.ButtonBuilder` now returns an `AnyView` since you may want to use any custom view for any button.


## 3.4.2

This release adds curves and behavior changes to the callout bubbles.

### Behavior changes

* The disabled secondary % callout actions have been re-enabled.
* `CalloutStyle` now applies button frame insets when configured for a system keyboard.
* `InputCallout` has curves between the button area and the callout.
* `InputCalloutContext` has a new `isEnabled` property that is only true for phones, since it should not be displayed on iPads.
* `InputCalloutContext` no longer insets the button rect.
* `SecondaryInputCallout` has curves between the button area and the callout and the design is improved.
* `SystemInputCalloutContext` no longer insets the button rect.

### New features

* `CalloutCurve` is a new shape that can be used to smoothen the two parts of a callout bubble.



## 3.4.1

This release fixes some visual artefacts in the callout bubbles.



## 3.4

From now on, release notes will include changes in both KeyboardKit and KeyboardKitSwiftUI.

This release adds support for input callouts and secondary input callouts.

### New features

This release has new features for secondary callout actions.

* `KeyboardAction+SecondaryCalloutActions` specifies standard, locale-specific secondary callout actions for keyboard actions.
* `KeyboardContext` has a new `secondaryCalloutActionProvider` property.
* `SecondaryCalloutActionProvider` is a protocol for providing secondary callout actions for keyboard actions.
* `StandardSecondaryCalloutActionProvider` is a standard action provider that returns the standard secondary callout actions.

* `CalloutStyle` is a shared style for keyboard button callout.
* `InputCallout` is a callout that can highlight the currently pressed keyboard button.
* `InputCalloutContext` can be used to control `InputCallout` views.
* `InputCalloutStyle` can be used to style `InputCallout` views.
* `SecondaryInputCallout` is a callout that can present secondary actions for the currently pressed keyboard button.
* `SecondaryInputCalloutContext` can be used to control `SecondaryInputCallout` views.
* `SecondaryInputCalloutStyle` can be used to style `SecondaryInputCallout` views.
* `View+InputCallout` can be used to wrap any view in a `ZStack` with a topmost `InputCallout`
* `View+SecondaryInputCallout` can be used to wrap any view in a `ZStack` with a topmost `SecondaryInputCallout`


### Behavior changes

Since the new secondary input callout, which triggers on long press, I have removed the standard long press action for all actions except backspace. 

This also makes standard KeyboardKit keyboards behave more like native iOS keyboards.

* `View+KeyboardGestures` has been extended with gestures for `InputCallout` and `SecondaryInputCallout`.

### Breaking changes

This release also has breaking changes to experimental features.

* `KeyboardInputProvider` has been renamed to `KeyboardInputSetProvider`
* `KeyboardInputSetProvider`s properties are now context-based functions
* `KeyboardContext` `keyboardInputProvider` has been renamed to `keyboardInputSetProvider`
* `ObservableKeyboardContext` `keyboardInputProvider` has been renamed to `keyboardInputSetProvider`



## 3.3

This release contains a bunch of new features that makes the keyboard behave more like the native keyboards when typing, for instance auto-capitalization and auto-lowercasing.

### Keyboard behavior

This release separates action handling from behavior, which I hope makes the code cleaner and easier to test and simplifies reusing behavior outside of an action handling context. 

* `KeyboardBehavior` specifies how a keyboard should behave.
* `StandardKeyboardBehavior` specifies the standard behavior of a western keyboard.

You can create your own behaviors as well as subclass and override parts of the standard behavior.

Note that this is an experimental feature that may have to be revisited before 4.0.

### New features

* `KeyboardContext` has a new `preferredKeyboardType` property.
* `KeyboardContext` has a new `actionBehavior` property.
* `StandardKeyboardBehavior` has caps-lock double tap logic.
* `UITextDocumentProxy` has a new `isCursorAtNewSentence` property.
* `UITextDocumentProxy` has a new `isCursorAtNewWord` property.
* `UITextDocumentProxy` has a new `endSentence` function that removes any space before the cursor, then closes the sentence.
* `UITextDocumentProxy` has a new `sentenceDelimiters` property.
* `UITextDocumentProxy` has a new `wordDelimiters` property.

### Behavior changes

* The caps-lock double tap logic is moved from double-tap on shift to the new keyboard behavior.
* The sentence ending logic is moved from double-tap on space to the new keyboard behavior.
* The sentence ending logic is no longer based on double-tap, which makes it easier to use.
* `KeyboardAction` `standardDoubleTapAction` is not defined for any actions anymore.
* `KeyboardInputViewController` `changeKeyboardType` has no time interval anymore.
* `StandardKeyboardContext` initializer now has a default value for the keyboard type.

### Bug fixes

* The standard keyboard layout has been fixed to use the correct caps-lock button image.

### Deprecations

* `KeyboardAction` `endSentenceAction` has been moved to `UITextDocumentProxy+EndSentence`.
* `KeyboardAction` `standardDoubleTapAction` is not used internally anymore.
* `KeyboardContext` `changeKeyboardType` is not used internally anymore.
* `KeyboardType` `canBeReplaced` is not used internally anymore.
* `StandardKeyboardActionHandler` `handleKeyboardSwitch` is renamed to `handleKeyboardTypeChange`.
* `StandardKeyboardActionHandler` `preferredKeyboardType` has been moved to the keyboard behavior.

These deprecations will be removed in v 4.0.



## 3.2

This release contains improvements to the input set logic:

* There is a new `KeyboardInputProvider` protocol.
* `StandardKeyboardInputProvider` tries to use the current locale (fallback to English) and can be inherited.
* `StaticKeyboardInputProvider` uses three static input sets. 
* `InputSet+English` has been renamed to `InputSet+Locale` and has more sets.
* `InputSet+Locale` extension has support for basic English, German, Italian and Swedish.
* `StandardKeyboardInputProvider` is used by default in the context, but you can change this at anytime.

The release also introduces a new "keyboard layout" concept, where a keyboard layout is an input set with surrounding actions:

* There is a new `KeyboardLayout` struct.
* There is a new `KeyboardLayoutProvider` protocol.
    * `StandardKeyboardLayoutProvider` uses the current context and can be inherited.
    * `StaticKeyboardLayoutProvider` uses a static layout that is provided at init.
* `StandardKeyboardLayoutProvider` is used by default in the context, but you can change this at anytime.

There are new properties in the `KeyboardContext`.

This release also makes it easier to resolve system keyboard dimensions:

* `CGFloat+Keyboard` has utils to resolve the standard keyboard row height.
* `KeyboardStackViewComponent`s use this new standard height as default height.
* `UIEdgeInsets+Keyboard` has utils to resolve the standard keyboard row item insets.
* `KeyboardButtonRowComponent`s use these new standard insets as default insets.

The demos have been updated with these changes.

### Bug fixes:

* The context controller propertis are marked as `@unowned` to fix a memory leak. 

### Deprecations:

* `CGFloat+KeyboardDimensions` is deprecated and will be removed in 4.0.
* `KeyboardContext`'s `controller` is now deprecated and will be removed in 4.0 .Usage is strongly discouraged. Use the context instead. 

### Breaking:

* `KeyboardContext` has new properties to make the new input and layout additions possible. If you have created your own context, you will have to add these.



## 3.1.1

This version contains new features:

* `EmojiCategory` is now `Codable`.
* `EmojiCategory` has a `fallbackDisplayEmoji` that is used as system button text if no custom button image used.
* `KeyboardAction` now has a standard tap action for `.emojiCategory`.
* `KeyboardContext` now has an `emojiCategory`  property.



## 3.1

This version contains new protocols and classes:

* `KeyboardInputViewController` has new, empty `performAutocomplete` and `resetAutocomplete` functions that are called by the system at proper times.
* The new `AutocompleteSuggestions` typealias makes the autocomplete apis cleaner.
* There is a new `AutocompleteContext` protocol that can be used to manage suggestions. 
* There is a new `StandardAutocompleteContext` implementation of `AutocompleteContext`.
* There is a new `UITextDocumentProxy` property to check if the proxy cursor is at the end of the current word.

### Bug fixes:

* The "end sentence" action that is used by space double taps, uses the new proxy property to only close when the cursor is at the end of a word.



## 3.0.2

In this version:

* A memory leak was fixed by making all `StandardBookActionHandler` actions use `[weak self]`.
* The UIKit button shadow logic was improved by @jackhumbert.



## 3.0.1

This version fixes a bug, where the globe button that is used by the demo keyboards didn't do anything.

This version also fixes the system image's font weight.



## 3.0

This version removes all previously deprecated parts of the library and adds improved support for SwiftUI and iOS 13.

If you upgrade from an older version to `3.0` and have many breaking changes, upgrading to `2.9` first provides deprecation help that may make the transition easier.


### New functionality

There is a new `KeyboardContext`, which provides important contextual information.
* `StandardKeyboardContext` is the standard, non-observable implementation.
* `ObservableKeyboardContext` is an iOS 13+ required, observable implementation.
* `StandardKeyboardActionHandler` now automatically handles keyboard type switching and only delays if an action has a double-tap action.
* `StandardKeyboardActionHandler` now automatically switches to certain keyboards after certain actions, as defined by `handleKeyboardSwitch(after:on:)` and `preferredKeyboardType(after:on:)`.

There are new `KeyboardAction` types and properties:
* `.control` represents the system.
* `.systemImage` can be used with SF Symbols.
* `.systemFont` and `.systemTextStyle` provide system look information.

There is a new `System` namespace with utils to help you build native-imitating system keyboards.

There is a new `KeyboardInputSet` concept that will simplify building language-specific keyboards. For now, it contains English characters, numerics and symbols. 

The demo project contains a new `KeyboardKitSwiftUIPreviews` in which you can preview KeyboardKitSwiftUI views. 


### SwiftUI

* This repository has a new SwiftUI-based demo app, which is still in development.
* `KeyboardImageButton` supports the new `systemImage` action.


### Non-breaking changes:

* `KeyboardInputViewController` `deviceOrientation` has been converted to a general `UIInputViewController` extension.
* `setupNextKeyboardButton` has been converted to a general `UIInputViewController` extension.


### Breaking changes:

* `KeyboardInputViewController` has a new `keyboardContext` property.
* `StandardKeyboardContext` is used by default, whenever a keyboard extension is created.
* `ObservableKeyboardContext` is used by whenever a keyboard switches over to use SwiftUI.

* `KeyboardInputViewController` `keyboardActionHandler` has been moved to `KeyboardContext`.
* `KeyboardInputViewController` `canChangeKeyboardType` has been moved to `KeyboardType`.
* `KeyboardInputViewController` `changeKeyboardType` has been moved to `KeyboardContext`.
* `KeyboardInputViewController` `changeKeyboardTypeDelay` is now an argument in `changeKeyboardType`.
* `KeyboardInputViewController` `keyboardType` has been moved to the context.

* `AutocompleteToolbar` has been renamed to `AutocompleteToolbarView`.
* `EmojiCategory.frequents` has been renamed to `frequent`.
* `KeyboardActionHandler` now requires `canHandle(_:on:)` to be implemented.
* `KeyboardAction` has new action types.
* `KeyboardAction` has fewer `isXXX` properties.
* `KeyboardAction` `.capsLock` and `shiftDown` are now part of `KeyboardAction.shift`.
* `KeyboardActionRow.from` has been changed to an initializer.
* `KeyboardActionRows.from` has been changed to an initializer.
* `KeyboardImageActions` has been converted to a `KeyboardActionRow+Images` extension initializer.
* `KeyboardToolbar` has been renamed to `KeyboardToolbarView`. 
* The `shouldChangeToAlphabeticLowercase` has been replaced with the automatic switching mentioned above.
* The `isKeyboardEnabled` function now uses a `for` as external argument name.


### Removed, previously deprecated parts:

* `AutocompleteBugFixTimer`
* `AutocompleteSuggestionProvider` `provideAutocompleteSuggestions`
* `KeyboardAction` `switchKeyboard`
* `KeyboardAction` `switchToKeyboard`
* `KeyboardAction` `standardInputViewControllerAction`
* `KeyboardAction` `standardTextDocumentProxyAction`
* `KeyboardActionHandler` `handleTap/Repeat/LongPress`
* `KeyboardActionHandler` `handle` gesture on `UIView`
* `KeyboardInputViewController` `addSwitchKeyboardGesture`
* `PersistedKeyboardSetting` init with key
* `StandardKeyboardActionHandler` `init` with feedback instances
* `StandardKeyboardActionHandler` `action` for view
* `StandardKeyboardActionHandler` `animationButtonTap`
* `StandardKeyboardActionHandler` `giveHapticFeedbackForLongPress/Repeat/Tap`
* `StandardKeyboardActionHandler` `longPress/repeat/tapAction` for view
* `StandardKeyboardActionHandler` `handleLongPress/Repeat/Tap`
* `StandardKeyboardActionHandler` `triggerAudio/HapticFeedback`
* `UIColor` `clearTappable`
* `UIInputViewController` `createAutocompleteBugFixTimer`
* `UIView` `add/removeLongPress/Repeating/TapAction`
* `isKeyboardEnabled` global function



## 2.9.3

This version updates external test dependencies to their latest versions.



## 2.9.2

This version removes the subview fiddling from `KeyboardCollectionVew` to the built-in subclasses, since it can ruin the view hierarchy for collection views that don't add custom views to the cells.



## 2.9.1

This version adds an `.emoji` keyboard action, which can be used if you need to separate characters from emojis.

This version also extracts the logic of `KeyboardAction` `standardTapAction` into:

* `standardTapActionForController`
* `standardTapActionForProxy`

This makes it possible to use the standard function in other ways, should you need it.

This version also makes `actions` of `KeyboardCollectionView` mutable, causing changes to this property to refresh the view.



## 2.9

This is the last minor version before `3.0`, which will remove a bunch of deprecated members.

This version adds more features, fixes some bugs and deprecates many parts of the library.

A big change, which is not fully covered in these notes, is that `KeyboardInputViewController` and `StandardKeyboardActionHandler` now handles changing keyboard types. Even if you have to fill a "type" with meaning in your app, you now have implemented logic to help you handle this.

Thanks to @eduardoxlau, the demo also has an improved emoji keyboard. 

### New features

* `KeyboardAction` has new `standardTap/DoubleTap/LongPress/Repeat` action properties.
* `KeyboardInputViewController` has a new `deviceOrientation` property.
* `KeyboardInputViewController` has a new `keyboardType` property.
* `KeyboardInputViewController` has new `can/changeKeyboardType` functions and properties.
* `KeyboardInputViewController` has a new `setupKeyboard` function.
* `StandardKeyboardActionHandler` has more logic for handling keyboard type changes.
* The new `EmojiCategory` enum represents the native iOS emoji keyboard categories.
* The new `KeyboardStateInspector` can be implemented to get info about the keyboard.

### Changes

* The demo now switches to caps lock when shift is double-tapped.
* The standard tap animation does not scale up as much as before.
* The standard haptic feedback for tap is light impact instead of medium.

### Deprecations

* `KeyboardAction.switchKeyboard` has been renamed to `nextKeyboard`.
* `KeyboardAction.switchToKeyboard` has been renamed to `keyboardType`.
* `KeyboardAction.standardInputViewControllerAction` has been renamed to `standardTapAction`.
* `KeyboardAction.standardTextDocumentProxyAction` is no longer used by the system`.
* `addSwitchKeyboardGesture(to:)` has been renamed to `addNextKeyboardGesture(to:)`.
* The global `isKeyboardEnabled` has been replaced with a new `KeyboardStateInspector` protocol.

### Bug fixes

* Double tap handling for space no longer inserts an additional space.

### Breaking change

* `KeyboardType.alphabetic` now uses a `KeyboardCasing` property instead of a bool for if it's upper-cased or not.
* `KeyboardAction.switchToKeyboard` is now an alias for `keyboardType`. You can still use it when defining actions, but if you switch over `KeyboardAction`, you have to use `keyboardType` instead of `switchToKeyboard`.



## 2.8.1

This version fixes some division by zero bugs.



## 2.8

This version fixes a gesture-related memory leak by no longer using the gesture extensions that caused the problem. Instead, `KeyboardInputViewController` has a new set of internal gesture extensions that helps with adding gestures to a button.

This version also adds double-tap action handling to KeyboardKit. It's handled like taps, long presses and repeating actions, but it has no default logic. To handle it, create a custom action handler and override `handle(_ gesture:,on action:, sender:)`.

KeyboardKit does not put any rules on the gesture handling. If you return an action for both a single tap and a double tap, both will be triggered.


### New features

* A new `.doubleTap` keyboard gesture.

### Deprecations

* The `UIView` `addLongPressAction` extension is deprecated.
* The `UIView` `removeLongPressAction` extension is deprecated.
* The `UIView` `addRepeatingAction` extension is deprecated.
* The `UIView` `removeRepeatingAction` extension is deprecated.
* The `UIView` `addTapAction` extension is deprecated.
* The `UIView` `removeTapAction` extension is deprecated.



## 2.7.4

This version upgrades the podspec's Swift version.



## 2.7.3

This version upgrades its Nimble and Mockery dependencies.



## 2.7.1, 2.7.2

These versions adjust the keyboard settings url.



## 2.7

This version adds the very first (and so far limited) support for `SwiftUI`. Many new features are iOS 13-specific.

This version also deprecates a bunch of action handling logic and adds new functions that doesn't rely on `UIView`.


### New features

* `KeyboardInputViewController` has a new `setupNextKeyboardButton(...)` which turns any `UIButton` into a system-handled "next keyboard" button.
* `NextKeyboardUIButton` makes use of this new functionality, and sets itself up with a `globe` icon as well.
* `PhotoImageService` and `StandardPhotoImageService` can be used to save images to photos with a completion instead of a target and a selector.
* `KeyboardImageActions` makes it easy to create a bunch of `.image` actions from a set of image names.
* `KeyboardActionHandler` has a new `open handle(_ gesture:on:view:)`  which is already implemented in `StandardKeyboardActionHandler`.

* The global `isKeyboardEnabled` function can be used to check if a certain keyboard extension is enabled or not.
* The `keyboardSettings` `URL` extension is a convenience extension for finding the url to application settings.
* The `evened(for gridSize: Int)` `[KeyboardAction]` extension appends enough `.none` actions to evenly fit the grid size.
* The `saveToPhotos(completion:)` `UIImage` extension is a completion-based way of saving images to photos.

### SwiftUI

There are some new views that can be used in SwiftUI-based apps and keyboard extensions:

* `KeyboardGrid` distributes actions evenly within a grid.
* `KeyboardGridRow` is used for each row in the grid.
* `KeyboardHostingController` can be used to wrap any `View` in a keyboard extension.
* `KeyboardImageButton` view lets you show an `.image` action or `Image` in a `Button`.
* `NextKeyboardButton` sets itself up with a `globe` icon and works as a standard "next keyboard" button.
* `PersistedKeyboardSetting` is a new property wrapper for persisting settings in `UserDefaults`. 

* `Color.clearInteractable` can be used instead of `.clear` to allow gestures to be detected.
* `Image.globe` returns the icon that is used for "next keyboard".
* `KeyboardInputViewController` `setup(with:View)`  sets up a `KeyboardHostingController`.
* `View` `withClearInteractableBackground()` can be used to make an entire view interactable.

Note that `KeyboardKitSwiftUI` is a separate framework, which you have to import to get access to these features.

### UIKit

There are some new UIKit features and extensions:

* `NextKeyboardUIButton` sets itself up with a `globe` icon and works as a standard "next keyboard" button.
* `UIImage.globe` returns the icon that is used for "next keyboard".

All UIKit-specific functionality is placed in the `UIKit` folder. UIKit logic that can be used in SwiftUI is outside it.

### Changes:

* `isInputAction` now includes `.space`.
* `isSystemAction` no longer includes `.space`.

### Deprecations

* `UIColor.clearTappable` has been renamed to `UIColor.clearInteractable`.
* `KeyboardActionHandler` has deprecated the gesture-explicit handle functions.
* `KeyboardActionHandler` has deprecated the view-explicit handle function in favor of an optional `Any` sender variant.
* `StandardKeyboardActionHandler` has deprecated a bunch of `UIView`-explicit functions in favor of an optional `Any` sender variant.



## 2.6.2

This version fixes a [bug](https://github.com/danielsaidi/KeyboardKit/issues/60), where `moveCursorForward` moved the cursor incorrectly.



## 2.6.1

This version adds `enableScrolling()` and `disableScrolling()` to `AutocompleteToolbar`. This makes it possible to make the entire toolbar scroll if its content doesn't fit the screen.



## 2.6

This version adds more autocomplete functionality:

* `AutocompleteToolbar` has a new convenience initializer that makes it even easier to setup autocomplete.
* `AutocompleteToolbarLabel` is the default autocomplete item view and can be tapped to send text to the text document proxy.
* `AutocompleteToolbarLabel` behaves like the native iOS autocomplete view and displays centered text until the text must scroll.
* Autocomplete no longer requires the bugfix timer. Instead, just let the action handler request autocomplete suggestions when a tap action is triggered.

The `StandardKeyboardActionHandler` has new functionality:
* `animationButtonTap()` - can be overridden to change the default animation of tapped buttons.

Deprecations:
* The `AutocompleteBugFixTimer` and all timer-related logic has been deprecated.
* The `AutoCompleteSuggestionProvider`'s `provideAutocompleteSuggestions(for:completion:)` is deprecated and replaced with `autocompleteSuggestions(for:completion:)`.
* The `StandardKeyboardActionHandler`'s `handleXXX(on:)` are now deprecated and replaced with `handle(:on:view:)`. 



## 2.5

This version adds a bunch of features, tweaks some behaviors and deprecates some logic:

New stuff:
* There is a new `KeyboardActionGesture` that will be used to streamline the action handling api:s.
* There is a new `AudioFeedback` enum that describes various types of audio feedback.
* There is a new `AudioFeedbackConfiguration` that lets you gather all configurations in one place.
* There is a new `HapticFeedback.standardFeedback(for:)` function that replaces the old specific properties.
* There is a new `HapticFeedbackConfiguration`  that lets you gather all configurations in one place.
* There is a new `StandardKeyboardActionHandler` init that uses this new configuration.
* There is a new `StandardKeyboardActionHandler.triggerAudioFeedback(for:)` that can be used to trigger audio feedback.
* There is a new `StandardKeyboardActionHandler.triggerHapticFeedback(for:on:)` that replaces the old gesture-specific ones.
* There is a new `StandardKeyboardActionHandler.gestureAction(for:)` function that is used by the implementation. The old ones are still around.
* There is a new `KeyboardType.images` case that is used by the demo.

Changed behavior:
* There is a new `standardButtonShadow` `Shadow` property that can be used to mimic the native button shadow.

Deprecated stuff:
* The old `StandardKeyboardActionHandler.init(...)` is deprecated, use the new one.
* The old  `StandardKeyboardActionHandler.giveHapticFeedbackForLongPress(...)` is deprecated, use the new one.
* The old  `StandardKeyboardActionHandler.giveHapticFeedbackForRepeat(...)` is deprecated, use the new one.
* The old  `StandardKeyboardActionHandler.giveHapticFeedbackForTap(...)` is deprecated, use the new one.
* The old `HapticFeedback.standardTapFeedback` and `standardLongPressFeedback` have been replaced by the new function.

The old `handle` functions are still declared in the `KeyboardActionHandler` protocol, but will be removed in the next major version. 



## 2.4

This version adds Xcode 11 and iOS 13 support, including support for dark mode and high contrast color variants.



## 2.3

This version adds autocomplete support, which includes an autocomplete suggestion provider protocol, a new toolbar and new extensions.

The new `AutocompleteSuggestionProvider` protocol describes how to provide your keyboard with autocomplete suggestions. You can implement it in any way you like, e.g. to use a built-in suggestion database or by connecting to an external data source, using network requests. Note that the network option will be a lot slower and also require you to request full access from your users.

The new `AutocompleteToolbar` is a toolbar that can display any results you receive from your suggestion provider (or any list of strings for that matter). Just trigger the provider anytíme the text changes and route the result to the toolbar. The toolbar can be populated with any kind of views. Have a look at the demo app for an example.

The new `UITextDocumentProxy+CurrentWord` extension helps you get the word that is (most probably) being typed. You could use this when requesting autocomplete suggestions, if you only want to autocomplete the current word.

Besides these additions, there are a bunch of new extensions, like `UITextDocumentProxy` `deleteBackwards(times:)`, which lets you delete a certain number of characters. Have a look at the `Extensions` namespace for a complete list.

There is also a new `KeyboardCasing` enum that you can use to keep track of which state your keyboard has, if any. This enum is extracted from demo app code that was provided by @arampak earlier this year. 

 **IMPORTANT** iOS has a bug that causes `textWillChange` and `textDidChange` to not be called when the user types, only when the cursor moves. This causes autocomplete problems, since the current word is not changing as the user types. Due to this, the input view controller must use an ugly hack to force the text document proxy to update. Have a look at the demo app to see how this is done.



## 2.2.1

This version solves some major bugs in the repeating gesture recognizer and makes some `public` parts of the library `open`.

The standard action handler now handles repeating actions for backspace. You can customize this in the same way as you customize tap and long press handling.

You can test the new repeating logic in the demo app.



## 2.2

This version adds more keyboard actions that don't exist in iOS, but that may serve a functional or semantical purpose in your apps:

* `command`
* `custom(name:)`
* `escape`
* `function`
* `option`
* `tab`

The new `custom` action is a fallback that you can use if the existing action set is insufficient for your specific app.

I have added a `RepeatingGestureRecognizer` and an extension that you can use to apply it as well. It has a custom initial delay as well as a custom repeat interval, that will let you tap and hold a button to repeat its action. In the next update, I will apply this to the backspace and arrow buttons.

Thanks to [@arampak](https://github.com/arampak), the demo app now handles shift state and long press better, to make the overall experience much nicer and close to the native keyboard. The keyboard buttons also registers tap events over the entire button area, not just the button view.



## 2.1

This version makes a bunch of previously internal extensions public. It also adds a lot more unit tests so that almost all parts of the library are tested.

The default tap animation has been configured to allow user interaction, which reduces the frustrating tap lag that was present in 2.0.0.

I have added a `KeyboardToolbar` class, which you can use to create toolbars. It's super simple so far, and only creates a stack view to which you can any views you like.



## 2.0.1

This version adds a public shadow extension to the main library and shuffles classes and extensions around. It also restructures the example project to make it less cluttered.

I noticed that the build number bump still (and randomly) bumps the build number incorrectly, which causes build errors. I have therefore abandoned this approach, and instead fixes the build number to 1 in all targets.



## 2.0

This version aim at streamlining the library and remove or refactor parts that make it hard to maintain. It contains several breaking changes, but I hope that the changes will make it easier for you as well, as the library moves forward.

Most notably, the view controller inheritance model has been completely removed. Instead, there is only one `KeyboardInputViewController`. It has a stack view to which you can add any views you like, like the built-in `KeyboardButtonRow` and `KeyboardCollectionView`, which means that your custom keyboards is now based on components that you can combine.

Since `KeyboardInputViewController` therefore can display multiple keyboards at once, it doesn't make any sense to have a single `keyboard` property. You can still use structs to organize your actions (in fact, I recommend it - have a look at the demo app), but you don't have to.

All action handling has been moved from the view controller to `KeyboardActionHandler` as well. `KeyboardInputViewController` use a `StandardActionHandler` by default, but you can replace this by setting `keyboardActionHandler` to any `KeyboardActionHandler`. This is required if you want to use certain actions types, like `.image`.

New `KeyboardAction`s are added and `nextKeyboard` has been renamed to `switchKeyboard`. Action equality logic has also been removed, so instead of `isNone`, you should use `== .none` from now on. All help properties like `image` and `imageName` are removed as well, since they belong in the app. These are the new action types

* capsLock
* dismissKeyboard
* moveCursorBackward
* moveCursorForward
* shift
* shiftDown
* switchToKeyboard(type)

`KeyboardInputViewController` will now resize the extension to the size of the stack view, or any other size constraints you may set. The old `setHeight(to:)` function has therefore been removed.



## 1.0

This version upgrades `KeyboardKit` to Swift 5 and has many breaking changes:

 * `KeyboardInputViewController` has been renamed to `KeyboardViewController`
 * `CollectionKeyboardInputViewController` has been renamed to `CollectionKeyboardViewController`
 * `GridKeyboardInputViewController` has been renamed to `GridKeyboardViewController`
 * `KeyboardAlerter` has been renamed to `KeyboardAlert`
 * `ToastAlerter` has been renamed to `ToastAlert`
 * `ToastAlert` now has two nested view classes `View` and `Label`
 * `ToastAlert`'s two style function has changed signature
 * `ToastAlerterAppearance` is now an internal `ToastAlert.Appearance` struct
 * Most extensions have been made internal, to avoid exposing them externally



## 0.8

`Keyboard` has been given an optional ID, which can be used to uniquely identify a keyboard. This makes it easier to manage multiple keyboards in an app.

`KeyboardInputViewController` implements the `KeyboardPresenter` protocol, which means that you can set the new optional `id` property to make a `KeyboardSetting` exclusive to that presenter. This is nice if your app has multiple keyboards. If you do not specify an id, the settings behave just like before.

A PR by [micazeve](https://github.com/micazeve) is merged. It limits the current page index that is persisted for a keyboard, to avoid bugs if the page count has changed since persisting the value.



## 0.7.1

This version updates KeyboardKit to `Swift 4.2` and makes it ready for Xcode 10.



## 0.7

The grid keyboard view controller uses a new way to calculate the available item space and item size for a certain number of rows and buttons per row. This means that we can now use top and bottom content insets to create vertical margins for grid-based keyboards.



## 0.6.2

I previously used the async image functions to quickly setup a lot of images for "emoji" keyboards. Since I didn't use a collection view for emoji keyboards then, all image views were created at the same time, which caused rendering delays. By using the async image approach, image loading was moved from the main thread and allowed individual images to appear when they were loaded instead of waiting for all images to load before any image could be displayed.

However, `KeyboardKit` now has collection view-based keyboards, which are better suited for the task above, since they only render the cells they need. This will solve the image loading issues, which means that the async image extensions will no longer be needed. I have therefore removed `UIImage+Async` and the `Threading` folder from the library, to keep it as small as possible.



## 0.6.1

No functional changes, just README updates and improvements. The version bump is required to give CocoaPod users the latest docs.



## 0.6

This is a complete rewrite of the entire library. KeyboardKit now targets iOS 11 and the code has been improved a lot. Check out the demo app to see how to setup keyboards from now on.
