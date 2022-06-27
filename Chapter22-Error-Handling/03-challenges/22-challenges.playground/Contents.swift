import UIKit

/*: ### Challenge 1: Even strings
 
 Write a throwing function that converts a String to an even number, rounding down if necessary.

 */

enum ConvertError: Error {
    case notANumber
}

func convertStringToAnEvenNumber(_ string: String) throws -> Int {
    guard let num = Int(string) else {
        throw ConvertError.notANumber
    }
    
    return num - (num % 2)
}

let num1 = "1023"
let num2 = "1022"
let num3 = "1022.23"
let num4 = "123a"

do {
//    let num = try convertStringToAnEvenNumber(num1)
//    let num = try convertStringToAnEvenNumber(num2)
    let num = try convertStringToAnEvenNumber(num3)
//    let num = try convertStringToAnEvenNumber(num4)
    print(num)
} catch ConvertError.notANumber {
    print("This is not a number!")
}


/*: ### Challenge 2: Safe division
 
 Write a throwing function that divides type Int types.
 */

enum DivisionError: Error {
    case undefined
}

func divide(_ dividend: Int, by divisor: Int) throws -> Int {
    if divisor == 0 {
        throw DivisionError.undefined
    }
    
    return dividend / divisor
}


do {
    _ = try divide(10, by: 5)
    _ = try divide(10, by: 3)
    _ = try divide(10, by: 0)
} catch DivisionError.undefined {
    print("Can't divide anything by/with zero!")
}


//: ### Key points

/*:
 - A type can conform to the `Error` protocol to work with Swift's error-handling system.
 - Any function that can throw an error, or call a function that can throw an error, has to be marked with `throws` or `rethrows`
 - When calling an error-throwing function, we must embed the function call in a `do` block. Withing that block, we `try` the function, and if it fails, we `catch` the error
 - `Read-only` computed properties and subscripts can throw errors
 */
