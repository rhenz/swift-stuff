import UIKit

//: ### Protocols
//: So far, we have learned *structs*, *classes* and *enums*. There's one more named type to learn about and that is *PROTOCOL*

//: Unlike any othere named types, protocols don't define anyhting you instantiate directly, instead, they define an interface or blueprint that actual concrete types _conform_ to. With a protocol, we define a common set of properties and behaviors that concrete types go and implement.



//: ### Introducing protocols

//: You define a protocol like this:

protocol Vehicle {
    func accelerate()
    func stop()
}

// We cannot instantiate a protocol, instead we enforce methods and properties on other types. What we define here is something like the idea of a vehicle, that is something that can accelerate and stop.

//: ### Protocol syntax
//: A protocol can be adopted by a class, struct or enum. And when another type adopts to a protocol, it is required to implement the methods and properties defined in the protocol


class Unicycle: Vehicle {
    var peddling = false
    
    func accelerate() {
        peddling = true
    }
    
    func stop() {
        peddling = false
    }
}


//: ### Methods in protocols
//: We define methods on protocols much like we would on any class, struct or enum with parameters and return values

enum Direction {
    case left
    case right
}

protocol DirectionalVehicle {
    func accelerate()
    func stop()
    func turn(_ direction: Direction)
    func description() -> String
}


//: There are few differences to note. We don't, and in fact, can't define any implementation for the methods. This lack of implementation is to help you enforce a strict separation of interface and code, as the protcol by itself makes no assumptions about the implementation details of any type that conforms to the protocol.

//: Methods defined in protocols can't contain default parameters

//: ### Properties in protocols

protocol VehicleProperties {
    var weight: Int { get }
    var name: String { get set }
}

//: When defining properties in a protocol, we must explicitly mark them as get or get set, somewhat similar to how we declare computed properties. However, much like methods, we don't include any implementation for properties

//: Even if the property has only a get requirement, we are still allowed to implement it as a stored property or a red-write computed property. The requirements in the protocol are only minimum requirements.

struct Motorcycle: VehicleProperties {
    var name: String
    
    var weight: Int
    
    
    mutating func updateWeightNotAllowed() {
        weight = 200
    }
}


var daiki = Motorcycle(name: "Daiki", weight: 190)
daiki.updateWeightNotAllowed() // we might question why is this possible even if the weight property is declared {get} only? we'll see in the next example

// If we explicitly declare protocol type in our variable, now we will be able to see the error if we try to set the weight property.
var mustBeVehicle: VehicleProperties = Motorcycle(name: "DaikiAgain", weight: 190)
//mustBeVehicle.weight = 200 // error?



//: ### Initializers in protocols
//: While protocols themselves can't be initialized, they can declare initializers that conforming types should have:

protocol Account {
    var value: Double { get set }
    init(initialAmount: Double)
    init?(transferAccount: Account)
}

// If we conform to a protocol with required initializers using a `class` type, those initializers must use the `required` keyword:

class BitcoinAccount: Account {
    var value: Double
    
    required init(initialAmount: Double) {
        value = initialAmount
    }
    
    required init?(transferAccount: Account) {
        guard transferAccount.value > 0.0 else {
            return nil
        }
        
        value = transferAccount.value
    }
}

let account = BitcoinAccount(initialAmount: 30.00)
let transferAccount = BitcoinAccount(transferAccount: account)
account === transferAccount

var accountType: Account.Type = BitcoinAccount.self
let account2 = accountType.init(initialAmount: 50.00)
let transferAccount2 = accountType.init(transferAccount: account2)



//: ### Protocol inheritance
//: The _Vehicle_ protocol contains a set of methods that could apply to any vehicle, such as a bike, car, snowmobile, or airplane
//: We may wish to define a protocol that contains all the qualities of a _Vehicle_ but is also specific to vehicles with wheels. For this, we can have protocols that inherit from other protocols like in classes that inherit from other classes

protocol WheeledVehicle: Vehicle {
    var numberOfWheels: Int { get }
    var wheelSize: Double { get set }
}

//: Any type we mark as conforming to the WheeledVehicle protocol will have all the members defined within the braces and the members of Vehicle. As with subclassing, any type we mark as a WheeledVehicle will have an is-a relationship with the protocol Vehicle



//: ### Implementing protocols
//: As we have already seen, when we declared our type as conforming to a protocol, we must implement all the requirements declared in the protocol

/*
 class Bike: Vehicle {
 var peddling = false
 var brakesApplied = false
 
 func accelerate() {
 peddling = true
 brakesApplied = false
 }
 
 func stop() {
 peddling = false
 brakesApplied = true
 }
 }
 */

//: ### Implementing properties
class Bike: WheeledVehicle {
    let numberOfWheels = 2
    var wheelSize = 16.0
    var peddling = false
    var brakesApplied = false
    
