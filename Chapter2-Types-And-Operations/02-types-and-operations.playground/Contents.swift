import UIKit


//: Type Inference

let typeInferredInt = 10 // Inferred as Int


//: Character and Strings

let aCharacter: Character = "a"
let characterDog: Character = "🐶"

// Strings
//let stringDog: String = "Dog"
let stringDog = "Dog" // Inferred as a String

//: If you want to declared a variable as a Character. You have to explicitly declare its type as Character or else it will be inferred as a String


//: Concatenation
var message = "Hello" + " my name is "
let name = "Lucas"
message += name

// To add a character to a string, do this
let exclamationMark: Character = "!"
message += String(exclamationMark)


//: String Interpolation - much easier to read
message = "Hello my name is \(name)!"

//: Multi-line Strings
let multiLineString = """
You can have a string
that contains
multiple lines
like this!
"""
print(multiLineString)

//: Mini Exercises

// 1
let firstName = "Lucas"
let lastName = "Salvador"

// 2
let fullName = firstName + " " + lastName

// 3
let myDetails = "Hello, my name is \(fullName)"


/*:
 Tuples
 is a type that represents data composed of more than one value of any type
*/

let coordinates: (Int, Int) = (2, 3)

// Type inference can infer tuples too
let inferredCoordinates = (2, 3)

let coordinatesDouble = (2.1, 3.5)

let coordinatesMixed = (3.5, 5) // Inferred as (Double, Int)

// How to access?
coordinatesMixed.0
coordinatesMixed.1

// How to add name in individual parts of the tuple?
let namedCoordinates = (x: 5.5, y: 2.3)

// Access it with the name you declared
namedCoordinates.x
namedCoordinates.y

let coordinates3D = (x: 2, y: 1, z: 3)
//let (x3, y3, z3) = coordinates3D

let x3 = coordinates3D.x
let y3 = coordinates3D.y
let z3 = coordinates3D.z

// If you want to ignore certain element of a tuple
let (x4, y4, _) = coordinates3D


//: Mini Exercise

// 1. Declare a constant tuple that contains three Int values followed by a Double. Use this to represent a date (month, day, year) followed by an average temperature for that date.
let someTuple = (5, 5, 2022, 30.0)

// 2. Change the tuple to name the constituent components. Give them names related to the data they contain: month, day, year and averageTemperature.
let someTuple2 = (month: 5, day: 5, year: 2022, averageTemperature: 30.0)

// 3. In one line, read the day and average temperature values into two constants. You’ll need to employ the underscore to ignore the month and year.
let (_, day, _, averageTemp) = someTuple2
day
averageTemp

// 4. Up until now, you’ve only seen constant tuples. But you can create variable tuples, too. Change the tuple you created in the exercises above to a variable by using var instead of let. Now change the average temperature to a new value.
var mutableTuple = (month: 5, day: 5, year: 2022, averageTemperature: 30.0)
mutableTuple.averageTemperature = 35
mutableTuple


//: Type aliases
typealias Animal = String
let myPet: Animal = "Dog"


typealias Coordinates = (Int, Int)
let xy: Coordinates = (2, 4)



//: Challenges

// 1. Create a constant called coordinates and assign a tuple containing two and three to it.

let someCoordinates = (2, 3)

// 2. Create a constant called namedCoordinate with a row and column component.
let namedCoordinate = (row: 2, column: 3)


/*
 3. Which of the following are valid statements?
 
 let character: Character = "Dog" // invalid
 let character: Character = "🐶" // valid
 let string: String = "Dog" // valid
 let string: String = "🐶" // valid
 */


/*
 4. Does it compile?
 
 let tuple = (day: 15, month: 8, year: 2015)
 let day = tuple.Day
 
 ANSWER: no, it should be tuple.day not tuple.Day
 */


/*
 5. Find the error
 
    let name = "Matt" // should not be declared as a constant
    name += " Galloway"
 */


/*
 6. What is the type of the constant named value?
    let tuple = (100, 1.5, 10)
    let value = tuple.1
 
 ANSWER: Double
 */

/*
7. What is the value of the constant named month?
 
    let tuple = (day: 15, month: 8, year: 2015)
    let month = tuple.month
 
 ANSWER: Int
 */

/*
 8. What is the value of the constant named summary?
 
 let number = 10
 let multiplier = 5
 let summary = "\(number) multiplied by \(multiplier) equals \(number * multiplier)"
 
 ANSWER: 10 multiplied by 5 equals 50
 */


/*
 9. What is the sum of a and b, minus c?
 
    let a = 4
    let b: Int32 = 100
    let c: UInt8 = 12
 
 ANSWER: Can't add values that doesn't have same types
 */


/*
 10. What is the numeric difference between Double.pi and Float.pi?
 
 ANSWER: Float.pi is less precised than the Double.pi and it takes less storage than Double.pi
 */
