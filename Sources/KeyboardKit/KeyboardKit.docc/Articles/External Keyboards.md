# External Keyboards

This article describes the KeyboardKit external keyboard engine.

KeyboardKit lets you detect whether or not an external keyboard is used, including the Smart Keyboard Folio, Magic Keyboard, Bluetooth keyboards etc.



## How to detect an external keyboard

KeyboardKit has an ``ExternalKeyboardContext`` that lets you detect whether or not an external keyboard is connected to the device. To use it, just set it up as an observed object:

```swift
struct CustomKeyboardView: View {

    unowned var controller: KeyboardInputViewController

    @StateObject
    private var externalContext = ExternalKeyboardContext()

    var body: some View {
        SystemKeyboard(
            inputViewController: controller
        ).environmentObject(externalContext)
    }
}
```

You can also make your `KeyboardInputController` create the context and inject into the view hierarchy, if you need to use it elsewhere.



## Current limitations

The ``ExternalKeyboardContext`` can currently detect if a keyboard is connected or not. 

Since the Smart Keyboard Folio can be inactive (folded back) while connected, the context will currently not tell if the keyboard is active or not, only if it's connected.

If you know how to differ between being connected and active, please send a PR.
