# Previews

This article describes the KeyboardKit preview engine.

SwiftUI previews are a great way to work on your project in Xcode without having to launch an app all the time. Just update your views and models, and the preview will update.

KeyboardKit has preview-specific services and state, that can be used in your previews. This makes it easy to set up and preview your keyboard-specific views directly in Xcode.

[KeyboardKit Pro][Pro] unlocks powerful system keyboard and theme previews. Information about Pro features can be found at the end of this article.



## KeyboardPreviews namespace

KeyboardKit has a ``KeyboardPreviews`` namespace that contains preview-related services and state. The name doesn't match the group name, since "Previews" conflicts with SwiftUI.

For instance, the ``KeyboardContext``.``KeyboardContext/preview`` can be used as a dummy context, and the ``KeyboardInputViewController``.``KeyboardInputViewController/preview`` as a dummy controller. 

These preview-specific services and state simplifies creating previews for views that require KeyboardKit. Just use **.preview** instead of creating a proper instance.



## How to use preview-specific state and services

Consider this view, that takes a ``KeyboardActionHandler`` init parameter and looks for a ``KeyboardContext`` in the environment:

```swift
struct CustomView: View {

    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    private var actionHandler: KeyboardActionHandler

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
#Preview {

    CustomView(actionHandler: .preview)
        .environmentObject(KeyboardContext.preview)
}
```

You can take a look at the source code of the various views in the library for inspiration.



## 👑 Pro features

KeyboardKit Pro unlocks powerful system keyboard previews.

### System Keyboard Preview

KeyboardKit Pro unlocks a **SystemKeyboardPreview** that can be used to preview a ``SystemKeyboard`` with many different configurations, styles and themes.

Use the **keyboardContext** parameter to configure things like locale, keyboard type, etc. and the **layoutProvider** and **styleProvider** to customize the layout and style.

```swift
let context = KeyboardContext.preview
context.setLocale(.turkish)

SystemKeyboardPreview(keyboardContext: context)
```

![System Keyboard Preview - Turkish](systemkeyboardpreview-350.jpg)

You can use the **theme** parameter to easily preview any Pro unlocked **KeyboardTheme**.

```swift
SystemKeyboardPreview(theme: try? .candyShop)
```

![System Keyboard Preview - Theme](systemkeyboardpreview-theme-350.jpg)

Since this view draws a keyboard with full interaction, you shouldn't use many at the same time.


### System Keyboard Preview

KeyboardKit Pro also unlocks a more lightweight **SystemKeyboardButtonPreview** that can be used to preview many styles or themes at once.

![System Keyboard Button Preview](systemkeyboardbuttonpreview-350.jpg)

You can use this view to preview any ``KeyboardAction`` and any Pro **KeyboardTheme**.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
