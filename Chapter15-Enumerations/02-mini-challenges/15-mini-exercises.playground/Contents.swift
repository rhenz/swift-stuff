import UIKit

//: ### Mini-exercises


//: Wouldn’t it be nice to request the semester from an instance like month.semester instead of using the function? Add a semester computed property to the month enumeration so that you can run this code:

enum Month: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
    
    var semester: String {
        switch self {
        case .august, .september, .october, .november, .december:
            return "Autumn"
        case .january, .february, .march, .april, .may:
            return "Spring"
        default:
            return "Not in the scholl year"
        }
    }
}


let month = Month.january
month.semester




//: Make monthsUntilWinterBreak a computed property of the Month enumeration, so that you can execute the following code:

extension Month {
    var monthsUntilWinterBreak: Int {
        return Month.december.rawValue - self.rawValue
    }
}
if let fifthMonth = Month(rawValue: 5) {
    fifthMonth.monthsUntilWinterBreak
}



//: Create an array called coinPurse that contains coins. Add an assortment of pennies, nickels, dimes and quarters to it.

enum Coin: Int {
    case penny = 1
    case nickel = 5
    case dime = 10
    case quarter = 25
}

var coinPurse: [Coin] = []
coinPurse.append(.dime)
coinPurse.append(.quarter)
coinPurse.append(.nickel)
coinPurse.append(.penny)
coinPurse.append(.penny)
coinPurse.append(.penny)
coinPurse.append(.nickel)

print(coinPurse)


//: A household light switch is another example of a state machine. Create an enumeration for a light that can switch .on and .off.

enum LightStatus {
    case on
    case off
}

let light = LightStatus.on
light


//: Euler’s number is useful in calculations for statistical bell curves and compound growth rates. Add the constant e, 2.7183, to your Math namespace. Then you can figure out how much money you’ll have if you invest $25,000 at 7% continuous interest for 20 years:
/*:
 ```
 let nestEgg = 25000 * pow(Math.e, 0.07 * 20) // $101,380.95
 ```
 */

enum Math {
    static let e = 2.7183
    
    static func factorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
}

let nestEgg = 25000 * pow(Math.e, 0.07 * 20)
