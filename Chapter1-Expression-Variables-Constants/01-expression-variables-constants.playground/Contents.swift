import Foundation


//: This is a Single-Line Comment
// This is a comment. It is not executed.


//: You could stack up single-line comments like this:
// This is also a comment
// Over multiple lines

//: This is how we write a multi-line comment
/*
 This is also a comment
 Over many..
 many...
 super..
 many..
 lines..
 */

//: Printing Out - This will be printed in the debug area
print("Hello! What a wonderful world!")


//: ARITHMETIC OPERATIONS


//: Simple Operations
5 + 5
10 - 5
2 * 3
20 / 2
22.0 / 7.0

//: Modulo Operations / Remainder Operation
22 % 3

28 % 10
28.0.truncatingRemainder(dividingBy: 10.0) // Same as above, good stuff to know


//: Shifting Operations
1 << 3
32 >> 2

//: Math Functions - Swift has a lot of Math functions
sin(45 * Double.pi/180)
2.squareRoot()
121.squareRoot()
1/(2.squareRoot())

// Max Min
max(10, 20)
min(20, 10)

//: Constants. You can't modify a constant variable
let number: Int = 20
//number = 21 // This will produce error

//: Variable
var variableNumber: Int = 69
variableNumber = 96

//: We can use `underscores` to make big numbers more readable
let bigNumber = 1_000_000


//: In Swift, we can use Unicode characters like Emojis as a variable name
let 🤩 = "Amazing!"


//: Increment and Decrement

var counter: Int = 2

counter += 1 // counter = 1

counter -= 1 // counter = 0

counter *= 3 // counter = 6

counter /= 2 // counter = 3



//: Mini Exercise

// 1.
let myAge1: Int = 20

// 2.
var averageAge: Double = 20
averageAge = (20+30)/2

// 3
let testNumber = 1015
let evenOdd = testNumber % 2 // This will only produce 1 or 0 only

// 4
var answer = 0
answer += 1
answer += 10
answer *= 10
answer >> 3


//: Challenges

// Challenge 1
let myAge: Int = 21
var dogs: Int = 1

// Imagine you adopt a new puppy and increment the `dogs` variable by one
dogs += 1


// Challenge 2
var age: Int = 16
print(age)
age = 30
print(age)


// Challenge 3

let x: Int = 46
let y: Int = 10

// 1 let answer1: Int = (x * 100) + y = 4610
// 2 let answer2: Int = (x * 100) + (y * 100) = 5600
// 3 let answer3: Int = (x * 100) + (y / 10) = 4601


// Challenge 4
8-(4*2)+(6/3)*4

// Challenge 5
let rating1: Double = 90.0
let rating2: Double = 85.5
let rating3: Double = 92.3

let averageRating = (rating1 + rating2 + rating3) / 3

// Challenge 6
let voltage: Double = 10.0
let current: Double = 20.0
let power: Double = voltage * current

// Challenge 7
let resistance: Double = power / pow(current, 2)

// Challenge 8
let diceRoll = arc4random_uniform(6) + 1

// Challenge 9
let a: Double = 5
let b: Double = 30
let c: Double = 5

let root1 = -b + sqrt(pow(b, 2)-4*a*c) / (2*a)
let root2 = -b - sqrt(pow(b, 2)-4*a*c) / (2*a)
