import UIKit

/*: ### Challenge 1: Character count
 
 
 Write a function that takes a string and prints out the count of each character in the string. For bonus points, print them ordered by the count of each character. For bonus-bonus points, print it as a nice histogram.
 Hint: You could use # characters to draw the bars.
 */

func printCountOfEachCharacter(for string: String) {
    
    var charCountDict: [Character: Int] = [:]
    for char in string {
        charCountDict[char, default: 0] += 1
    }
    
    
    let sortedKeys = charCountDict.keys.sorted { charCountDict[$0]! > charCountDict[$1]! }
    
    let maxValue = charCountDict[sortedKeys.first!]!
    
    for key in sortedKeys {
        let value = charCountDict[key]!
        let multiplier = (value * 10) / maxValue
        let hash = String(repeating: "#", count: multiplier)
        print("\(key.uppercased()): \(hash) \(value)")
    }
}

printCountOfEachCharacter(for: "Luccaaas")

/*: ### Challenge 2: Word count
 
 Write a function that tells you how many words there are in a string. Do it without splitting the string.
 Hint: try iterating through the string yourself.
 */

func printHowManyWords(for string: String) {
    if string.isEmpty {
        print("ZERO!")
        return
    }
    
    // My solution
    let count = string.components(separatedBy: " ").count
    print(count)
    
    // Count every space + 1?
    var space = 0
    for char in string {
        if char == " " {
            space += 1
        }
    }
    print(space + 1)
    
}

printHowManyWords(for: "The quick brown fox jumps over the lazy dog")


/*: ### Challenge 3: Name formatter
 
 Write a function that takes a string that looks like “Galloway, Matt” and returns one which looks like “Matt Galloway”, i.e., the string goes from "<LAST_NAME>, <FIRST_NAME>" to "<FIRST_NAME> <LAST_NAME>".
 
 */

func nameFormatter(name: String) -> String? {
    guard let commaIndex = name.firstIndex(of: ",") else {
        return nil
    }
    
    let lastNameSubstring = name[..<commaIndex]
    let firstNameSubstring = name[commaIndex...].dropFirst(2)
    
    return firstNameSubstring + " " + lastNameSubstring
}

if let formattedName = nameFormatter(name: "Lucas, John") {
    print(formattedName)
}


/*: ### Challenge 4: Components
 
 A method exists on a string named components(separatedBy:) that will split the string into chunks, which are delimited by the given string, and return an array containing the results.
 Your challenge is to implement this yourself.
 Hint: There exists a view on String named indices that lets you iterate through all
 the indices (of type String.Index) in the string. You will need to use this.
 */

func splitting(_ string: String, delimiter: Character) -> [String] {
    var returnArray: [String] = []
    var lastWordIndex = string.startIndex
    
    for i in string.indices {
        if string[i] == delimiter {
            let substring = string[lastWordIndex..<i]
            returnArray.append(String(substring))
            lastWordIndex = string.index(after: i)
        }
    }
    
    let substring = string[lastWordIndex..<string.endIndex]
    returnArray.append(String(substring))
    
    return returnArray
}

let pieces = splitting("Dog,Cat,Badger,Snake,Lion", delimiter: ",")
print(pieces)


/*: ### Challenge 5: Word reverser
 
 Write a function that takes a string and returns a version of it with each individual word reversed.
 For example, if the string is “My dog is called Rover” then the resulting string would be “yM god si dellac revoR”.
 Try to do it by iterating through the indices of the string until you find a space and then reversing what was before it. Build up the result string by continually doing that as you iterate through the string.
 Hint: You’ll need to do a similar thing as you did for Challenge 4 but reverse the word each time. Try to explain to yourself, or the closest unsuspecting family member, why this is better in terms of memory usage than using the function you created in the previous challenge.
 */

func reversedByWord(sentence: String) -> String {
    var reversedWords = ""
    var lastWordIndex = sentence.startIndex
    
    for i in sentence.indices {
        if sentence[i] == " " {
            let substring = sentence[lastWordIndex..<i]
            reversedWords += substring.reversed() + " "
            lastWordIndex = sentence.index(after: i)
        }
    }
    
    let substring = sentence[lastWordIndex..<sentence.endIndex]
    reversedWords += substring.reversed()
    
    return reversedWords
}

let reversed = reversedByWord(sentence: "The quick brown fox jumps over the lazy dog")
print(reversed)
