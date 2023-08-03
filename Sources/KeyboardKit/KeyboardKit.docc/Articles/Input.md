# Input

This article describes the KeyboardKit input sets and how to use them.

In KeyboardKit, the ``InputSet`` and ``KeyboardLayout`` types are used to describe the keys of a keyboard.

An ``InputSet`` defines the input keys on a keyboard, while a ``KeyboardLayout`` defines the full set of keys, as well as their heights, sizes etc. This means that you can use different input sets with a single keyboard layout. 

A typical ``SystemKeyboard`` layout has several rows, where the input buttons are surrounded by action buttons on one or both sides.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Input Sets

In KeyboardKit, there are three different ``InputSet`` implementations: ``AlphabeticInputSet``, ``NumericInputSet`` and ``SymbolicInputSet``.

> Note: These types will be merged into a single `InputSet` struct in KeyboardKit 8.0.

KeyboardKit provides you with a few localized input sets, such as ``AlphabeticInputSet/english``, ``NumericInputSet/englishNumeric(currency:)`` and ``SymbolicInputSet/englishSymbolic(currency:)``, which are used to create English keyboards. 



## Input Set Providers (DEPRECATED)

KeyboardKit has a concept called ``InputSetProvider``, which is a protocol that can be implemented by any type that can return an alphabetic, a numeric and a symbolic input set.

The ``InputSetProvider`` concept has however been deprecated and will be completely removed in KeyboardKit 8.0.

Instead of an input set provider, from now on use input sets directly.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional input sets for all keyboard locales, as well as variations like `.azerty` and `.qwertz`, which can be used by all layouts that have the same set of keys as an English keyboard. 

These input sets let you create a fully localized ``SystemKeyboard`` with a single line of code. 



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
