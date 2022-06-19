import UIKit
import Foundation

//: ### Enumerations
//: Enumeration is a list of related values that define a common type and let you work with values in a type-safe way.

//: An enumeration can have methods and computed properties, all while acting as a convenient state machine


//: Your first enumeration


// Let's say you want to create a list of related values, like months in the calendar.

//enum Month {
//    case january
//    case february
//    case march
//    case april
//    case may
//    case june
//    case july
//    case august
//    case september
//    case october
//    case november
//    case december
//}


// We can simplify this into 1 line
//enum Month {
//    case january, february, march, april, may, june, july, august, september, october, november, december
//}



//: ### Deciphering an enumeration in a function
func semester(for month: Month) -> String {
    switch month {
    case .august, .september, .october, .november, .december:
        return "Autumn"
    case .january, .february, .march, .april, .may:
        return "Spring"
    default:
        return "Not in the scholl year"
    }
}


// Remember that switch statements must be exhaustive with their cases. The compiler will warn us though if they aren't. When case patterns are types like String elements, we need a default case because it it's impossible to create cases to match every possible String value. However with enumerations, it has a limited set of values we can match against so default isn't required.

// Test the function
let month = Month.january
semester(for: month)


//: ### Raw values
//: Unlike enumerations values in C, Swift enum values are not backed by integers as a default. That means `january` is itself a value


// Compiler will automatically increment the values if we provide the first one and leave out the rest
enum Month: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
}


//: ### Accessing the raw value
func monthsUntilWinterBreak(from month: Month) -> Int {
    Month.december.rawValue - month.rawValue
}

monthsUntilWinterBreak(from: .april)


//: ### Initializing with the raw value
//: We can use the raw value to instantiate an enumeration value with an initializer.

let fiftMonth = Month(rawValue: 5)
//monthsUntilWinterBreak(from: fiftMonth) // Error

//: There is no guarantee that the raw value you provided exists in the enumeration that you have, so the initializer returns an optional. This initializer is called `failable initializer, meaning if things go wrong, the initializer will return nil. In our example above, we can do optional binding to check if there's a valid valid with the rawValue we provided




//: ### String raw values
//: Like the trick we have with incrementing an Int raw value, if we specify a value type of String, we can get an automatic conversion, you get a string as is


enum Icon: String {
case music
case sports
case weather
    
    var filename: String {
        "\(rawValue).png"
    }
}

let icon = Icon.weather
icon.filename

//: ### Unordered raw values

enum Coin: Int {
case penny = 1
case nickel = 5
case dime = 10
case quarter = 25
}

let coin = Coin.quarter
coin.rawValue // 25


//: ### Associated values
//: Associated values take Swift enumerations to the next level in expressive power. They let you associate a custom value(or values) with each enumerations case.

// Let's say you are trying to withdraw a money in your bank account. By right, the ATM will never let you withdraw more than you put in, so it needs a way to let you know whether the transaction was successful or not. We can implement this as an enumeration with associated values

var balance = 100
//func withdraw(amount: Int) {
//    balance -= amount
//}


enum WithdrawalResult {
    case success(newBalance: Int)
    case error(message: String)
}

func withdraw(amount: Int) -> WithdrawalResult {
    if amount <= balance {
        balance -= amount
        return .success(newBalance: balance)
    } else {
        return .error(message: "Not enough money!")
    }
}

let result = withdraw(amount: 99)

switch result {
case .success(let newBalance):
    print("Your balance in: \(newBalance)")
case .error(let error):
    print(error)
}

enum HTTPMethod {
    case get
    case post(body: String)
}

let request = HTTPMethod.post(body: "Hello there!")
guard case .post(let body) = request else {
    fatalError("No message was posted")
}
print(body)

//: ### Enumeration as a state machine
//: An enumeration is an example of a state machine, meaning it can only ever be a single enumeration value at a time, never more.
enum TrafficLight {
    case red, yellow, green
}

let trafficLight = TrafficLight.red



//: ### Iterating through all cases

// Sometimes we may want to loop through all the cases in an enumeration. This is easy to do using the CaseIterable protocol

enum Pet: CaseIterable {
    case cat, dog, bird, turtle, fish, hamster
}

for pet in Pet.allCases {
    print(pet)
}

//: ### Enumeration without any case
//: Sometimes we may want to create a namespace to a property or function that we want to create. So instead to creating it with Struct, usually it's better with Enums since we do not need to initialize it.
//: Enums with no cases are sometimes referred to as uninhabited types or bottom types

enum Math {
    static func factorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
}

let factorial = Math.factorial(of: 6)



//: ### Optionals
var age: Int?
age = 17
age = nil

switch age {
case .none:
    print("No value")
case .some(let value):
    print("Got a value \(value)")
}

//: OPTIONALS are ENUMERATIONS under the hood. Though Swift hides the implementation details with things like optional binding, the ? and ! operators, and keywords such as nil














