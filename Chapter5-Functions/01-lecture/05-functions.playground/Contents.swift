import UIKit

//:### Function basics

func printMyName() {
    print("My name is John Lucas")
}

//
printMyName()


//:### Function parameters
func printMultipleOfFive(value: Int) {
    print("\(value) * 5 = \(value * 5)")
}
printMultipleOfFive(value: 10)


//: with 2 parameters
func printMultipleOf(multiplier: Int, andValue: Int) {
    print("\(multiplier) * \(andValue) = \(multiplier * andValue)")
}

printMultipleOf(multiplier: 4, andValue: 2)


//: with `external name`
func printMultipleOf(multiplier: Int, and value: Int) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}
printMultipleOf(multiplier: 4, and: 2)

//: without `external name`
func printMultipleOf(_ multiplier: Int, and value: Int) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}
printMultipleOf(4, and: 2)

//: we can also remove all external parameter names if you want
func printMultipleOf(_ multiplier: Int, _ value: Int) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}
printMultipleOf(4, 2)

//:### Return values
func multiply(_ number: Int, multiplier: Int) -> Int {
    return number * multiplier
}

let result = multiply(2, multiplier: 5)


//: We can also return multiple values using TUPLES

// We can also omit the `return` keyword if there's only one line of code in the body
func multipleAndDivide(_ number: Int, by factor: Int) -> (product: Int, quotient: Int) {
    (number * factor, number / factor)
}

let results = multipleAndDivide(4, by: 2)
let product = results.product
let quotient = results.quotient


//:### Advance parameter handling
//: function parameters are constants by default, which means you can't modify them

/*:
 ```
 func incrementAndPrint(_ value: Int) {
 value += 1 // error, value isn't mutable
 print(value)
 }
 ```
 */


//: Sometimes we want to let a function change a parameter directly, this behavior is know as *copy-in copy-out* or *call by value result* using `inout` keyword

func incrementAndPrint(_ value: inout Int) {
    value += 1
    print(value)
}

var value = 5
incrementAndPrint(&value)
print(value)


//:### Overloading
/*:
 ```
 func printMultipleOf(multiplier: Int, andValue: Int)
 func printMultipleOf(multiplier: Int, and value: Int)
 func printMultipleOf(_ multiplier: Int, and value: Int)
 func printMultipleOf(_ multiplier: Int, _ value: Int)
 ```
 */


//: We can also overload a function name based on a different return type
func getValue() -> Int {
    31
}

func getValue() -> String {
    "Thirty One"
}

//: But swift should know in what context you are using these two overloading function with different return types like:

let valueInt: Int = getValue()
let valueString: String = getValue()
let sum = 1 + getValue()
let someString = "This is " + getValue()

func printNumber(_ numStr: String) {
    print(numStr)
}
printNumber(getValue())


//:### Functions as variables

func add(_ a: Int, _ b: Int) -> Int {
    a + b
}

var function = add
function(2, 3)


func printResult(_ function: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    let result = function(a, b)
    print(result)
}
printResult(add, 4, 2)


/**
 Calculates the average of three values
 
 - parameter:
    - a: The first value.
    - b: The second value.
    - c: The third value.
 - returns: The average of the three values
 - warning: Can only use DOUBLE
 
 
 # Notes: #
 1. I love SWIFT
 
 */
func calculateAverage(of a: Double, and b: Double, and c: Double) -> Double {
    let total = a + b + c
    let average = total / 3
    return average
}


calculateAverage(of: 1, and: 3, and: 5)


