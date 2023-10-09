# Understanding Previews

This article describes the KeyboardKit preview engine.

Interactive SwiftUI previews are a great way to work on your project in Xcode without having to launch an app all the time. Just update your views and models, and the live preview will update.

KeyboardKit has preview-configured service and state instances, that can be used in your interactive previews. This makes it easy to set up and preview your keyboard-specific functionality directly in Xcode.

[KeyboardKit Pro][Pro] unlocks powerful system keyboard and theme previews when you register a valid license key. Information about Pro features can be found at the end of this article.



## KeyboardPreviews namespace

KeyboardKit has a ``KeyboardPreviews`` namespace that contains preview-related services and state. In case you wonder, the name doesn't match the group name, since "Previews" conflict with SwiftUI.

For instance, ``KeyboardContext``.``KeyboardContext/preview`` can be used as a dummy context, and ``KeyboardInputViewController``.``KeyboardInputViewController/preview`` as a dummy controller. This simplifies creating previews for views that require KeyboardKit components.

All these services and state variants have static `.preview` properties, so you don't have to use the `KeyboardPreviews.` namespace prefix or the full preview type name to access them.

The namespace doesn't contain protocols, open classes or types that are meant to be top-level ones. It's meant to contain types used by top-level types, to make the library easier to overview.



## How to use preview-specific state and services

Consider this view, that takes a ``KeyboardActionHandler`` init parameter and looks for a ``KeyboardContext`` in the environment:

```swift
struct CustomView {

    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    var actionHandler: KeyboardActionHandler

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        VStack {
            Button("Trigger backspace") {
                actionHandler.handle(.release, on: .backspace)
            }
            Button("Delete text in the proxu") {
                context.textDocumentProxy.deleteBackwards()
            }
        }
    }
}
```

To preview this view, just inject a ``KeyboardActionHandler/preview`` action handler in the initializer and a ``KeyboardContext/preview`` keyboard context as an environment object:

```swift
struct CustomView_Previews: PreviewProvider {

    static var previews: some View {
        CustomView(actionHandler: .preview)
            .environmentObject(KeyboardContext.preview)
    }
}
```

If you need your preview to use the same instance in multiple places, just move them out to preview scope:

```swift
struct CustomView_Previews: PreviewProvider {

    static var context = KeyboardContext.preview

    static var previews: some View {
        VStack {
            CustomView(actionHandler: .preview)
                .environmentObject(context)
            Text("Locale ID: \(context.locale.identifier)")
        }
    }
}
```

You can take a look at the source code of the various views in the library for inspiration.



## 👑 Pro features

KeyboardKit Pro unlocks powerful tools to preview system keyboards and keyboard themes:

```swift
SystemKeyboardPreview(...)              // A live system keyboard preview.
SystemKeyboardPreviewHeader(...)        // A live system keyboard preview header.
SystemKeyboardThemePreview(...)         // A live theme preview.
SystemKeyboardThemePreviewHeader(...)   // A live theme preview header.
```

Since these views render system keyboards with full interation, they are quite performance demanding. 

To preview many styles or themes at once, you can use these more lightweight previews:

```swift
SystemKeyboardButtonPreview(...)        // A system button preview.
SystemKeyboardButtonThemePreview(...)   // A system button preview for a theme.
```

These previews only render lightweight buttons. See <doc:Essentials> for more information.

> Note: These previews are *not* in the **KeyboardPreviews** namespace, since they are meant to be used in apps as well. They are however mentioned here, since it may be the most obvious place to look.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
