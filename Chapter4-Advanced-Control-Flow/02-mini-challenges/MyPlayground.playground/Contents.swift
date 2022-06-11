import UIKit

var greeting = "Hello, playground"


/*:
 Create a constant named range and set it equal to a range starting at 1 and ending with 10 inclusive. Write a for loop that iterates over this range and prints the square of each number.
 */
let range = 1...10
for i in range {
    print(i*i)
}


/*:
 Write a for loop to iterate over the same range as in the exercise above and print the square root of each number. You’ll need to type convert your loop constant.
 */
for i in range {
    print(Double(i).squareRoot())
}


/*:
 Above, you saw a for loop that iterated over only the even rows like so:
 

 
 Change this to use a where clause on the first for loop to skip even rows instead of using continue. Check that the sum is 448, as in the initial example.
 */

/*
 sum = 0
 for row in 0..<8 {
 if row % 2 == 0 {
 continue
   }
   for column in 0..<8 {
     sum += row * column
   }
 }
 */

var sum = 0
for row in 0..<8 where row % 2 != 0 {
    for column in 0..<8 {
        sum += row * column
    }
}
sum


/*:
 ### Switch Mini-exercise
 */

//: 1. Write a switch statement that takes an age as an integer and prints out the life stage related to that age. You can make up the life stages or use my categorization: 0-2 years, Infant; 3-12 years, Child; 13-19 years, Teenager; 20-39, Adult; 40-60, Middle-aged; 61+, Elderly.

let age: UInt = 25
switch age {
case 0...2:
    print("Infant")
case 3...12:
    print("Child")
case 13...19:
    print("Teenager")
case 20...39:
    print("Adult")
case 40...60:
    print("Middle-aged")
default:
    print("Elderly")
}


//: 2. Write a switch statement that takes a tuple containing a string and an integer. The string is a name, and the integer is an age. Use the same cases you used in the previous exercise and let syntax to print out the name followed by the life stage. For example, for myself, it would print out "Matt is an adult.".

let person = (name: "Lucas", age: 1)

switch person {
case (let name, 0...2):
    print("\(name) is Infant")
case (let name, 3...12):
    print("\(name) is Child")
case (let name, 13...19):
    print("\(name) is Teenager")
case (let name, 20...39):
    print("\(name) is Adult")
case (let name, 40...60):
    print("\(name) is Middle-aged")
default:
    print("Unknown!")
}
