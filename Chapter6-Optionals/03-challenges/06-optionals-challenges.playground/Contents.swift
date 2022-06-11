import UIKit

//: ### Challenges



//: ### Challenge 1: You be the compiler
/*:
 Which of the following are valid statements?
 ```
 var name: String? = "Ray" // valid
 var age: Int = nil // invalid
 let distance: Float = 26.7 // valid
 var middleName: String? = nil // valid
 ```
 */



//: ### Challenge 2: Divide and conquer
/*:
 First, create a function that returns the number of times an integer can be divided by another integer without a remainder. The function should return nil if the division doesn’t produce a whole number. Name the function divideIfWhole.
 Then, write code that tries to unwrap the optional result of the function. There should be two cases: upon success, print "Yep, it divides \(answer) times", and upon failure, print "Not divisible :[".
 
 Finally, test your function:
 1. Divide 10 by 2. This should print "Yep, it divides 5 times."
 2. Divide 10 by 3. This should print "Not divisible :[."
 */

func divideIfWhole(_ value: Int, by divisor: Int) -> Int? {
    if value % divisor == 0 {
        return value / divisor
    } else {
        return nil
    }
}

if let num = divideIfWhole(10, by: 2) {
    print("Yep, it divides \(num) times.")
} else {
    print("Not divisible :[")
}


if let num = divideIfWhole(10, by: 3) {
    print("Yep, it divides \(num) times.")
} else {
    print("Not divisible :[")
}


/*: ### Challenge 3: Refactor and reduce
 
 The code you wrote in the last challenge used if statements. In this challenge, refactor that code to use nil coalescing instead. This time, make it print "It divides X times" in all cases, but if the division doesn’t result in a whole number, then X should be 0.
*/

let x1 = divideIfWhole(10, by: 2) ?? 0
print("It divides \(x1) times")


let x2 = divideIfWhole(10, by: 3) ?? 0
print("It divides \(x2) times")


/*: ### Challenge 4: Nested optionals
 
 Consider the following nested optional — it corresponds to a number inside a box inside a box inside a box.
*/

let number: Int??? = 10
print(number)
// Optional(Optional(Optional(10)))
print(number!)
// Optional(Optional(10))


// 1.
print(number!!!)

// 2.
if let number = number, let number = number, let number = number {
    print(number)
}

// 3.
func printNumber(_ number: Int???) {
    guard let number = number, let number = number, let number = number else {
        return
    }
    print(number)
}
printNumber(20)
