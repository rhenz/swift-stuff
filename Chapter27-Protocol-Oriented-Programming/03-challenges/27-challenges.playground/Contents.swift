import UIKit
import Foundation

//: ### Challenges


/*: ### Challenge 1: Protocol extension practice
 Suppose you own a retail store. You have food items, clothes and electronics. Begin with an Item protocol:
 
 ```
 protocol Item {
   var name: String { get }
   var clearance: Bool { get }
   var msrp: Double { get } // Manufacturer’s Suggested Retail Price
   var totalPrice: Double { get }
 }
 ```
 
 Fulfill the following requirements using what you’ve learned about protocol- oriented programming. In other words, minimize the code in your classes, structs or enums.
 • Clothes do not have a sales tax, but all other items have 7.5% sales tax.
 • When food items are discounted 50% on clearance, clothes are discounted 25%, and electronics are discounted 5%.
 • Items should implement CustomStringConvertible and return name. Food items should also print their expiration dates.
 */


protocol Item: CustomStringConvertible{
    var name: String { get }
    var clearance: Bool { get }
    var msrp: Double { get }
    var totalPrice: Double { get }
}

protocol Taxable: Item {
    var tax: Double { get }
}

protocol Discountable: Item {
    var discountedPrice: Double { get }
}


extension Item {
    var totalPrice: Double {
        msrp
    }
}

extension Item {
    var description: String {
        name
    }
}

extension Item where Self: Taxable {
    var totalPrice: Double {
        msrp * (1 + tax)
    }
}

extension Item where Self: Discountable {
    var totalPrice: Double {
        discountedPrice
    }
}

extension Item where Self: Taxable & Discountable {
    var totalPrice: Double {
        discountedPrice * (1 + tax)
    }
}


struct Food: Taxable, Discountable {
    var name: String
    var msrp: Double
    var clearance: Bool
    let expirationDate: (month: Int, year: Int)
    
    let tax: Double = 0.075
    
    var discountedPrice: Double {
        msrp * (clearance ? 0.50 : 1.0)
    }
    
    var description: String {
        "\(name) - expires \(expirationDate.month)/\(expirationDate.year)"
    }
}

struct Clothing: Discountable {
    var name: String
    var msrp: Double
    var clearance: Bool
    
    var discountedPrice: Double {
        msrp * (clearance ? 0.75 : 1.0)
    }
}

struct Electronic: Taxable, Discountable {
    var name: String
    var msrp: Double
    var clearance: Bool
    
    let tax: Double = 0.075
    
    var discountedPrice: Double {
        msrp * (clearance ? 0.95 : 1.0)
    }
}


Food(name: "Cheetos", msrp: 180, clearance: false, expirationDate: (11, 2023)).totalPrice
Clothing(name: "Komine", msrp: 20000, clearance: false).totalPrice
Clothing(name: "Helstons", msrp: 20000, clearance: true).totalPrice
Electronic(name: "iPhone 13 Pro Max", msrp: 80000, clearance: false).totalPrice
Electronic(name: "iPhone 12 Pro Max", msrp: 60000, clearance: true).totalPrice

// Custom String Convertible
Food(name: "Pringles", msrp: 100, clearance: false, expirationDate: (11, 2022))
Electronic(name: "iPhone 13 Pro Max", msrp: 80000, clearance: false)
Clothing(name: "Helstons", msrp: 20000, clearance: true)



/*: ### Challenge 2: Doubling values
 Write a method in protocol extension on Sequence named double() that only applies to sequences of numeric elements. Make it return an array where each element is twice the element in the sequence. Test your implementation on an array of Int and an array of Double, then see if you can try it on an array of String.
 Hints:
 • Numeric values implement the protocol Numeric.
 • Your method signature should be double() -> [Element]. The type [Element] is an array of whatever type the Sequence holds, such as String or Int.
 */


extension Sequence where Element: Numeric {
    func double() -> [Element] {
        self.map { $0 * 2 }
    }
}

let intNums = [1,2,3,4,5]
let doubleNums = [1.0, 5.0, 10.5, 20.6]

intNums.double()
doubleNums.double()
