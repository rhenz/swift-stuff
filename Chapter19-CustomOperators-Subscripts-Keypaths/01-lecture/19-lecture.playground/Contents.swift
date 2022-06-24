import UIKit

/* ### Custom Operators, Subscripts & Keypaths
 
 We can define our own operators when we want to define custom behavior not covered by the standard operators. For example, exponentation. We could overload the multiplication operator since exponentation means repeated multiplication. Still, it would be confusing. Operators should do only one type of operation, not two.
 
 So we will define our own operator, first only for specific type, then extend it by making it generic
 
 */


//: ### Types of operators
/*:
 - `Unary` operators work with only one operand and are defined either as `postfix` if they appear after the operand or `prefix` if they appear before the operand.
 
 - `Binary` operators work with two operands and are `infix` because they appear between them. All the arithmetic operators (+, -, *, /, %), comparison operators (==, !=, <, >, <=, >=) and most of the logical ones (&&, ||) are binary infix.
 
 - `Ternary` operators work with three operands. You’ve learned about the conditional operator in Chapter 3, “Basic Control Flow”, and this operator is the only ternary operator in Swift.
 */



//: ### Our own operator

// Now we are going to make a binary operator(infix) for exponentation

//infix operator **
infix operator **=

//func **(base: Int, power: Int) -> Int {
//    precondition(power >= 2)
//    var result = base
//    for _ in 2...power {
//        result *= base
//    }
//    return result
//}

let base = 5
let exponent = 3
let result = base ** exponent
print(result)


//: ### Compounds assignment operator
//: Most built-in operators have corresponding `compound assignment` version. Do the same for the exponentation operator


//func **=(lhs: inout Int, rhs: Int) {
//    lhs = lhs ** rhs
//}

var number = 2
number **= exponent


//: ### Generic operators

func **<T: BinaryInteger>(base: T, power: Int) -> T {
    precondition(power >= 2)
    var result = base
    for _ in 2...power {
        result *= base
    }
    return result
}

func **=<T: BinaryInteger>(lhs: inout T, rhs: Int) {
    lhs = lhs ** rhs
}



let unsignedBase: UInt = 2
let unsignedResult = unsignedBase ** exponent
let base8: Int8 = 2
let result8 = base8 ** exponent
let unsignedBase8: UInt8 = 2
let unsignedResult8 = unsignedBase8 ** exponent
let base16: Int16 = 2
let result16 = base16 ** exponent
let unsignedBase16: UInt16 = 2
let unsignedResult16 = unsignedBase16 ** exponent
let base32: Int32 = 2
let result32 = base32 ** exponent
let unsignedBase32: UInt32 = 2
let unsignedResult32 = unsignedBase32 ** exponent
let base64: Int64 = 2
let result64 = base64 ** exponent
let unsignedBase64: UInt64 = 2
let unsignedResult64 = unsignedBase64 ** exponent


//: ### Precedence and associativity
/*:
 • Precedence: Should the multiplication be done before or after the exponentiation?
 • Associativity: Should the consecutive exponentiations be done left to right or right to left?
 */

precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}
infix operator **: ExponentiationPrecedence

2 * 2 ** 3 ** 2


//: ### Subscripts
class Person {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


let me = Person(name: "Cosmin", age: 36)

// It would be nice to access my characteristics with a subscript like me["name"], me["age"], me["gender"]

//: Creating subscripts
extension Person {
    subscript (key: String) -> String? {
        switch key {
        case "name": return name
        case "age": return "\(age)"
        default: return nil
        }
    }
}

me["name"]
me["age"]
me["gender"] // nil


// A nice way to create subscripts also would be like
enum PersonKey {
    case name
    case age
}

extension Person {
    subscript(key: PersonKey) -> String {
        switch key {
        case .age: return "\(age)"
        case .name: return name
        }
    }
}

// So that you would have autocompletes and nil values when using Enum types as subscript key
me[.age]
me[.name]


//: ### Subscript parameters

// Subscripts can also have some parameters
//extension Person {
//    subscript(property key: PersonKey) -> String {
//        switch key {
//        case .age: return "\(age)"
//        case .name: return name
//        }
//    }
//}
//me[property: .name]


//: ### Static subscripts

class File {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    static subscript(key: String) -> String {
        switch key {
        case "path":
            return "custom path"
        default:
            return "default path"
        }
    }
}

File["path"]
File["PATH"]


//: ### Dynamic member lookup
//: We can use `dynamic member lookup` to provide arbitrary dot syntax to our type

@dynamicMemberLookup
class Instrument {
    let brand: String
    let year: Int
    private let details: [String: String]
    
    init(brand: String, year: Int, details: [String: String]) {
        self.brand = brand
        self.year = year
        self.details = details
    }
    
    subscript(dynamicMember key: String) -> String {
        switch key {
        case "info": return "\(brand) made in \(year)"
        default: return details[key] ?? ""
        }
    }
}


let instrument = Instrument(brand: "Roland", year: 2021, details: ["type": "acoustic", "pitch": "C"])


instrument.info
instrument.pitch


//: ### Keypaths
//: Keypaths enable us to store references to properties.

class Tutorial {
    let title: String
    let author: Person
    let details: (type: String, category: String)
    init(title: String, author: Person,
         details: (type: String, category: String)) {
        self.title = title
        self.author = author
        self.details = details
    } }
let tutorial = Tutorial(title: "Object Oriented Programming in Swift",
                        author: me,
                        details: (type: "Swift",
                                  category: "iOS"))

let title = \Tutorial.title
let tutorialTitle = tutorial[keyPath: title]

// Keypaths can access properties several levels deep
let authorName = \Tutorial.author.name
var tutorialAuthor = tutorial[keyPath: authorName]

// Can also use keypaths for tuples
let type = \Tutorial.details.type
let tutorialType = tutorial[keyPath: type]
let category = \Tutorial.details.category
let tutorialCategory = tutorial[keyPath: category]

// Keypath member lookup
struct Point {
    let x, y: Int
}

@dynamicMemberLookup
struct Circle {
    let center: Point
    let radius: Int
    
    subscript(dynamicMember keyPath: KeyPath<Point, Int>) -> Int {
        center[keyPath: keyPath]
    }
}

let center = Point(x: 1, y: 2)
let circle = Circle(center: center, radius: 1)
circle.x
circle.y

// Keypath as functions
let anotherTutorial = Tutorial(title: "Encoding and Decoding in Swift", author: me, details: (type: "Swift", category: "iOS"))
let tutorials = [tutorial, anotherTutorial]
let titles = tutorials.map(\.title)
