import UIKit

//: ### Challenges


/*: ### Challenge 1: Ice Cream
 
 Rewrite the IceCream structure below to use default values and lazy initialization:
 
 ```
 struct IceCream {
   let name: String
   let ingredients: [String]
 }
 ```
 1. Use default values for the properties.
 2. Lazily initialize the ingredients array.
 
 */

struct IceCream {
    let name: String = ""
    
    lazy var ingredients: [String] = {
        print("Will just initialize ingredients now...")
       return []
    }()
}

var iceCream = IceCream()
iceCream.ingredients


/*: ### Challenge 2: Car and Fuel Tank
 
 At the beginning of the chapter, you saw a Car structure. Dive into the inner workings of the car and rewrite the FuelTank structure below with property observer functionality:
 
 ```
 struct FuelTank {
  var level: Double // decimal percentage between 0 and 1
 }
 ```
 
 1. Add a lowFuel stored property of Boolean type to the structure.
 2. Flip the lowFuel Boolean when the level drops below 10%.
 3. Ensure that when the tank fills back up, the lowFuel warning will turn off.
 4. Set the level to a minimum of 0 or a maximum of 1 if it gets set above or below the expected values.
 5. Add a FuelTank property to Car.
 */

struct Car {
    let make: String
    let color: String
    
    // 5.
    var fuelTank: FuelTank
}

struct FuelTank {
    // 4
    static let minimumLevel: Double = 0
    static let maximumLevel: Double = 1
    
    //decimal percentage betwen 0 and 1
    var level: Double {
        didSet {
            // 2.
            lowFuel = level < 0.1
            
            // 3.
            if level < 0 { level = Self.minimumLevel }
            if level > 1 { level = Self.maximumLevel }
            
        }
    }
    
    // 1
    var lowFuel: Bool = false
}

// Create Fuel Tank
let fuelTank = FuelTank(level: 1) // full tank

// Create a car
var myCar = Car(make: "Honda", color: "Black", fuelTank: fuelTank)

// Check if low in fuel
myCar.fuelTank.lowFuel

// Fuel tank becomes less than 10%
myCar.fuelTank.level = 0.09

// Check if low in fuel
myCar.fuelTank.lowFuel

// Limiting variable
myCar.fuelTank.level = -1
myCar.fuelTank.level

myCar.fuelTank.level = 1.5
myCar.fuelTank.level

// Check if fuel low
myCar.fuelTank.lowFuel
