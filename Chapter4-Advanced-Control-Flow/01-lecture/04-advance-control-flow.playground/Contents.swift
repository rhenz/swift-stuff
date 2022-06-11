import UIKit

var greeting = "Hello, playground"

/*:
 ### Countable ranges
 is a data type, which lets your represent a sequence of countable integers
 */

let closedRange = 0...5

// ... 3 dots indicate that this range is closed, which means the range goes from 0 - 5 inclusive. 0, 1, 2, 3, 4, 5

//: countable half-open range

let halfOpenRange = 0..<5 // 0,1,2,3,4

/*:
 ### A Random interlude
 Using Int.random(in:)
 */

while Int.random(in: 1...6) != 6 {
    print("Not a six! Duh!")
}



/*:
 ### For loops
 The most common loop you'll see
 */

let count = 10
var sum = 0
for i in 1...count {
    sum += i
}


sum = 1
var lastSum = 0
for _ in 0..<count {
    let temp = sum
    sum = sum + lastSum
    lastSum = temp
}

// Perform iterations under certain conditions
sum = 0
for i in 1...count where i % 2 == 1 {
    sum += 1
}


/*:
 ### Continue and labeled statements
 Sometimes you'd like to skip a loop iteration for a particular case without breaking out of the loop entirely.
 */

sum = 0
for row in 0..<8 {
    if row % 2 == 0 {
        continue
    }
    
    for column in 0..<8 {
        sum += row * column
    }
}
sum


// Using for loop with label

sum = 0
rowLoop: for row in 0..<8 {
columnLoop: for column in 0..<8 {
    if row == column {
        continue rowLoop
    }
    sum += row * column
}
}
sum



/*:
 ### Switch statements
 We can also control flow via `switch` statement.
 */

let number = 10
switch number {
case 0:
    print("Zero")
default:
    print("Non-zero")
}


// Another example
switch number {
case 10:
    print("It’s ten!")
default:
    break
}

// It also works with String
let string = "Dog"
switch string {
case "Cat", "Dog":
    print("Animal is a house pet.")
default:
    print("Animal is not a house pet.")
}


/*:
 ### Advance switch statements
 We can also give our switch statements more than one case
 */

let hourOfDay = 12
var timeOfDay = ""
switch hourOfDay {
case 0, 1, 2, 3, 4, 5:
    timeOfDay = "Early morning"
case 6, 7, 8, 9, 10, 11:
    timeOfDay = "Morning"
case 12, 13, 14, 15, 16:
    timeOfDay = "Afternoon"
case 17, 18, 19:
    timeOfDay = "Evening"
case 20, 21, 22, 23:
    timeOfDay = "Late evening"
default:
    timeOfDay = "INVALID HOUR!"
}
print(timeOfDay)


// Here comes the `ranges`! It's very useful with switch statements as well! It makes our code much cleaner than the example above
switch hourOfDay {
case 0...5:
    timeOfDay = "Early morning"
case 6...11:
    timeOfDay = "Morning"
case 12...16:
    timeOfDay = "Afternoon"
case 17...19:
    timeOfDay = "Evening"
case 20..<24:
    timeOfDay = "Late evening"
default:
    timeOfDay = "INVALID HOUR!"
}
print(timeOfDay)


// We can also put certain conditions with switch cases
switch number {
case let x where x % 2 == 0:
    print("Even")
default:
    print("Odd")
}

// We can also ignore to make constant value with switch cases too
switch number {
case _ where number % 2 == 0:
    print("Even")
default:
    print("Odd")
}


/*:
 ### Partial matching
 Another useful way we can use switch statements
 */

let coordinates = (x: 0, y: 0, z: 99)
switch coordinates {
case (0, 0, 0): // 1
    print("Origin")
case (_, 0, 0): // 2
    print("On the x-axis.")
case (0, _, 0): // 3
    print("On the y-axis.")
case (0, 0, _): // 4
    print("On the z-axis.")
default:        // 5
    print("Somewhere in space")
}


// We can also bind the value to a constant
switch coordinates {
case (0, 0, 0):
    print("Origin")
case (let x, 0, 0):
    print("On the x-axis at x = \(x)")
case (0, let y, 0):
    print("On the y-axis at y = \(y)")
case (0, 0, let z):
    print("On the z-axis at z = \(z)")
case let (x, y, z):
    print("Somewhere in space at x = \(x), y = \(y), z = \(z)")
}


// We can also use switch statemene for complex cases that has certain conditions like:

switch coordinates {
case let (x, y, _) where y == x:
    print("Along the y = x line.")
case let (x, y, _) where y == x * x:
    print("Along the y = x^2 line.")
default:
    break
}
