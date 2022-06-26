import UIKit

//: ### Pattern Matching

//: If and guard

func process(point: (x: Int, y: Int, z: Int)) -> String {
    if case (0, 0, 0) = point {
        return "At origin"
    }
    return "Not at origin"
}

let point = (x: 0, y: 0, z: 0)
let status = process(point: point)

// We can also use `guard statement`
func processUsingGuard(point: (x: Int, y: Int, z: Int)) -> String {
    guard case (0, 0, 0) = point else {
        return "Not at origin"
    }
    
    // Guaranteed `point` is at origin
    return "At origin"
}

processUsingGuard(point: point)

//: In a `case` condition, we can write the pattern first followed by an equals sign, and then the value we want to match to the pattern. `if statement` and `guard statement` works best if there is a single pattern to match only.



/*: ### Switch
 
 If we want to match multiple patterns, `switch statement` is our bestfriend
 */

func processUsingSwitch(point: (x: Int, y: Int, z: Int)) -> String {
    
    let closeRange = -2...2
    let midRange = -5...5
    
    switch point {
    case (0, 0, 0):
        return "At origin"
    case (closeRange, closeRange, closeRange):
        return "Very close to origin"
    case (midRange, midRange, midRange):
        return "Nearby origin"
    default:
        return "Not near origin"
    }
}

let point2 = (x: 5, y: 5, z: 3)
let status2 = processUsingSwitch(point: point2)

// This code introduces a couple of new concepts.
// 1. We can match againts ranges of numbers
// 2. The `switch statement` allows for multiple cases to match patterns


//: ### for
// A `for loop` churns through a collection of elements. Pattern matching can act as a filter
let groupSizes = [1, 5, 4, 6, 2, 1, 3]
for case 1 in groupSizes {
    print("Found an individual")
}

// The loop's body only runs for elements in the array that match the value `1`. Since there are two 1s in the array, the print function runs twice.


//: ### Wildcard pattern
// Like in the previous example we have, the pattern in this `case` condition uses an underscore _ to match ANY VALUE of `x` components and EXACTLY 0 for `y` and `z`
let coordinate = (x: 1, y: 0, z: 0)

if case (_, 0, 0) = coordinate {
    // x can be any value. y and z must be exactly 0.
    print("On the x-axis") // Printed!
}


//: ### Value-binding pattern
//: value-binding pattern sounds sophisticated than it turns out to be in practice. We simlpy use `var` or `let` to declare a variable or a constant while matching a pattern

// We can use the value of the variable or constant inside the execution block

if case (let x, 0, 0) = coordinate {
    print("On the x-axis at \(x)")
}

// The pattern in this case condition matches any value on the x-axis and binds its x component to the constant named x for use in the execution block.

// If we want to bind multiple values, we could write let multiple times or even better move the let outside the tuple like:
if case let (x, y, 0) = coordinate {
    print("On the x-y plane at \(x), \(y)")
}





//: ### Identifier pattern
//: The identifier pattern is even more straightforward than the value-binding pattern. The identifier pattern is the constant or variable name itself; in the example above, that’s the x in the pattern. You’re telling the compiler, “When you find a value of (something, 0, 0), assign the something to x.”

// (identifier, expression, expression)
let someX = 0
if case (someX, 0, 0) = coordinate {
    print("On the X-axis")
} else {
    print("Not on X-axis")
}

//: ### Tuple pattern
// Tuple pattern combines many patterns into one and helps you write terse code.


//: ### Enumeration case pattern

enum Direction {
    case north, south, east, west
}

let heading = Direction.north

if case .north = heading {
    print("Don't forget your jacket!")
}


// The enumeration case pattern has some magic up its sleeve. When you combine it with the value binding pattern, we can extract associated values from an enumeration

enum Organism {
    case plant
    case animal(legs: Int)
}

let pet = Organism.animal(legs: 4)

switch pet {
case .animal(let legs):
    print("Potentially cuddly with \(legs) legs")
default:
    print("No chance for cuddles")
}


//: ### Optional pattern
//: The optional pattern consists of an identifier pattern followed immediately by a question mark. We can use this pattern in the same places we would use enumeration case pattern.

let names: [String?] = ["Chabby", nil, "Oli", "Nimbus", nil, "Lucas"]

for case let name? in names {
    print(name)
}

// Optional patterns are syntactic sugar for enumeration case patterns containing optional values.


//: ### `Is` type-casting pattern

let response: [Any] = [15, "George", 2.0]

