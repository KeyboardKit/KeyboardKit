# Understanding Device Utils

This article describes the KeyboardKit device utilities.

These utilities aim to help you use multi-platform device information to customize your keyboards.



## Device type

KeyboardKit has a ``DeviceType`` enum, with platform-agnostic device types.

You can use ``DeviceType/current`` to get the current device type.

Just like with screen size, you should be careful with using the device information, but keyboards sometime need it. 



## Screen sizes

KeyboardKit has `CGSize` utilities to help detecting which kind of hardware you're on, for instance:

```swift
func isLargePad(_ size: CGSize) -> Bool {
    size.isScreenSize(.iPadProLargeScreenPortrait)
} 
```

Although you should be careful with using the screen size, since apps can run in split screen and keyboards can be floating, keyboards sometime need to be able to detect the exact kind of device you're on.



## Interface orientation

KeyboardKit has an ``InterfaceOrientation`` enum, with platform-agnostic types.

You can then use ``InterfaceOrientation/current`` to get the current interface orientation.

Just like with screen size and device type, you should be careful with using the interface orientations, but keyboards sometime need it.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
