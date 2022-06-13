import UIKit




/*: ### Challenge 1: Repeating yourself
 
 Your first challenge is to write a function that will run a given closure a given number of times.
 Declare the function like so:
 
 ```
 func repeatTask(times: Int, task: () -> Void)
 ```
 
 The function should run the task closure, times number of times. Use this function
 to print "Swift Apprentice is a great book!" 10 times.
 */

func repeatTask(times: Int, task: () -> Void) {
    for _ in 1...times {
        task()
    }
}

repeatTask(times: 10) {
    print("Swift is a great programming language!")
}



/*: ### Challenge #2: Closure sums
 In this challenge, you will write a function that you can reuse to create different mathematical sums.
 Declare the function like so:
 
 ```
 func mathSum(length: Int, series: (Int) -> Int) -> Int
 ```
 
 
 The first parameter, length, defines the number of values to sum. The second parameter, series, is a closure that can be used to generate a series of values. series should have a parameter that is the position of the value in the series and return the value at that position.
 mathSum should calculate length number of values, starting at position 1, and return their sum.
 Use the function to find the sum of the first 10 square numbers, which equals 385. Then use the function to find the sum of the first 10 Fibonacci numbers, which equals 143. For the Fibonacci numbers, you can use the function you wrote in Chapter 5, “Functions” — or grab it from the solutions if you’re unsure your solution is correct.
 */

func mathSum(length: Int, series: (Int) -> Int) -> Int {
    var result = 0
    for i in 1...length {
        result += series(i)
    }
    return result
}

let sum1 = mathSum(length: 10) { $0 * $0 } // 385
print(sum1)

// Fibo
func fibonacci(_ number: Int) -> Int {
  if number <= 0 {
    return 0
  }

  if number == 1 || number == 2 {
    return 1
  }

  return fibonacci(number - 1) + fibonacci(number - 2)
}

let fiboSum = mathSum(length: 10, series: fibonacci) // 143





/*: ### Challenge #3
 In this final challenge, you will have a list of app names with associated ratings they’ve been given. Note — these are all fictional apps! Create the data dictionary like so:
 
 ```
 let appRatings = [
 "Calendar Pro": [1, 5, 5, 4, 2, 1, 5, 4],
 "The Messenger": [5, 4, 2, 5, 4, 1, 1, 2],
 "Socialise": [2, 1, 2, 2, 1, 2, 4, 2]
 ]
 ```
 
 First, create a dictionary called averageRatings that will contain a mapping of app names to average ratings. Use forEach to iterate through the appRatings dictionary, then use reduce to calculate the average rating. Store this rating in the averageRatings dictionary. Finally, use filter and map chained together to get a list of the app names whose average rating is greater than 3.
 
 */

let appRatings = [
    "Calendar Pro": [1, 5, 5, 4, 2, 1, 5, 4],
    "The Messenger": [5, 4, 2, 5, 4, 1, 1, 2],
    "Socialise": [2, 1, 2, 2, 1, 2, 4, 2]
]

var averageRatings: [String: Double] = [:]
appRatings.forEach {
    let total = $0.value.reduce(0, +)
    averageRatings[$0.key] = Double(total) / Double($0.value.count)
}
print(averageRatings)

let appsWithRatingGreaterThan3 = averageRatings.filter { $0.value > 3 }.map { $0.key }
print(appsWithRatingGreaterThan3)
