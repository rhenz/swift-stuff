import UIKit

//: ### Closures


//: Closures basics
//: A closure is simply a function without a no name. Or also what they call _anonymous function_
//: Closures are so named because they can _close over_ the variables and constants within the closure's scope. This means that a closure can access the values of any variable or constant from the surrounding context. Variables and constants used within the closures body are said to have been *captured* by the closure.


// To use a closure, we must first assign it toa variable or a constants

var multiplyClosure: (Int, Int) -> Int

// multiplyClosure takes two Int values and returns an Int
multiplyClosure = { (a: Int, b: Int) -> Int in
    return a * b
}

// We can use our closure variable like this. You'll notice that there are no parameters included when calling closures like in the regular functions. With closures, there is not need for external name parameters.
let result = multiplyClosure(10, 10)


//: ### Shorthand syntax

//: There are multiply ways to shorten the syntax of closures

// First, just like normal functions, you can remove the return keyword like so
multiplyClosure = { (a: Int, b: Int) -> Int in
    a * b
}


// We can let the Swift use it's type inference to shorten the syntax
multiplyClosure = { a, b in
    a * b
}

// And finally, we can omit the parameter list if you want. Swift lets you refer to each parameter by number starting with zero(0)

multiplyClosure = { $0 * $1 }


// If the parameter list is longer, it can be confusing to remember what each numbered parameter refers to. In these cases, you should use the name syntax.



// Consider this code:
func operateOnNumbers(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    print(result)
    return result
}

// One way to use operateOnNumber is like so:
let addClosure = { (a: Int, b: Int) in a + b }
operateOnNumbers(4, 2, operation: addClosure)


// Remember the closures are just functions without names so we can also pass a function on the 3rd parameter
func addFunction(a: Int, b: Int) -> Int {
    a + b
}
operateOnNumbers(1, 5, operation: addFunction)

// Here is an example why closure is so powerful and useful. We can define the closure inline with the operateOnNumbers function call like:
operateOnNumbers(5, 10, operation: { (a: Int, b: Int) -> Int in
    a + b
})

// We can also simplify it like:
operateOnNumbers(2, 3, operation: { $0 + $1 })

// We can go even further, but it could lead to confusion for some people
operateOnNumbers(5, 24, operation: +)

// Another way we can simplify the syntax is by doing _trailing closure_. It can only be done if the closure is the final parameter of the function
operateOnNumbers(99, 99) { $0 + $1 }


//: ### Multiple trailing closure syntax

// if functions have multiple closures for inputs, you can call it in a special shorthand way:

func sequenced(first: () -> Void, second: () -> Void) {
    first()
    second()
}

sequenced {
    print("Hello,", terminator: "")
} second: {
    print("world.")
}

//: ### Closures with no return value

//: Previous examples with closures have taken one or more parameters and have returned values. But just like functions, they can return nothing as well.

let voidClosure: () -> Void = {
    print("I am awesome!")
}
voidClosure()

// Closure type above is () -> Void. Note: Void is just a type alias for (), this means you could write this like () -> ()


//: ### Capturing from the enclosing scope
//: Now let's return to the defining characteristics of closures: it can access variables or constants within its scope. Now these variables and constants are *captured*


func countingClosure() -> () -> Int {
    var counter = 0
    let incrementCounter: () -> Int = {
        counter += 1
        return counter
    }
    return incrementCounter
}

let counter1 = countingClosure()
let counter2 = countingClosure()
counter1() // 1
counter2() // 1
counter1() // 2
counter1() // 3
counter2() // 2


//: ### Custom sorting with closures

let names = ["ZZZZZZ", "BB", "A", "CCCC", "EEEEE"]

// by specifying custom closure, we can change the details of how we want the arrays to be sorted:
let sortedArrayByCount = names.sorted { $0.count < $1.count }
sortedArrayByCount


//: ### Iterating over collections with closures

//: In Swift, collections implement some convenient features often associated with *functional programming*. These features come in the shape of functions that we can apply to a collection to operate on it


//: ForEach
let values = [1, 2, 3, 4, 5, 6]
values.forEach {
    print("\($0): \($0*$0)") // squared
}

//: Filter
var prices = [1.5, 10, 4.99, 2.30, 8.19]
let largePrices = prices.filter { $0 > 5 } // returns all prices greater than 5
print(largePrices)

let firstPriceMoreThan5 = prices.first { $0 > 5 }
print(firstPriceMoreThan5 as Any)

//: Map
// Imagine we are having a sale in our store and wanting to discount all items to 90% of their original price. Here's a handy function

let discountedPrices = prices.map { $0 - ($0 * 0.50) }
discountedPrices


// We can also use the Map function to change the type of an array
let userInput = ["0", "1", "H", "2", "A", "5"]
let convertToInt = userInput.map { Int($0) } // remove nil values

print(convertToInt)

// This is almost the same as Map except it creates an array of Int and removes all nil values
let convertToInt2 = userInput.compactMap { Int($0) } // remove nil values
convertToInt2

//: flatMap
let userInputNested = [["0", "1"], ["a", "b", "c"], ["🤡"]]
let allUserInput = userInputNested.flatMap { $0 }
print(allUserInput)


//: Reduce
let sum = prices.reduce(0, +)


let stock = [1.5: 5, 10: 2, 4.99: 20, 2.30: 5, 8.19: 30]
let stockSum = stock.reduce(0) {
    $0 + $1.key * Double($1.value)
}


//: ### Lazy collections

func isPrime(_ number: Int) -> Bool {
    if number == 1 { return false }
    if number == 2 || number == 3 { return true }
    for i in 2...Int(Double(number).squareRoot()) {
        if number % i == 0 { return false }
    }
    return true
}

let primes = (1...).lazy
    .filter { isPrime($0) }
    .prefix(10)
primes.forEach { print($0) }
