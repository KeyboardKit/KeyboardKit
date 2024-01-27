# Extensions

This article describes KeyboardKit native type extensions.

KeyboardKit extends native types with a lot more information, to help with things like autocomplete, text analysis, etc.

Since native type extensions don't show up that well in DocC, this article lists some extensions you get by just linking to KeyboardKit.



## String extensions

KeyboardKit extends **String** with a bunch of extensions:

### Casing

String has extensions to check keyboard-specific casings.

```swift
"a".isLowercasedWithUppercaseVariant  // true
"A".isLowercasedWithUppercaseVariant  // false
"1".isLowercasedWithUppercaseVariant  // false
"a".isUppercasedWithLowercaseVariant  // false
"A".isUppercasedWithLowercaseVariant  // true
"1".isUppercasedWithLowercaseVariant  // false
```

### Character mapping

String has an extension to map itself to a list of characters.

```swift
"abc".chars  // ["a", "b", "c"]
```

### Characters

String has extensions that define certain characters.

```swift
String.carriageReturn       // "\r"
String.newline              // "\n"
String.space                // " "
String.tab                  // "\t"
String.zeroWidthSpace       // "\u{200B}"
```

### Quotation

String has locale-based extensions to check if a string has unclosed quotations. 

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

String has a mutable extension that defines sentence delimiters:

```swift
String.sentenceDelimiters   // ["!", ".", "?"]
```

You can check if any string is a sentence delimiter.

```swift
"a".isSentenceDelimiter     // false
",".isSentenceDelimiter     // false
".".isSentenceDelimiter     // true
```

This information can then be used to analyze texts:

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

String has a mutable extension that defines word delimiters:

```swift
String.wordDelimiters       // "!.?,;:()[]{}<> ⏎"
```

You can check if any string is a word delimiter.

```swift
"a".isWordDelimiter         // false
",".isWordDelimiter         // true
".".isWordDelimiter         // true
```

This information can then be used to analyze texts:

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
