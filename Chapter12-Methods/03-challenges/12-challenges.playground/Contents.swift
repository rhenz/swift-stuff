import UIKit

//: #### Challenges


/*: ### Challenge 1: Grow a Circle
 
 Given the Circle structure below:
 ```
 let halloween = SimpleDate(month: 10, day: 31)
 halloween.month // October
 halloween.day // 31
 struct Circle {
 var radius = 0.0
 var area: Double {
 .pi * radius * radius
 }
 }
 ```
 
 Write a method that can change an instance’s area by a growth factor. For example, if you call circle.grow(byFactor: 3), the area of the instance will triple.
 Hint: Add a setter to area.
 */

struct Circle {
    var radius = 0.0
    
    var area: Double {
        get {
            .pi * radius * radius
        }
        
        set {
            radius = (newValue / .pi).squareRoot()
        }
        
    }
    
    mutating func grow(byFactor factor: Double) {
        area *= factor
    }
}

var circle = Circle(radius: 10)
circle.area
circle.grow(byFactor: 3)
circle.area


/*: ### Challenge 2: A more advanced advance()
 Here is a naïve way of writing advance() for the SimpleDate structure you saw earlier in the chapter:
 
 ```
 let months = ["January", "February", "March",
 "April", "May", "June",
 "July", "August", "September",
 "October", "November", "December"]
 
 struct SimpleDate {
 var month: String
 var day: Int
 mutating func advance() {
 day += 1 }
 }
 
 var date = SimpleDate(month: "December", day: 31)
 date.advance()
 date.month // December; should be January!
 date.day // 32; should be 1!
 ```
 
 What happens when the function should go from the end of one month to the start of the next? Rewrite advance() to account for advancing from December 31st to January 1st.
 
 */

let months = ["January", "February", "March",
              "April", "May", "June",
              "July", "August", "September",
              "October", "November", "December"]

struct SimpleDate {
    var month: String
    var day: Int
    
    var numOfDaysInCurrentMonth: Int {
        switch month {
        case "January", "March", "May", "July", "August", "October", "December":
            return 31
        case "April", "June", "September", "November":
            return 30
        case "February":
            return 28
        default:
            return 0
        }
    }
    
    mutating func advance() {
        if day == numOfDaysInCurrentMonth {
            if month == "December" {
                month = "January"
            } else {
                month = months[months.firstIndex(of: month)!.advanced(by: 1)]
            }
            day = 1
        } else {
            day += 1
        }
    }
}

var date = SimpleDate(month: "December", day: 31)
date.advance()
date.month // December; should be January!
date.day // 32; should be 1!

/*: ### Challenge 3: Odd and Even Math
 Add type methods named isEven and isOdd to your Math namespace that return true if a number is even or odd, respectively.
 
 */

struct Math {
    static func isEven(_ num: Int) -> Bool {
        return num % 2 == 0
    }
    
    static func isOdd(_ num: Int) -> Bool {
        return num % 2 != 0
    }
}

Math.isEven(0)
Math.isEven(1231232)
Math.isEven(3)
Math.isOdd(3)


/*: ### Challenge 4: Odd and Even Int
 It turns out that Int is simply a struct. Add the computed properties isEven and isOdd to Int using an extension.
 */
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    
    var isOdd: Bool {
        return self % 2 != 0
    }
}

5.isOdd
5.isEven
6.isEven
6.isOdd


/*: ### Challenge 5: Prime Factors
 Add the method primeFactors() to Int. Since this is an expensive operation, this is best left as an actual method and not a computed property.
 */

extension Int {
    func primeFactors() -> [Int] {
        var remainingValue = self
        var testFactor = 2
        var primes: [Int] = []
        while testFactor * testFactor <= remainingValue {
            if remainingValue % testFactor == 0 {
                primes.append(testFactor)
                remainingValue /= testFactor
            }
            else {
                testFactor += 1
            }
        }
        if remainingValue > 1 {
            primes.append(remainingValue)
        }
        return primes
    }
}


10.primeFactors()
69.primeFactors()
81.primeFactors()
