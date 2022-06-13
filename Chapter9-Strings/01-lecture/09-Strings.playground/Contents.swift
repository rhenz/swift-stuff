import UIKit

//: ### Strings



//: ### Strings as collections
//: it is pretty easy to conceptualize a string as a collection of Characters. Because _strings_ are collections, you can do something like this:

let string = "Lucas"
for char in string {
    print(char)
}

// We can also count its characters/length of the string
print(string.count)


// We may think we can use subscript like:
//let fourthChar = string[3] // Error


//: Why? Because characters do not have a fixed size, so they can't be accessed like an array. Why not? Let's look into _grapheme clusters_



//: ### Graphem Clusters
//: As we know, string is made up of a collection of Unicode characters.

//: There are two ways to represent some characters. One example is é in café, an e with acute accent. We can represent this character with either one or two characters.
//: The single character to represent this is code point 233. The two-character case is an e on its own, followed by an acute accent combining character.
// This combination of two characters is what known as a _grapheme cluster_ defined by the Unicode standard.


let cafeNormal = "café"
let cafeCombining = "cafe\u{0301}"
cafeNormal.count     // 4
cafeCombining.count  // 4

//: We may notice that both counts turn out to equal four because Swift considers a string as a collection of _grapheme clusters_.

//: However, we can access the underlying Unicode code points in the string via the `unicodeScalars` view.
cafeNormal.unicodeScalars.count
cafeCombining.unicodeScalars.count

// Now we see difference in the counts

// We can iterate through this Unicode scalars view like:
for codePoint in cafeCombining.unicodeScalars {
    print(codePoint.value)
}



//: ### Indexing strings
//: We saw earlier that indexing into a string to get a certain character/grapheme cluster is not as simple as using an integer subscript. Swift wants us to be aware of what's going on under the hood, so it requires syntax a bit more verbose


//: We have to operate on the specific string index type  to index into strings:
let firstIndex = cafeCombining.startIndex // type String.Index

// Now we can use this firstIndex to obtain specific character/grapheme cluster at that index
let firstChar = cafeCombining[firstIndex]

// We can obtain the last character/grapheme cluster like
//let lastIndex = cafeCombining.endIndex
//let lastChar = cafeCombining[lastIndex] // but this will cause an error

// This error happens because the _endIndex_ is one past the end of the string. We need to do this to obtain the last character
let lastIndex = cafeCombining.index(before: cafeCombining.endIndex)
let lastChar = cafeCombining[lastIndex]


// alternatively, we can offset from the first character to get specific character at your desired index
let fourthIndex = cafeCombining.index(cafeCombining.startIndex, offsetBy: 3)
let fourthChar = cafeCombining[fourthIndex]

let isEqual = cafeNormal == cafeCombining // because these two strings are logically the same


//: ### Strings as bi-directional collections

// How to reverse a string?
let myName = "Lucas"
let backwardName = myName.reversed()
backwardName // ReversedCollection<String>


// We can access every character in the backwards string just like what we do in any other string:
let secondCharIndex = backwardName.index(backwardName.startIndex, offsetBy: 1)
let secondChar = backwardName[secondCharIndex]


// If we want a String type, we have to initialize a string from this reversed collection like
let backwardNameString = String(backwardName)


//: ### Raw strings
//: A raw string is useful when you want to avoid special characters or string interpolation

let raw1 = #"Raw "No Escaping" \(no interpolation!). Use all the\ you want!"#
print(raw1)


// Use interpolation with raw strings
let can = "can do that too"
let raw3 = #"Yes we \#(can)!"#
print(raw3)


//: ### Substrings

let fullName = "John Lucas"
let spaceIndex = fullName.firstIndex(of: " ")!
let firstName = fullName[fullName.startIndex..<spaceIndex] // John
let lastName = fullName[fullName.index(after: spaceIndex)...]


// To use it as a String, need to initialize it into string
let lastNameString = String(lastName)


//: ### Character properties

//: Check if character belongs to the ASCII character set
let singleCharacter: Character = "😆"
singleCharacter.isASCII

//: Check if character is whitespace
let space: Character = " "
space.isWhitespace

//: Hex Digit
let hexDigit: Character = "d"
hexDigit.isHexDigit

//: Whole Number Value
let thaiNine: Character = "๙"
thaiNine.wholeNumberValue



//: ### Encoding
//: Strings are made up of a collection of Unicode code points. These code points range from the number 0 up to 1114111. This means that the maximum number of bits you need to represent a code point is 21. However, if you are only ever using low code points, such as if your text contains only Latin characters, then you can get away with using only eight bits per code point.


//: UTF8
//: This uses 8-bit code units instead. One reason for UTF-8’s popularity is because it is fully compatible with the venerable, English-only, 7-bit ASCII encoding.
let char = "\u{00bd}"
for i in char.utf8 {
    print(i)
}

//: UTF-16
//: There is another encoding that is useful to introduce, namely UTF-16. Yes, you guessed it. It uses 16-bit code units!
//: This means that code points that are up to 16 bits use one code unit. But how are code points of 17 to 21 bits represented? These use a scheme known as surrogate pairs. These are two UTF-16 code units that, when next to each other, represent a code point from the range above 16 bits.
