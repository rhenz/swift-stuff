import UIKit


/*: ### Challenge 1: Which is valid
 
 
 Which of the following are valid statements?
 1. let array1 = [Int]()
 2. let array2 = []
 3. let array3: [String] = []
 
 For the next five statements, array4 has been declared as: let array4 = [1, 2, 3]
 
 4. print(array4[0])
 5. print(array4[5])
 6. array4[1...2]
 7. array4[0] = 4
 8. array4.append(4)
 
 For the final five statements, array5 has been declared as: var array5 = [1, 2, 3]
 
 9. array5[0] = array5[1]
 10. array5[0...1] = [4, 5]
 11. array5[0] = "Six"
 12. array5 += 6
 13. for item in array5 { print(item) }
 */

// 1. invalid
// 2. invalid
// 3. valid
// 4. valid
// 5. invalid
// 6. valid
// 7. valid
// 8. invalid (array4 is declared as a constant, therefore it is immutable
// 9. valid
// 10. valid
// 11. invalid, must be integer only.
// 12. valid
// 13. valid

var array5 = [1,2,3]


/*: ### Challenge 2: Remove the first number
 
 Write a function that removes the first occurrence of a given integer from an array of integers. This is the signature of the function:
  
 ```
 func removingOnce(_ item: Int, from array: [Int]) -> [Int]
 ```
 */
func removingOnce(_ item: Int, from array: [Int]) -> [Int] {
    var copy = array
    if let index = array.firstIndex(of: item) {
        copy.remove(at: index)
    }
    
    return copy
}

removingOnce(1, from: [2, 1, 3, 5, 1])


/*: ### Challenge 3: Remove the numbers
 
 Write a function that removes all occurrences of a given integer from an array of integers. This is the signature of the function:
 
 ```
 func removing(_ item: Int, from array: [Int]) -> [Int]
 ```
 */

func removing(_ item: Int, from array: [Int]) -> [Int] {
    var tempArray: [Int] = []
    
    for arrayItem in array {
        if item == arrayItem {
            continue
        }
        tempArray.append(arrayItem)
    }
    
    return tempArray
}

removing(1, from: [1, 1, 2, 3, 4, 1])


/*: ### Challenge 4: Reverse an array
 
 Arrays have a reversed() method that returns an array holding the same elements as the original array in reverse order. Write a function that does the same thing without using reversed(). This is the signature of the function:
 
 ```
 func reversed(_ array: [Int]) -> [Int]
 ```
 */

//func reversed(_ array: [Int]) -> [Int] {
//    var tempArray: [Int] = []
//
//    let arrayCount = array.count
//    for i in 0..<arrayCount {
//        tempArray.append(array[arrayCount - 1 - i])
//    }
//
//    return tempArray
//}

// Another solution is
func reversed(_ array: [Int]) -> [Int] {
    var tempArray: [Int] = []
    for item in array {
        tempArray.insert(item, at: 0)
    }
    return tempArray
}

reversed([1,2,3,4,5,6,7,8])

/*: ### Challenge 5: Return the middle
 
 Write a function that returns the middle element of an array. When array size is even, return the first of the two middle elements.
 
 ```
 func middle(_ array: [Int]) -> Int?
 ```
 */

func middle(_ array: [Int]) -> Int? {
    if array.isEmpty { return nil }
    
    let isEven = array.count % 2 == 0
    let mid = array.count / 2
    
    if isEven {
        return array[mid-1]
    } else {
        return array[mid]
    }
}


middle([1,2,3,4,5])

/*: ### Challenge 6: Find the minimum and maximum
 
 Write a function that calculates the minimum and maximum values in an array of integers. Calculate these values yourself; don’t use the methods min and max. Return nil if the given array is empty.

 This is the signature of the function:
 
 ```
 func minMax(of numbers: [Int]) -> (min: Int, max: Int)?
 ```
 */

func minMax(of numbers: [Int]) -> (min: Int, max: Int)? {
    if numbers.isEmpty { return nil }
    
    var min = numbers.first!
    var max = numbers.first!
    
    for num in numbers {
        if min > num {
            min = num
        }
        
        if max < num {
            max = num
        }
    }
    
    return (min, max)
}

minMax(of: [50,2,3,4,5,6,10,35])