    func accelerate() {
        peddling = true
        brakesApplied = false
    }
    func stop() {
        peddling = false
        brakesApplied = true
    }
}

/*:
 The numberOfWheels constant fulfills the get requirement. The wheelSize variable fulfills both get and set requirements.
 Protocols don’t care how you implement their requirements as long as you implement them. Your choices for implementing a get requirement are:
 
 • A constant stored property.
 • A variable stored property.
 • A read-only computed property.
 • A read-write computed property.
 
 Your choices for implementing both a get and a set property are limited to a variable stored property or a read-write computed property.
 */


//: ### Associated types in protocols
//: We can also add an _associated type_ as a protocol member. Using this, we simply state that there is a type in this protocol, without specifying what types this should be. It's up to the protocol to decide what the exact type should by. It's like a generics in protocol.

protocol WeightCalculatable {
    associatedtype WeightType
    var weight: WeightType { get }
}

//: by defining the WeightType associated type, we delegate the decision of the type of weight to the type adopting the protocol

class HeavyThing: WeightCalculatable {
    typealias WeightType = Int
    
    var weight: Int { 100 }
}

class LightThing: WeightCalculatable {
    typealias WeightType = Double
    
    var weight: Double { 0.0025}
}


//: ### Implementing multiple protocols
//: Protocols can inherit to multiple protocols unlike class inheritance.

protocol Wheeled {
    var numberOfWheels: Int { get }
    var wheelSize: Double { get set }
}

class Bike2: Vehicle, Wheeled {
    
    
    // Implement both Vehicle and Wheeled
    var wheelSize: Double = 29
    
    var numberOfWheels: Int {
        2
    }
    
    var peddling = false
    var brakesApplied = false
    
    func accelerate() {
        peddling = true
        brakesApplied = false
    }
    
    func stop() {
        peddling = false
        brakesApplied = true
    }
}

//: ### Protocol composition
//: Sometimes we might need a function to take a data type that must conform to multiple protocols. This is where protocol composition comes in. Imagine we need a function that needs access to the Vehicle protocol's stop() function and the WHeeled protocol's numberOfWheels property. We can do this using the & ampersand composition operator


func roundAndAround(transporation: Vehicle & Wheeled) {
    transporation.stop()
    print("The brakes are being applied to \(transporation.numberOfWheels) wheels.")
}

roundAndAround(transporation: Bike2())


//: ### Extensions & protocol conformance
//: We can also adopt protocols using extensions. This language feature lets us add protocol conformance to types we don't necessarily own. We can make String type as an example

protocol Reflective {
    var typeName: String { get }
}

extension String: Reflective {
    var typeName: String {
        "I am a String"
    }
}

let bookTitle = "Atomic Habits"
bookTitle.typeName


//: Another advantage of using extensions is that we can nicely group the protocol adoption with the requisite methods and properties instead of having a pile of protocols cluttering up your type definition. This can usually make our code look cleaner

class AnotherBike: Wheeled {
    var peddling = false
    var numberOfWheels: Int = 2
    var wheelSize: Double = 29.0
}

extension AnotherBike: Vehicle {
    func accelerate() {
        peddling = true
    }
    
    func stop() {
        peddling = false
    }
}

//: Note - You can’t declare stored properties in extensions. You can only declare stored properties in the original type declaration or derived classes in the case of a class type. This limitation can present a challenge to implementing an arbitrary protocol for some types.


//: Requiring reference semantics
//: Protocols can be adopted by both value types (structs and enums) and reference types (classes), so you might wonder if protocols have reference or value semantics.
//: The truth is that it depends! If you have an instance of a class or struct assigned to a variable of a protocol type, it will express value or reference semantics that matches the type it was defined as.

protocol Named {
    var name: String { get set }
}

class ClassyName: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}


struct StructyName: Named {
    var name: String
}

// If we assign a named variable an instance of a reference type, we would see the behavior of reference semantics
var named: Named = ClassyName(name: "Classy")
var copy = named

named.name = "Still Classy"
named.name // Still Classy
copy.name // Still Classy


// Likewise, if we assign an instance of value type, we would see the behavior of value semantics
named = StructyName(name: "Structy")
copy = named

named.name = "Still structy?"
named.name // Still structy
copy.name // Structy


// If you’re designing a protocol adopted exclusively by classes, it’s best to request that Swift uses reference semantics when using this protocol as a type.

protocol NamedReferenceSemantics: AnyObject {
    var name: String { get set }
}

// Using the AnyObject protocol constraint above indicates that only classes may adopt this protocol. This declaration makes it clear that Swift should use reference semantics.


// There are othere ready made protocols that Swift made for us that we might need in the future like Equatable, Comparable, Hashable and Identifiable.
