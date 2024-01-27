# Device Utilities

This article describes various KeyboardKit device utilities.

KeyboardKit has platform-agnostic device-related features that aim to help you customize your keyboard to various device.

You should avoid designing for a specific device type, interface orientation, or screen size, but some features need these kinds of adjustments.



## Device type

KeyboardKit has a platform-agnostic ``DeviceType`` enum that defines available device types. 

You can use ``DeviceType/current`` to get the current device type.

```swift
let type = DeviceType.current
let isPad = type == .pad
```



## Interface orientation

KeyboardKit has a platform-agnostic ``InterfaceOrientation`` enum. 

You can use ``InterfaceOrientation/current`` to get the current interface orientation.

```swift
let orientation = InterfaceOrientation.current 
let isPortrait = orientation.portrait
```



## Screen sizes

KeyboardKit has `CGSize` utilities to help detecting which kind of hardware you're on, e.g.:

```swift
CGSize.iPadProLargeScreenPortrait/Landscape
CGSize.iPadProSmallScreenPortrait/Landscape
CGSize.iPadProSmallScreenPortrait/Landscape
CGSize.iPadScreenPortrait/Landscape
CGSize.iPhoneProMaxScreenPortrait/Landscape
```

There's also an `isScreenSize` function that compares rotation-agnostic screen sizes. 

```swift

let size = CGSize.iPadProLargeScreenPortrait
size.isScreenSize(.iPadProLargeScreenLandscape) // True
```

It's extra important to avoid designing for a specific screen size, if possible, since apps can run in split screen, the keyboard can be floating, etc.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
