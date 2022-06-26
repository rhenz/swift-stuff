import UIKit

//: ### Programming exercises

//: Fibonacci

func fibonacci(position: Int) -> Int {
    switch position {
    case let n where n <= 1:
        return 0
    case 2:
        return 1
    case let n:
        return fibonacci(position: n - 1) + fibonacci(position:  n - 2)
    }
}


let fib15 = fibonacci(position: 15) // 377

/*:
 1. If the current sequence position is less than two, the function will return 0.
 2. If the current sequence position is equal to two, the function will return 1.
 3. Otherwise, the function will use recursion to call itself and sum up all the numbers. This code is also an example of avoiding the default case in a switch statement. The let n case matches all values, so the default case is unnecessary.
 */


//: FizzBuzz
/*:
 In the FizzBuzz algorithm, your objective is to print the numbers from 1 to 100, except:
 • On multiples of three, print "Fizz" instead of the number.
 • On multiples of five, print "Buzz" instead of the number.
 • On multiples of both three and five, print "FizzBuzz" instead of the number.
 */

for i in 1...100 {
    switch (i % 3, i % 5) {
    case (0, 0):
        print("FizzBuzz")
    case (0, _):
        print("Fizz")
    case (_, 0):
        print("Buzz")
    default:
        print(i)
    }
}
