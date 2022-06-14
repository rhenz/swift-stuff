import UIKit

//: ### Challenges


/*: ### Challenge 1: Fruit tree farm
 Imagine you’re at a fruit tree farm, and you grow different kinds of fruits: pears, apples, and oranges. After the fruits are picked, a truck brings them in to be processed at the central facility. Since the fruits are all mixed together on the truck, the workers in the central facility have to sort them into the correct inventory container one by one.
 Implement an algorithm that receives a truck full of different kinds of fruits and places each fruit into the correct inventory container.
 Keep track of the total weight of fruit processed by the facility and print out how many of each fruit is in the inventory.
 
 */

struct FruitTreeFarm {
    //    var fruits: [Fruit] = [] // Since we are not yet talking about mutating func
    
    func harvestFruits() -> [Fruit] {
        let randomNumberOfHarvest = Int.random(in: 30...60)
        print("HARVESTED FRUITS QUANTITY: \(randomNumberOfHarvest)")
        var fruits: [Fruit] = []
        for _ in 0..<randomNumberOfHarvest {
            fruits.append(FruitTreeFarm.generateRandomFruit())
        }
        
        return fruits
    }
    
    func deliverToCentralFacility(fruits: [Fruit]) -> CentralFacility {
        CentralFacility(receivedFruits: fruits)
    }
    
    private static func generateRandomFruit() -> Fruit {
        
        let farmFruits = ["Apple", "Orange", "Strawberry", "Tomato"]
        
        let getRandomFruit = farmFruits.randomElement()!
        
        switch getRandomFruit {
        case "Apple":
            // https://www.southtyroleanapple.com/en/info/all-about-apples.html
            return Fruit(name: getRandomFruit, weight: Int.random(in: 150...250))
        case "Orange":
            // https://preparedcooks.com/how-much-does-an-orange-weigh/
            return Fruit(name: getRandomFruit, weight: Int.random(in: 56...283))
        case "Strawberry":
            // https://strawberryplants.org/strawberry-serving/
            return Fruit(name: getRandomFruit, weight: Int.random(in: 7...27))
        case "Tomato":
            return Fruit(name: getRandomFruit, weight: Int.random(in: 7...27))
        default:
            fatalError("There should not be unknown fruit in my farm!")
        }
        
    }
}

struct Fruit: CustomStringConvertible {
    var name: String
    
    /// Weight in grams
    var weight: Int
    
    var description: String {
        """
        Fruit Name: \(name), Weight: \(weight)\n
        """
    }
}

struct Inventory: CustomStringConvertible {
    var fruitName: String
    var fruits: [Fruit]
    
    private var totalWeight: Int {
        fruits.map { $0.weight }.reduce(0, +)
    }
    
    var description: String {
        """
        "Fruit: \(fruitName) - Quantity: \(fruits.count) - Total Weight: \(totalWeight)grams\n
        """
    }
}

struct CentralFacility {
    var receivedFruits: [Fruit]
    
    func sortReceivedFruits() -> [Inventory] {
        // ["FruitName": Inventory]
        var inventoryDict: [String: Inventory] = [:]
        
        for fruit in receivedFruits {
            if let _ = inventoryDict[fruit.name] {
                inventoryDict[fruit.name]!.fruits.append(fruit)
            } else {
                inventoryDict[fruit.name] = Inventory(fruitName: fruit.name, fruits: [fruit])
            }
        }
        return inventoryDict.map { $0.value as Inventory }
    }
}

// Make a farm
let lucasTreeFarm = FruitTreeFarm()

// Harvest fruits
let harvestedFruits = lucasTreeFarm.harvestFruits()

// Delivering to the facility now
let facility = lucasTreeFarm.deliverToCentralFacility(fruits: harvestedFruits)

// Sort the fruits by their kind in inventory container
let inventoryContainer = facility.sortReceivedFruits()
print(inventoryContainer)



/*: ### Challenge 2: A T-shirt model
 Create a T-shirt structure that has size, color and material options. Provide a method to calculate the cost of a shirt based on its attributes.
 */

struct TShirt {
    /***
     1 = Xtra Small - no additional
     2 = Small - no additional
     3 = Medium - no additional
     4 = Large - +$1
     5 = X-Large - +$2
     */
    var size: Int
    
    var color: String
    
    // Disclaimer: I don't have any idea how each material should cost. LOL
    /**
     Cotton: standard price
     Linen: + $1.5
     Polyester: +$2.5
     Lycra: +$3.5
     Rayon: +$4.5
     */
    var material: String
    
    func calculateCost() -> String {
        let standardPrice = 5.0
        var totalCost = standardPrice
        totalCost += updateCost(by: size, and: material)
        
        return "$\(totalCost)"
    }
    
    private func updateCost(by size: Int, and material: String) -> Double {
        var additionalCost: Double = 0
        
        switch size {
        case 4:
            additionalCost += 1
        case 5:
            additionalCost += 2
        default:
            break // No additional cost
        }
        
        switch material {
        case "Cotton":
            break // No additional cost
        case "Linen":
            additionalCost += 1.5
        case "Polyester":
            additionalCost += 2.5
        case "Lycra":
            additionalCost += 3.5
        case "Rayon":
            additionalCost += 4.5
        default:
            fatalError("I'm not selling this kind of material! This must be wrong input.")
        }
        
        return additionalCost
    }
}

let tshirt = TShirt(size: 1, color: "Blue", material: "Rayon")
print(tshirt.calculateCost())



/*: ### Challenge 3: Battleship
 Write the engine for a Battleship-like game. If you aren’t familiar with Battleship, you can brush up on the details at this webpage: http://bit.ly/2nT3JBU
 • Use an (x, y) coordinate system for your locations modeled using a structure.
 • Ships should also be modeled with structures. Record an origin, direction and length.
 • Each ship should be able to report if a “shot” has resulted in a “hit”.
 */

struct Coordinate {
    let x: Int
    let y: Int
}

struct Ship {
    let origin: Coordinate
    let direction: String
    let length: Int
    
    func isHit(coordinate: Coordinate) -> Bool {
        if direction == "Right" {
            return origin.y == coordinate.y &&
            coordinate.x >= origin.x &&
            coordinate.x - origin.x < length
        } else {
            return origin.x == coordinate.x &&
            coordinate.y >= origin.y &&
            coordinate.y - origin.y < length
        }
    }
}

struct Board {
    
    var ships: [Ship] = []
    
    func fire(location: Coordinate) -> Bool {
        for ship in ships {
            if ship.isHit(coordinate: location) {
                print("Hit!")
                return true
            }
        }
        
        return false
    }
}

let ship1 = Ship(origin: Coordinate(x: 2, y: 2), direction: "Right", length: 2)
let ship2 = Ship(origin: Coordinate(x: 5, y: 3), direction: "Down", length: 4)
let ship3 = Ship(origin: Coordinate(x: 0, y: 0), direction: "Down", length: 3)

/*:
 Set up the board.
 */

var board = Board()
board.ships.append(contentsOf: [ship1, ship2, ship3])

/*:
 Play the game.
 */

board.fire(location: Coordinate(x: 2, y: 2)) // Hit on the patrolBoat
board.fire(location: Coordinate(x: 2, y: 3)) // Miss...
board.fire(location: Coordinate(x: 5, y: 6)) // Hit on the battleship
board.fire(location: Coordinate(x: 5, y: 7)) // Miss...
