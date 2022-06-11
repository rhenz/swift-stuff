import UIKit

//: Boolean Operators

// == <- Equality Operator
let doesOneEqualsTwo = (1 == 2) // false

// != Not Equal Operator
let doesOneNotEqualTwo = (1 != 2) // true


let isOneGreaterThanTwo = (1 > 2) // false
let isOneLessThanTwo = (1 < 2) // true


//: Boolean Logic
let and = true && true // using AND operator, if either one of the condition is False, this will become false

// Using OR operator
let or = true || false // if either one of the condition is True, this will always be true. This will only be false if all conditions are FALSE


let andTrue = 1 < 2 && 4 > 3
let andFalse = 1 < 2 && 3 > 4

let orTrue = 1 < 2 || 3 > 4
let orFalse = 1 == 2 || 3 == 4


// It is also possible to use Boolean logic to combine more than two comparisons
let andOr = (1 < 2 && 3 > 4) || 1 < 4 // true

// Steps in evaluating the conditions above
/**
 1. (1 < 2 && 3 > 4) || 1 < 4
 2. (true && false) || true
 3. false || true
 4. true
 */

//: String Equality

// In swift, you can compare strings using the standard equality operator
let guess = "dog"
let dogEqualsCat = guess == "cat"

// We can also use > or < if you want to compare strings alphabetically
let order = "cat" < "dog" // c < d, c comes first alphabetically so this returns true


//: Toggling a Bool

// In Swift, we can toggle a Bool variable like
var switchState = true
switchState.toggle() // false
switchState.toggle() // true


//: Mini Exercise

// 1. Create a constant called myAge and set it to your age. Then, create a constant named isTeenager that uses Boolean logic to determine if the age denotes someone in the age range of 13 to 19.
let myAge = 20
let isTeenager = (myAge >= 13) && (myAge <= 19)


// 2. Create another constant named theirAge and set it to my age, which is 30. Then, create a constant named bothTeenagers that uses Boolean logic to determine if both you and I are teenagers.
let theirAge = 30
let bothTeenagers = isTeenager && (theirAge >= 13) && (theirAge <= 19)

// 3. Create a constant named reader and set it to your name as a string. Create a constant named author and set it to my name, Matt Galloway. Create a constant named authorIsReader that uses string equality to determine if reader and author are equal.

let reader = "Lucas"
let author = "Matt Galloway"
let authorIsReader = reader == author

// 4. Create a constant named readerBeforeAuthor which uses string comparison to determine if reader comes before author.
let readerBeforeAuthor = reader < author


//: The `if statement`
if 2 > 1 {
    print("Yes, 2 is greater than 1")
}

// using `else` clause
let animal = "Fox"
if animal == "Cat" || animal == "Dog" {
    print("Animal is a house pet.")
} else {
    print("Animal is not a house pet.")
}

// using `else-if`
let hourOfDay = 12
var timeOfDay = ""
if hourOfDay < 6 {
    timeOfDay = "Early morning"
} else if hourOfDay < 12 {
    timeOfDay = "Morning"
} else if hourOfDay < 17 {
    timeOfDay = "Afternoon"
} else if hourOfDay < 20 {
    timeOfDay = "Evening"
} else if hourOfDay < 24 {
    timeOfDay = "Late evening"
} else {
    timeOfDay = "INVALID HOUR!"
}
print(timeOfDay)


//: Ternary Conditional Operator
let a = 5
let b = 10
let min = a < b ? a : b
let max = a > b ? a : b


//: Mini Exercise

// 1. Create a constant named myAge and initialize it with your age. Write an if statement to print out Teenager if your age is between 13 and 19 and Not a teenager if your age is not between 13 and 19.
let myAgeAgain = 21
if myAgeAgain >= 13 && myAge <= 19 {
    print("I'm a teenager")
} else {
    print("Not a teenager! LOL!")
}


//2. Create a constant named answer and use a ternary condition to set it equal to the result you print out for the same cases in the above exercise. Then print out answer.
let answer = myAge >= 13 && myAge <= 19 ? "I'm a teenager" : "Not a teenager! LOL!"
print(answer)


//: Loops


// While Loops
//while true { } // infinite loop

var sum = 1
while sum < 1000 {
    sum += sum+1
    print(sum)
}


// Repeat-while Loops --> the condition here is evaluated at the end of the loop rather than at the beginning like the while-loops
sum = 1
repeat {
    sum += sum+1
} while sum < 1


//: Breaking out of a loop
sum = 1
while true {
    sum += sum+1
    if sum >= 1000 {
        break
    }
}


//: Mini Exercise

//1. Create a variable named counter and set it equal to 0. Create a while loop with the condition counter < 10, which prints out counter is X (where X is replaced with counter value) and then increments counter by 1.
var counter = 0
while counter < 10 {
    print("counter is \(counter)")
    counter += 1
}

//2. Create a variable named counter and set it equal to 0. Create another variable named roll and set it equal to 0. Create a repeat-while loop. Inside the loop, set roll equal to Int.random(in: 0...5) which means to pick a random number between 0 and 5. Then increment counter by 1. Finally, print After X rolls, roll is Y where X is the value of counter and Y is the value of roll. Set the loop condition such that the loop finishes when the first 0 is rolled.

