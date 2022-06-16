import UIKit

//: ### Methods
//: Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type.



//: ### Turning function into a method


/*:
 ```
 let months = ["January", "February", "March",
 "April", "May", "June",
 "July", "August", "September",
 "October", "November", "December"]
 
 struct SimpleDate {
 var month: String
 }
 
 func monthsUntilWinterBreak(from date: SimpleDate) -> Int {
 months.firstIndex(of: "December")! - months.firstIndex(of: date.month)!
 }
 ```
 */


// How would you convert the function monthsUntilWinterBreak into a method?
let months = ["January", "February", "March",
              "April", "May", "June",
              "July", "August", "September",
              "October", "November", "December"]

//struct SimpleDate {
//    var month: String
//
//    func monthsUntilWinterBreak(from date: SimpleDate) -> Int {
//        months.firstIndex(of: "December")! - months.firstIndex(of: date.month)!
//    }
//}

// There is no identifying keyword for a `method`, it's just a function inside a named type
//let date = SimpleDate(month: "June")
//date.monthsUntilWinterBreak(from: date)


// We may notice that the method definition is awkward, there's a better way to write this method without passing any date parameter anymore coz we set a value for month already.

//: Introducing `self`
/*
 struct SimpleDate {
 var month: String
 
 func monthsUntilWinterBreak() -> Int {
 //        months.firstIndex(of: "December")! - months.firstIndex(of: self.month)!
 months.firstIndex(of: "December")! - months.firstIndex(of: month)!
 }
 }
 
 let date = SimpleDate(month: "June")
 date.monthsUntilWinterBreak()
 */

// now this looks a lot cleaner. We removed the parameter of the method we have. One more thing we can do is we can remove the `self` keyword.


//: ### Introducing initializers

//: Initializers are special methods we call to create a new instance. They omit the `func` keyword and even a name, and instead they use `init`. An initializer can have a parameters, but it doesn't have to

/*
 struct SimpleDate {
 private static let months = ["January", "February", "March",
 "April", "May", "June",
 "July", "August", "September",
 "October", "November", "December"]
 
 var month: String
 
 init() {
 month = "January"
 }
 
 var monthsUntilWinterBreak: Int {
 Self.months.firstIndex(of: "December")! - Self.months.firstIndex(of: month)!
 }
 }
 
 let someDate = SimpleDate()
 someDate.monthsUntilWinterBreak
 */

//: Initializers in structures


//: Remember that when you create your own initializer for structures, the memberwise initializer done by Swift for you will be scrapped/no longer available. Hence, you have to create your own initializer that is similar to that.

/*:
 ```
 struct SimpleDate {
 private static let months = ["January", "February", "March",
 "April", "May", "June",
 "July", "August", "September",
 "October", "November", "December"]
 
 var month: String
 var day: Int
 
 init() {
 month = "January"
 day = 1
 }
 
 init(month: String, day: Int) {
 self.month = month
 self.day = day
 }
 
 var monthsUntilWinterBreak: Int {
 Self.months.firstIndex(of: "December")! - Self.months.firstIndex(of: month)!
 }
 }
 
 let someDate = SimpleDate()
 someDate.monthsUntilWinterBreak
 
 let anotherDate = SimpleDate(month: "June", day: 16)
 anotherDate.monthsUntilWinterBreak
 ```
 */


//: ### Default values and initializers
//: There is a more straightforward way to make a no-argument initializers, that is when we create a default values for parameters, the automatic memberwise initializer will use them.

struct SimpleDate {
    private static let months = ["January", "February", "March",
                                 "April", "May", "June",
                                 "July", "August", "September",
                                 "October", "November", "December"]
    
    var month = "January"
    var day = 1
    
    var monthsUntilWinterBreak: Int {
        Self.months.firstIndex(of: "December")! - Self.months.firstIndex(of: month)!
    }
}

let someDate = SimpleDate()
someDate.monthsUntilWinterBreak


//: Even though we set a default values and we removed the custom initializer we have. Memberwise initializer is smart enough to detect that there is a default value for the stored properties, and it still gives you a initializer init(month:day), init(month:), init(day:)

let dateWithMonthOnly = SimpleDate(month: "June")
dateWithMonthOnly.month
dateWithMonthOnly.day

let dateWithDayOnly = SimpleDate(day: 1)
dateWithDayOnly.month
dateWithDayOnly.day


//: ### Introducing `mutating` methods
//: methods in structure cannot change the values of the instance without being marked as `mutating`.

// To create a mutating method:
extension SimpleDate {
    //    func advanceDay() {
    //        day += 1 // will throw error
    //    }
    
    mutating func advanceDay() {
        day += 1
    }
}


//: ### Type methods
//: like `type properties`, we can use `type methods` to access data accross all instances.


struct Math {
    static func factorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
}

Math.factorial(of: 6) // 720


//: ### Adding to an existing structure with extension
//: Sometimes we may want to add functionality to a structure, but don't want to restructure the original definition. And sometimes, we can't add direction because we don't have access to the source code..

extension Math {
    static func primeFactors(of value: Int) -> [Int] {
        
        var remainingValue = value
        
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


//: ### Keeping the compiler-generated initializer using `extensions`
//: With SimpleDate structure, we learned that once you added your own init(), the compiler-generated memberwise initializer disappeared. It turns out we can keep both if we add our own init() to an extension of this structure

extension SimpleDate {
    init(month: Int, day: Int) {
        self.month = Self.months[month-1]
        self.day = day
    }
}