/*: ### Challenge 7: Which is valid
 
 Which of the following are valid statements?
 
 1. let dict1: [Int, Int] = [:] // invalid
 2. let dict2 = [:] // invalid
 3. let dict3: [Int: Int] = [:] // valid
 
 For the next four statements, use the following dictionary: let dict4 = ["One": 1, "Two": 2, "Three": 3]
 
 4. dict4[1] // invalid
 5. dict4["One"] // valid
 6. dict4["Zero"] = 0 // invalid, dict4 is immutable
 7. dict4[0] = "Zero" // invalid
 
 For the next three statements, use the following dictionary: var dict5 = ["NY": "New York", "CA": "California"]
 
 8. dict5["NY"] // valid
 9. dict5["WA"] = "Washington" //valid
 10. dict5["CA"] = nil // valid
 */


/*: ### Challenge 8: Long names
 
 Given a dictionary with two-letter state codes as keys, and the full state names as values, write a function that prints all the states with names longer than eight characters. For example, for the dictionary ["NY": "New York", "CA": "California"], the output would be California.
 
 */

func printAllStateNamesMoreThan8Chars(_ dict: [String: String]) {
    for state in dict.values where state.count > 8 {
        print(state)
    }
}

printAllStateNamesMoreThan8Chars(["NY": "New York", "CA": "California", "SF": "San Francisco"])


/*:### Challenge 9: Merge dictionaries
 
 Write a function that combines two dictionaries into one. If a certain key appears in both dictionaries, ignore the pair from the first dictionary. This is the function’s signature:
 
 ```
 func merging(_ dict1: [String: String], with dict2: [String: String]) -> [String: String]
 ```
 */

func merging(_ dict1: [String: String], with dict2: [String: String]) -> [String: String] {
    var combinedDict: [String: String] = dict1
        
    for (key, value) in dict2 {
        combinedDict[key] = value
    }
    
    return combinedDict
}

let dict1 = ["SF": "San Francisco", "CA": "California"]
let dict2 = ["AL": "Alabama", "AK": "Alaska", "AZ": "Arizona"]

let mergedDict = merging(dict1, with: dict2)
print(mergedDict)


/*: ### Challenge 10: Count the characters
 
 Declare a function occurrencesOfCharacters that calculates which characters occur in a string, as well as how often each of these characters occur. Return the result as a dictionary. This is the function signature:
 
 ```
 func occurrencesOfCharacters(in text: String) -> [Character: Int]
 ```
 
 Hint: String is a collection of characters that you can iterate over with a for statement.Bonus: To make your code shorter, dictionaries have a special subscript operator that lets you add a default value if it is not found in the dictionary. For example, dictionary["a", default: 0] creates a 0 entry for the character “a” if it is not found instead of just returning nil.
 */

func occurrencesOfCharacters(in text: String) -> [Character: Int] {
    var result: [Character: Int] = [:]
    
    for char in text {
        result[char, default: 0] += 1
    }
    
    return result
}

let occurencesOfChars = occurrencesOfCharacters(in: "Hahahahahaha")
print(occurencesOfChars)

/*: ### Challenge 11: Unique values
 
 Write a function that returns true if all of the values of a dictionary are unique. Use a set to test uniqueness. This is the function signature:
 
 ```
 func isInvertible(_ dictionary: [String: Int]) -> Bool
 ```
 */

func isInvertible(_ dictionary: [String: Int]) -> Bool {
    var someSet: Set<Int> = []
    
    for value in dictionary.values {
        if !someSet.contains(value) {
            someSet.insert(value)
        } else {
            return false
        }
    }
    
    return true
}

isInvertible(["TA": 2, "PO": 3, "GA": 10, "GO": 25])

/*: ### Challenge 12: Removing keys and setting values to nil
 Given the dictionary:
 
 ```
 var nameTitleLookup: [String: String?] = ["Mary": "Engineer", "Patrick": "Intern", "Ray": "Hacker"]
 ```
 
 Set the value of the key "Patrick" to nil and completely remove the key and value for "Ray".
 */

var nameTitleLookup: [String: String?] = ["Mary": "Engineer", "Patrick": "Intern", "Ray": "Hacker"]
nameTitleLookup.updateValue(nil, forKey: "Patrick")
nameTitleLookup.removeValue(forKey: "Ray")
print(nameTitleLookup)
