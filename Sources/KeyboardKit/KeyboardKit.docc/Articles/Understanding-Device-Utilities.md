# Understanding Device Utilities

This article describes the KeyboardKit device utilities.

KeyboardKit has platform-agnostic device functionality that aims to help you use device information to customize your keyboards.



## Device type

KeyboardKit has a ``DeviceType`` enum with platform-agnostic device types. You can use ``DeviceType/current`` to get the current device type.

```swift
var isPad: Bool {
    DeviceType.current == .pad
} 
```

Although you should be careful with using device-specific information, some keyboard features need this information. 



## Screen sizes

KeyboardKit has `CGSize` utilities to help detecting which kind of hardware you're on, for instance:

```swift
func isLargePad(_ size: CGSize) -> Bool {
    size.isScreenSize(.iPadProLargeScreenPortrait)
} 
```

You should be careful with using screen size information, since apps can run in split screen and keyboards can be floating. However, some keyboard features need this information.



## Interface orientation

KeyboardKit has an ``InterfaceOrientation`` enum with platform-agnostic types. You can use ``InterfaceOrientation/current`` to get the current interface orientation.

```swift
var isPortrait: Bool {
    InterfaceOrientation.current.portrait
} 
```

Just like with screen size and device type, you should be careful with using the interface orientations. However, some keyboard features need this information.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