var anotherCounter = 0
var roll = 0

repeat {
    roll = Int.random(in: 0...5)
    anotherCounter += 1
    
    print("After \(anotherCounter) rolls, roll is \(roll) where \(anotherCounter) is the value of counter and \(roll) is the value of roll")
} while roll != 0



//: Challenges

/*
 Challenge 1: Find the error
 What’s wrong with the following code?
 
 let firstName = "Matt"
 if firstName == "Matt" {
 let lastName = "Galloway"
 } else if firstName == "Ray" {
 let lastName = "Wenderlich"
 }
 
 let fullName = firstName + " " + lastName
 
 ANSWER: lastName constants is inside the scope of if statements, therefore you can't use it outside of its scope
 */


/*
 Challenge 2: Boolean challenge
 In each of the following statements, what is the value of the Boolean answer constant?
 
 let answer = true && true // true
 let answer = false || false // false
 let answer = (true && 1 != 2) || (4 > 3 && 100 < 1) // true
 let answer = ((10 / 2) > 3) && ((10 % 2) == 0) // true
 */

/*
 Challenge 3: Snakes and ladders
 Imagine you’re playing a game of snakes & ladders that goes from position 1 to position 20. On it, there are ladders at positions 3 and 7, which take you to 15 and 12, respectively. Then there are snakes at positions 11 and 17, which take you to 2 and 9, respectively.
 
 Create a constant called currentPosition, which you can set to whatever position between 1 and 20 you like. Then create a constant called diceRoll, which you can set to whatever roll of the dice you want. Finally, calculate the final position considering the ladders and snakes, calling it nextPosition.
 */

let currentPosition = 3
let diceRoll = 4

var nextPosition = currentPosition + diceRoll
var finalPosition = 0

if nextPosition == 3 {
    finalPosition = 15
} else if nextPosition == 7 {
    finalPosition = 12
} else if nextPosition == 11 {
    finalPosition = 2
} else if nextPosition == 17 {
    finalPosition = 9
} else {
    finalPosition = nextPosition
}

print(finalPosition)


/*
 Challenge 4:
 Given a month (represented with a String in all lowercase) and the current year (represented with an Int), calculate the number of days in the month. Remember that because of leap years, “february” has 29 days when the year is a multiple of 4 but not a multiple of 100. February also has 29 days when the year is a multiple of 400.
 */



let month = "feb"
let year = 2016

var days = 0
if month == "jan" || month == "mar" || month == "may" || month == "jul" || month == "aug" || month == "oct" || month == "dec" {
    days = 31
} else if month == "apr" || month == "jun" || month == "sep" || month == "nov" {
    days = 30
} else if month == "feb" {
    if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
        days = 29
    } else {
        days = 28
    }
}

print("Today is \(month) \(year). \(month) \(year) has \(days) days")



/*
 Challenge 5: Given a number, determine the next power of two above or equal to that number.
 */

let number = 200
var trial = 1
var times = 0
while trial < number {
    trial = trial * 2
    times += 1
}

print("Next power of 2 >= \(number) is \(trial) which is 2 to the power of \(times)")


/*
 Challenge 6: Given a number, print the triangular number of that depth. You can get a refresher of triangular numbers here: https://en.wikipedia.org/wiki/Triangular_number
 */
var depth = 5
var count = 1
var triangularNumber = 0
while count <= depth {
    triangularNumber += count
    count += 1
}
print("Triangular number with depth \(depth) is \(triangularNumber)")


/*
 Challenge 7: Calculate the nth Fibonacci number. Remember that Fibonacci numbers start their sequence with 1 and 1, and then subsequent numbers in the sequence are equal to the previous two values added together. You can get a refresher here: https:// en.wikipedia.org/wiki/Fibonacci_number
 */

let n = 12
var current = 1
var previous = 1
var done = 2
while done < n {
    let next = current + previous
    previous = current
    current = next
    done += 1
}
print("Fibonacci number \(n) is \(current)")


/*:
 ### Challenge 8: Make a loop
 Use a loop to print out the times table up to 12 of a given factor.
 */

let factor = 7

var i = 0
var accumulator = 0
while i <= 12 {
    print("\(factor) x \(i) = \(accumulator)")
    accumulator += 7
    i += 1
}


/*:
 ### Challenge 9: Dice roll table
 Print a table showing the number of combinations to create each number from 2 to 12, given two six-sided dice rolls. You should not use a formula but rather compute the number of combinations exhaustively by considering each possible dice roll.
 */

var target = 2

while target <= 12 {
    var combinationsFound = 0
    var valueOnFirstDice = 1
    while valueOnFirstDice <= 6 {
        var valueOnSecondDice = 1
        while valueOnSecondDice <= 6 {
            if valueOnFirstDice + valueOnSecondDice == target {
                combinationsFound += 1
            }
            valueOnSecondDice += 1
        }
        valueOnFirstDice += 1
    }
    
    print("\(target):\t\(combinationsFound)")
    
    target += 1
}
