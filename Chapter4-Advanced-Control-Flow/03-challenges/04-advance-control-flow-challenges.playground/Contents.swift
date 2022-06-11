import UIKit


/*:
 ### Challenges
 */

/*:
 ## Advanced Control Flow
 ### Challenge 1: How many times
 In the following for loop:
 
 ```
 var sum = 0
 for i in 0...5 {
   sum += i
 }
 ```
 What will be the value of `sum`, and how many iterations will happen?
 */
// ANSWER: Iterations = 6, sum = 15



/*:
 ## Advanced Control Flow
 ### Challenge 2: Count the letter
 In the while loop below, how many instances of “a” will there be in aLotOfAs? Hint: aLotOfAs.count tells you how many characters are in the string aLotOfAs.
 
 ```
 var aLotOfAs = ""
 while aLotOfAs.count < 10 {
   aLotOfAs += "a"
 }
 ```
 */

// ANSWER: 10


/*:
 ## Advanced Control Flow
 ### Challenge 3: What will print
 Consider the following switch statement:
 
 ```
 switch coordinates {
 case let (x, y, z) where x == y && y == z:
   print("x = y = z")
 case (_, _, 0):
   print("On the x/y plane")
 case (_, 0, _):
   print("On the x/z plane")
 case (0, _, _):
   print("On the y/z plane")
 default:
   print("Nothing special")
 }
 ```
 
 What will this code print when coordinates is each of the following?
 ```
 let coordinates = (1, 5, 0)
 let coordinates = (2, 2, 2)
 let coordinates = (3, 0, 1)
 let coordinates = (3, 2, 5)
 let coordinates = (0, 2, 4)
 ```
 */

/*
 Answer in order:
 - "On the x/y plane"
 - "x = y = z"
 - "On the x/z plane"
 - "Nothing special
 - "On the y/z plane"
 */


/*:
 ## Advanced Control Flow
 ### Challenge 4: Closed range size
 A closed range can never be empty. Why?
 */

// Ranges must always be increasing. With closed range the second number is always included in the range
let closedRange = 1...1
closedRange.isEmpty


/*:
 ## Advanced Control Flow
 ### Challenge 5: The final countdown
 Print a countdown from 10 to 0. (Note: do not use the reversed() method, which will be introduced later.)
 */

for i in 0...10 {
    print(10-i)
}

/*:
 ## Advanced Control Flow
 ### Challenge 6: Print a sequence
 Print 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0. (Note: do not use the stride(from:by:to:) function, which will be introduced later.)
 */

var sequence = 0.0
for _ in 0...10 {
    print(String(format: "%.1f", sequence))
    sequence += 0.1
}

