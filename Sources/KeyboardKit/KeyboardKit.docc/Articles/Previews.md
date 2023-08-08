# Previews

This article describes the KeyboardKit preview engine.

KeyboardKit has `.preview` aliases for various state and service types, for instance ``KeyboardContext``.``KeyboardContext/preview`` and ``KeyboardActionHandler``.``KeyboardActionHandler/preview``.

[KeyboardKit Pro][Pro] specific features, such as the convenient system keyboard previews, are described at the end of this document.


## How to use preview-specific state and services

KeyboardKit has convenient preview variants of many services and state. 

For instance, consider this view that takes a ``KeyboardActionHandler`` as init parameter and looks for a ``KeyboardContext`` in the environment:

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

To preview this view, you can just inject a ``KeyboardActionHandler/preview`` action handler in the initializer and a ``KeyboardContext/preview`` context as an environment object:

```swift
struct CustomView_Previews: PreviewProvider {

    static var previews: some View {
        CustomView(actionHandler: .preview)
            .environmentObject(KeyboardContext.preview)
    }
}
```


## 👑 Pro features

KeyboardKit Pro unlocks powerful tools to preview system keyboards and keyboard themes.


### System Keyboard Previews

You can use a `SystemKeyboardLivePreview` to preview a system keyboard. 

This preview can be configured with custom layout and style provider, which makes it possible to preview your custom configuration.

There is also a `SystemKeyboardLivePreviewHeader` that lets you use the preview as a scroll or list view header.


### Keyboard Theme Previews

You can use a `SystemKeyboardThemePreview` to preview how a system keyboard will render a theme. 

This preview can be configured with custom theme, layout and style provider, which makes it possible to preview your custom configuration.

There is also a `SystemKeyboardThemePreviewHeader` that lets you use the preview as a scroll or list view header.


### Performance considerations

Since these previews use a real system keyboard, they're quite heavy to render, so only use a single live preview at a time.

To preview many themes at once, you can use the more lightweight `KeyboardThemeButtonPreview` view, which renders one or multiple keys with the theme's background.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
