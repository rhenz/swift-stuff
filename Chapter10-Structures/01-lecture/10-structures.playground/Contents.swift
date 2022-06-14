import UIKit

/*: ### Structure
 
 Structures are one of the named types in Swift that allows you to encapsulate related properties and behaviors
 */


// Basic syntax of structure
struct Location {
    let x: Int
    let y: Int
}

// Instantiating/Initializing a strucutre:
let storeLocation = Location(x: 3, y: 3)


//struct DeliveryArea {
//    let center: Location
//    var radius: Double
//
//    func contains(_ location: Location) -> Bool {
//        let distanceFromCenter = distance(from: (center.x, center.y), to: (location.x, location.y))
//        return distanceFromCenter < radius
//    }
//}

var storeArea = DeliveryArea(center: storeLocation, radius: 2.5)

//: ### Accessing members
//: We may wonder how we can access the properties of our structures here. We can easily access it using the *dot syntax*

storeArea.radius // 2.5

storeArea.center.x // 3

//: We can also assign a new value if we want to as long as the property is a not a constant(meaning declared as *var*)
storeArea.radius = 3.5



/*: ### Introducing methods
 */

// Pythagorean Theorem ( )
func distance(from source: Location, to target: Location) -> Double {
    let distanceX = Double(source.x - target.x)
    let distanceY = Double(source.y - target.y)
    return (distanceX * distanceX + distanceY * distanceY).squareRoot()
}

let areas = [
    DeliveryArea(center: Location(x: 3, y: 3), radius: 2.5),
    DeliveryArea(center: Location(x: 8, y: 8), radius: 2.5)
]

func isInDeliveryRange(_ location: Location) -> Bool {
    for area in areas {
        let distanceToStore =
        distance(from: area.center, to: location)
        if distanceToStore < area.radius {
            return true
        }
    }
    return false
}

let customerLocation1 = Location(x: 5, y: 5)
let customerLocation2 = Location(x: 7, y: 7)
isInDeliveryRange(customerLocation1) // false
isInDeliveryRange(customerLocation2) // true

let area = DeliveryArea(center: Location(x: 8, y: 8), radius: 2.5)
let customerLocation = Location(x: 7, y: 7)
area.contains(customerLocation)


/*: ### Structures as values
 
 The term value has an important meaning for structures in Swift, and that's because structures create what are known as value types
 
 A value type is a type whose instances are *copied* on assignment
 */

var a = 5
var b = a

a //5
b //5

a = 10

a // 10
b // 5

//: This copy-on-assignment behavior means that when *a* is assigned to *b*, the value of *a* is copied into *b*. But later, when you change the value of *a*, the value of *b* doesn't get affected. That's why it's important to read *=* as "assign", not "is equal to". b = a "Assign the value of *a* to *b*





//: How about the same principle, except with the DeliveryArea struct
var area1 = DeliveryArea(center: Location(x: 3, y: 3), radius: 2.5)
var area2 = area1

area1.radius //2.5
area2.radius //2.5

area1.radius = 4

area1.radius //4
area2.radius //2.5


//: Thanks to value semantics and copying, structures are *safe*, so you'll never need to worry about values being shared and possibly being changed without you knowing it by another piece of code.


//: ### Structures everywhere
//: You might be surprised that a lot of standard Swift types are structures, such as: Int, Double, String, Bool, Array and Dictionary.


//: ### Conforming to a protocol

/*:
 ```
    struct Int : FixedWidthInteger, SignedInteger {
        // ...
    }
 ```
 */


//: You may notice the types *Fixed Integer* and *SignedInteger* appear on the right after the declaration of Int. These types are known as *protocols*. By putting them after a colon when Int is declared, we signal that Int *conforms* to these protocols

//: Protocols contains a set of requirements that conforming types must satisfy:

/*:
 ```
 public protocol CustomStringConvertible {
    /// A textual representation of this instance
    var description: String { get }
 }
 ```
 
 This protocol contains one property requirement called *description*.
 */


struct DeliveryArea: CustomStringConvertible {
    let center: Location
    var radius: Double
    
    var description: String {
        """
        Area with center: (x: \(center.x), y: \(center.y),
        radius: \(radius)
        """
    }
    
    func contains(_ location: Location) -> Bool {
        let distanceFromCenter = distance(from: center, to: location)
        return distanceFromCenter < radius
    }
    
    func overlaps(with area: DeliveryArea) -> Bool {
        distance(from: center, to: area.center) <= (radius + area.radius)
    }
}