for element in response {
    switch element {
    case is String:
        print("Found a string!")
    default:
        print("Found something else!")
    }
}


//: ### `As` type-casting pattern

for element in response {
    switch element {
    case let text as String:
        print("Found a string: \(text)")
    default:
        print("Found something else!")
    }
}


//: ### Advance patterns

//: ### Qualifying with where

// We can specify a `where` condition for further filter a match by checking a unary condition in-line
for number in 1...9 {
    switch number {
    case let x where x % 2 == 0:
        print("even")
    default:
        print("odd")
    }
}


// Using it with enums
enum LevelStatus {
    case complete
    case inProgress(percent: Double)
    case notStarted
}

let levels: [LevelStatus] = [.complete, .inProgress(percent: 0.9), .notStarted, .inProgress(percent: 0.6), .inProgress(percent: 0.3)]

for level in levels {
    switch level {
    case .inProgress(let percent) where percent > 0.8:
        print("Almost there!")
    case .inProgress(let percent) where percent > 0.5:
        print("Halfway there!")
    case .inProgress(let percent) where percent > 0.2:
        print("Made it through the beginning")
    default: break
    }
}



//: ### Chaining with commas
func timeOfDayDescription(hour: Int) -> String {
    switch hour {
    case 0, 1, 2, 3, 4, 5:
        return "Early morning"
    case 6, 7, 8, 9, 10, 11:
        return "Morning"
    case 12, 13, 14, 15, 16:
        return "Afternoon"
    case 17, 18, 19:
        return "Evening"
    case 20, 21, 22, 23:
        return "Late evening"
    default:
        return "INVALID HOUR!"
    }
}

let timeOfDay = timeOfDayDescription(hour: 12) // Afternoon


// Another example with previous patterns
if case .animal(let legs) = pet, case 2...4 = legs {
    print("Potentially cuddly")
} else {
    print("No chance for cuddles!")
}


// Pyramid OF DOOM!! Very hard to read!
enum Number {
    case integerValue(Int)
    case doubleValue(Double)
    case booleanValue(Bool)
}

let a = 5
let b = 6
let c: Number? = .integerValue(7)
let d: Number? = .integerValue(8)
if a != b {
    if let c = c {
        if let d = d {
            if case .integerValue(let cValue) = c {
                if case .integerValue(let dValue) = d {
                    if dValue > cValue {
                        print("a and b are different") // Printed!
                        print("d is greater than c") // Printed!
                        print("sum: \(a + b + cValue + dValue)") // 26
                    }
                }
            }
        }
    }
}

// How can we rewrite this in a much cleaner and better way?
if a != b,
   let c = c,
   let d = d,
   case .integerValue(let cValue) = c,
   case .integerValue(let dValue) = d,
   dValue > cValue {
    
    print("a and b are different")
    print("d is greater than c")
    print("sum: \(a + b + cValue + dValue)")
}


// Custom tuple
let name = "Lucas"
let age = 21

if case ("Lucas", 21) = (name, age) {
    print("Found the right Lucas!")
}


var username: String?
var password: String?
switch (username, password) {
case let (username?, password?):
    print("Success! User: \(username) Pass: \(password)")
case let (username?, nil):
    print("Password is missing. User: \(username)")
case let (nil, password?):
    print("Username is missing. Pass: \(password)")
case (nil, nil):
    print("Both username and password are missing")  // Printed!
}

// Fun with wildcards
for _ in 1...3 {
    print("hi")
}


// Validate that an optional exists
let user: String? = "Bob"
guard let _ = user else {
    print("There is no user.")
    fatalError()
}
print("User exists, but identity not needed.") // Printed!

// But this is not the best way to do this, just because you can do something, it doesn't mean you should. The best way is like:
guard user != nil else {
    fatalError("There is no user.")
}

print("User exists, but identity not needed.")

// Organize an if-else-if
struct Rectangle {
    let width: Int
    let height: Int
    let background: String
}
let view = Rectangle(width: 15, height: 60, background: "Green")
switch view {
case _ where view.height < 50:
    print("Shorter than 50 units")
case _ where view.width > 20:
    print("Over 50 tall, & over 20 wide")
case _ where view.background == "Green":
    print("Over 50 tall, at most 20 wide, & green") // Printed!
default:
    print("This view can’t be described by this example")
}

// We could write this code as a chain of if statements. When we use the switch statement, it becomes clear that each condition is a case.


//: ### Expression Pattern
let matched =  (1...10 ~= 5)

if case 1...10 = 5 {
    print("In the range..")
}
