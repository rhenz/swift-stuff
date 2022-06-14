import UIKit

//: Write a structure that represents a pizza order. Include toppings, size and any other option you’d want for a pizza.

struct PizzaOrder {
    var toppings: [String]
    var size: Double
    var flavor: String
}


//: Rewrite isInDeliveryRange to use Location and DeliveryArea.
// Basic syntax of structure
struct Location {
    let x: Int
    let y: Int
}

//struct DeliveryArea {
//    let center: Location
//    var radius: Double
//}

// Pythagorean Theorem ( )
//func distance(from source: (x: Int, y: Int),
//              to target: (x: Int, y: Int)) -> Double {
//    let distanceX = Double(source.x - target.x)
//    let distanceY = Double(source.y - target.y)
//    return (distanceX * distanceX +
//            distanceY * distanceY).squareRoot()
//}

let areas = [
    DeliveryArea(center: Location(x: 3, y: 3), radius: 2.5),
    DeliveryArea(center: Location(x: 8, y: 8), radius: 2.5)
]

func isInDeliveryRange(_ location: Location) -> Bool {
    for area in areas {
        let distanceToStore = distance(from: area.center, to: location)
        
        if distanceToStore < area.radius {
            return true
        }
    }
    return false
}


//: 1. Change distance(from:to:) to use Location as your parameters instead of x-y tuples.
func distance(from source: Location, to target: Location) -> Double {
    let distanceX = Double(source.x - target.x)
    let distanceY = Double(source.y - target.y)
    return (distanceX * distanceX + distanceY * distanceY).squareRoot()
}

//: 2. Change contains(_:) to call the new distance(from:to:) with Location.
//struct DeliveryArea {
//    let center: Location
//    var radius: Double
//
//    func contains(_ location: Location) -> Bool {
//        let distanceFromCenter = distance(from: center, to: location)
//        return distanceFromCenter < radius
//    }
//}


//: 3. Add a method overlaps(with:) on DeliveryArea that can tell you if the area overlaps with another area.

struct DeliveryArea {
    let center: Location
    var radius: Double
    
    func contains(_ location: Location) -> Bool {
        let distanceFromCenter = distance(from: center, to: location)
        return distanceFromCenter < radius
    }
    
    func overlaps(with location: Location) -> Bool {
        let distanceFromCenter = distance(from: center, to: location)
        return distanceFromCenter > radius
    }
}

let anotherAreas = [
    DeliveryArea(center: Location(x: 5, y: 5), radius: 2.5),
    DeliveryArea(center: Location(x: 2, y: 2), radius: 2.5)
]

anotherAreas[0].overlaps(with: Location(x: 1, y: 1))
anotherAreas[0].overlaps(with: Location(x: 4, y: 4))
