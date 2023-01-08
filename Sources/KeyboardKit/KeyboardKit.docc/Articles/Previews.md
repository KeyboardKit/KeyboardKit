# Previews

This article describes how KeyboardKit makes it easy to preview keyboard-specific views.


## How to use preview-specific state and services

KeyboardKit has a collection of preview-specific state and services that you can use in your previews:

* ``ActionCalloutContext``.``ActionCalloutContext/preview``.
* ``CalloutActionProvider``.``CalloutActionProvider/preview``.
* ``InputCalloutContext``.``InputCalloutContext/preview``.
* ``InputSetProvider``.``InputSetProvider/preview``.
* ``KeyboardActionHandler``.``KeyboardActionHandler/preview``.
* ``KeyboardAppearance``.``KeyboardAppearance/preview``.
* ``KeyboardContext``.``KeyboardContext/preview``.
* ``KeyboardInputViewController``.``KeyboardInputViewController/preview``.
* ``KeyboardLayout``.``KeyboardLayout/preview``.
* ``KeyboardLayoutProvider``.``KeyboardLayoutProvider/preview``.
* ``UITextDocumentContext``.`preview`.

If the view you want to preview uses one of these types, you can just use `.preview`.

For instance, consider this view that takes an action handler as init parameter and looks for the keyboard context in the environment:

```swift
struct MyView {

    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    actionHandler: KeyboardActionHandler

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        VStack {
            Button("Trigger backspace") {
                actionHandler.handle(.tap, on: .backspace)
            }
            Button("Delete text in the proxu") {
                context.textDocumentProxy.deleteBackwards()
            }
        }
    }
}
```

In your preview, you can just inject ``KeyboardActionHandler/preview`` in the initializer and ``KeyboardContext/preview`` as an environment object:

```swift
struct MyView_Previews: PreviewProvider {

    static var previews: some View {
        MyView(actionHandler: .preview)
            .environmentObject(KeyboardContext.preview)
    }
}
```

Although using environment objects is convenient, KeyboardKit doesn't use environment objects since they make for hard to discover dependencies. As such, you will never have to inject environment objects to preview views in KeyboardKit.
