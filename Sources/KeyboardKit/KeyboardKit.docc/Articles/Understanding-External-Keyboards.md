# Understanding External Keyboards

This article describes the KeyboardKit external keyboard engine.

[KeyboardKit Pro][Pro] unlocks ways to detect whether or not an external keyboard is connected to the device, including support for the Smart Keyboard Folio, Magic Keyboard, Bluetooth keyboards etc.


## 👑 Pro features

KeyboardKit has an `ExternalKeyboardContext` that lets you detect whether or not an external keyboard is connected to the device. To use it, just set it up as an observed object:

```swift
struct CustomKeyboardView: View {

   @StateObject
   var context = ExternalKeyboardContext()

   var body: some View {
       VStack {
           Text("Is an external keyboard connected?")
           Text(stateDescription)
       }.environmentObject(context)
   }

   var stateDescription: String {
       context.isExternalKeyboardConnected.description
   }
}
```

You can also make your input controller create the context and inject into the view hierarchy, if you need to use it elsewhere.

> Warning: When using a Apple Smart Keyboard Folio, this context will consider the keyboard to be connected even when it's just snapped on to the device, even when it's not actively being used. This should be fixed.


### Important about external keyboards

Your keyboard extension will start behaving strangely when you type on an external keyboard.

For instance, the extension will stop receiving information about when the text changes. This will make it very hard to e.g. provide autocomplete suggestions. Checking the text with a scheduled timer doesn't help, since the text document proxy will also not update.

One way to force the proxy to update is to move the text cursor, but doing this may interfere with the typing. Imagine typing when the cursor suddenly moves one step back, then forward again.

Due to this limitation, it may be better to collapse the keyboard to a compact toolbar when an external keyboard is connected. You can always add a button that expands the keyboard again, if the user still wants to use it.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
