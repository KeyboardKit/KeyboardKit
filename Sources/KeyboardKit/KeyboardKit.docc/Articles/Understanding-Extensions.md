# Understanding Extensions

This article describes KeyboardKit native type extensions.

Since native type extensions don't show up in DocC, this article will list some extensions you get by just adding KeyboardKit to your app or keyboard extension.



## String extensions

KeyboardKit extends **String** with a bunch of extensions:

### String casing

```swift
"a".isLowercasedWithUppercaseVariant   // True
"A".isLowercasedWithUppercaseVariant   // False
"1".isLowercasedWithUppercaseVariant   // False
"a".isUppercasedWithLowercaseVariant   // False
"A".isUppercasedWithLowercaseVariant   // True
"1".isUppercasedWithLowercaseVariant   // False
```

### String character mapping

```swift
"abc".chars     // ["a", "b", "c"]
```

### String characters

```swift
String.carriageReturn    // "\r"
String.newline           // "\n"
String.space             // " "
String.tab               // "\t"
String.zeroWidthSpace    // "\u{200B}"

"a".isSentenceDelimiter  // False
",".isSentenceDelimiter  // False
".".isSentenceDelimiter  // True

"a".isWordDelimiter      // False
",".isWordDelimiter      // True
".".isWordDelimiter      // True
```
