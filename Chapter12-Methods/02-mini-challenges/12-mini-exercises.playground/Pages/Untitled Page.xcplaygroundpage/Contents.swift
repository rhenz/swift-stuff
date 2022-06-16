import Foundation

//: ### Mini-exercises

//: Since monthsUntilWinterBreak() returns a single value and there’s not much calculation involved, transform the method into a computed property with a getter component.

struct SimpleDate {
    private static let months = ["January", "February", "March",
                                 "April", "May", "June",
                                 "July", "August", "September",
                                 "October", "November", "December"]
    
    var month: String
    
    var monthsUntilWinterBreak: Int {
        Self.months.firstIndex(of: "December")! - Self.months.firstIndex(of: month)!
    }
}

let someDate = SimpleDate(month: "June")
someDate.monthsUntilWinterBreak
 
 


//: Add a type method to the Math structure that calculates the n-th triangle number. It will be very similar to the factorial formula, except instead of multiplying the numbers, you add them.

struct Math {
    static func factorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
    
    static func nthTrigle(of number: Int) -> Int {
        (1...number).reduce(1, +)
    }
}

Math.nthTrigle(of: 10)
