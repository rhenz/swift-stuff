import UIKit


//: ### Challenge #1 Looping with stride functions

// Answer: The 2nd stride function uses closed range, while the other one is half-open range


//: ### Challenge #2 It's Prime time

func isNumberDivisible(_ number: Int, by divisor: Int) -> Bool {
    number % divisor == 0
}

isNumberDivisible(10, by: 5)

func isPrime(_ number: Int) -> Bool {
    if number < 0 { return false }
    
    if number <= 3 { return true }
    
    let doubleNumber = Double(number)
    let root = Int(doubleNumber.squareRoot())
    for i in 2...root {
        if isNumberDivisible(number, by: i) {
            return false
        }
    }
    return true
}

isPrime(6)
isPrime(13)
isPrime(8893)



//: ### Challenge #3 Recursive functions

func fibonacci(_ number: Int) -> Int {
    if number <= 0 {
        return 0
    }
    
    if number == 1 || number == 2 {
        return 1
    }
    
    return fibonacci(number - 1) + fibonacci(number - 2)
}
fibonacci(1)
fibonacci(2)
fibonacci(3)
fibonacci(4)
fibonacci(5)
fibonacci(10)
