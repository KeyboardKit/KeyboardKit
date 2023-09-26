# Understanding Extensions

This article describes KeyboardKit native type extensions.

Since native type extensions don't show up in DocC, this article will list some extensions you get by just adding KeyboardKit to your app or keyboard extension.



## String extensions

KeyboardKit extends **String** with a bunch of extensions:

### Casing

```swift
"a".isLowercasedWithUppercaseVariant  // True
"A".isLowercasedWithUppercaseVariant  // False
"1".isLowercasedWithUppercaseVariant  // False
"a".isUppercasedWithLowercaseVariant  // False
"A".isUppercasedWithLowercaseVariant  // True
"1".isUppercasedWithLowercaseVariant  // False
```

### Character mapping

```swift
"abc".chars  // ["a", "b", "c"]
```

### Characters

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

### Quotation

```swift
let loc = KeyboardLocale.english.locale

"Hello, world".hasUnclosedQuotation(for: loc)              // False
"“Hello, world".hasUnclosedQuotation(for: loc)             // True
"“Hello, world”".hasUnclosedQuotation(for: loc)            // False

"Hello, world".hasUnclosedAlternateQuotation(for: loc)     // False
"'Hello, world".hasUnclosedAlternateQuotation(for: loc)    // True
"\"Hello, world’".hasUnclosedAlternateQuotation(for: loc)  // False
```

### Sentences

```swift
"Hello, world".hasSentenceDelimiterSuffix    // False
"Hello, world.".hasSentenceDelimiterSuffix   // True
"Hello, world. ".hasSentenceDelimiterSuffix  // False

"Hello, world".isLastSentenceEnded           // False
"Hello, world.".isLastSentenceEnded          // True
"Hello, world. ".isLastSentenceEnded         // True

"Hello, world".lastSentence                  // "Hello, world"
"Hello, world. I am".lastSentence            // "I am"
```


### Words

```swift
"Hello, world".hasWordDelimiterSuffix    // False
"Hello, world,".hasWordDelimiterSuffix   // True
"Hello, world, ".hasWordDelimiterSuffix  // True

"Hello, world".wordFragmentAtStart       // "Hello"
"Hello, world".wordFragmentAtEnd         // "world"
"Hello, world.".wordFragmentAtEnd        // ""

"Hello, world".word(at: 0)               // "Hello"
"Hello, world".word(at: 5)               // "Hello"
"Hello, world".word(at: 8)               // "world"
"Hello, world.".word(at: 20)             // nil

"Hello, world".wordFragment(before: 3)   // "Hel"
"Hello, world".wordFragment(after: 3)    // "lo"
```
