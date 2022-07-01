import UIKit

//: ### Advanced Protocols and Generics


//: ### Existential protocols
//: Existential type, a cocrete type access through a protocol

//protocol Pet {
//    var name: String { get }
//}
//
//struct Cat: Pet {
//    var name: String
//}
//
//var somePet: Pet = Cat(name: "Chabby")

// Here we defined the variable `somePet` with a type of `Pet` instead of the concrete type `Cat`. Here `Pet` is an `existential type` - it's an abstract concept, a protocol, that referes to a concrete type, such as a struct , that exists


//: Non-existential protocols
// If a protocol has `associated types`, we cannot use it as an `existential type`


//protocol WeightCalculatable {
//    associatedtype WeightType
//    var weight: WeightType { get }
//}

// This protocol defines having a `weight` without fixing `weight` to one specific type. We can create a class or struct that sets the WeightType as an Int or a Double or anything we want

class Truck: WeightCalculatable {
    typealias WeightType = Int
    
    var weight: Int {
        100
    }
}

class Flower: WeightCalculatable {
    typealias WeightType = Double
    
    var weight: Double {
        0.0025
    }
}

// The emphasis on this topic is that `anything we want` part. Nothing is stopping us from defining WeightType as a astring or even something else entirely

//class StringWeightThing: WeightCalculatable {
//    typealias WeightType = String
//
//    var weight: String {
//        "This does not make any sesnse"
//    }
//}
//
//class CatWeightThing: WeightCalculatable {
//    typealias WeightType = Cat
//
//    var weight: Cat {
//        Cat(name: "What is this cat doing here?")
//    }
//}


//: ### Constraint the protocol to a specific type
//: The problem when using our own protocol. If we wanted to write generic code around it, and the generic system knows nothing about WeightType capabilities, we can't do any computation with it. So in this case, we want to add a `constraint` that requires WeightCalculatable to be `Numeric`

protocol WeightCalculatable {
    associatedtype WeightType: Numeric
    var weight: WeightType { get }
}

// Having this constraint, all that conforms to WeightCalculatable type should WeightType that is a `Numeric` type.


// Now we can write generic short-hand functions that use WeightCalculatable in computations instead of accessing its underlying weight property.

extension WeightCalculatable {
    static func +(left: Self, right: Self) -> WeightType {
        left.weight + right.weight
    }
}

var heavyTruck1 = Truck()
var heavyTruck2 = Truck()

heavyTruck1 + heavyTruck2 // 200

var lightFlower = Flower()
//heavyTruck1 + lightFlower // The compiler detects error, WeightType of truck and flower are not the same. Int and Double



//: ### Expressing relationships between types
//: Let's see how we can use `type constraints` to express relationship between types


// e.g. we want to model a production factory

//protocol Product {
//
//}
//
//protocol ProductionLine {
//    func produce() -> Product
//}
//
//protocol Factory {
//    var productionLines: [ProductionLine] { get }
//}
//
//extension Factory {
//    func produce() -> [Product] {
//        var items: [Product] = []
//        productionLines.forEach { items.append($0.produce()) }
//        print("Finished Production")
//        print("-------------------")
//        return items
//    }
//}

struct Car: Product {
    init() {
        print("Producing one awesome Car 🚘")
    }
}

struct CarProductionLine: ProductionLine {
    func produce() -> Product {
        Car()
    }
}

//struct CarFactory: Factory {
//    var productionLines: [ProductionLine] = []
//}

// Now we have concrete types for the Product, ProductionLine and Factory. We can start the manufacturing process

//var carFactory = CarFactory()
//carFactory.productionLines = [CarProductionLine(), CarProductionLine()]
//carFactory.produce()

// With this code, we created a factory, gave it two production lines and told it to start production one time.

// Let's try another one

struct Chocolate: Product {
    init() {
        print("Producing one chocolate bar")
    }
}

struct ChocolateProductionLine: ProductionLine {
    func produce() -> Product {
        Chocolate()
    }
}

//var oddCarFactory = CarFactory()
//oddCarFactory.productionLines = [CarProductionLine(), ChocolateProductionLine()]
//oddCarFactory.produce()

// What is the chocolate doing in the Car Factory? LOL

// So how can we specify that each factory should only produce one type of product?

// Let's start fresh with new set of protocols, this time using associated types
protocol Product {
    init()
}

protocol ProductionLine {
    associatedtype ProductType
    func produce() -> ProductType
}

protocol Factory {
    associatedtype ProductType
    func produce() -> [ProductType]

}

// Now, instead of creating specific production lines and factories for cars and chocolates, you can create a single, generic production line and factory


struct GenericProductionLine<P: Product>: ProductionLine {
    func produce() -> P {
        P()
    }
}

struct GenericFactory<P: Product>: Factory {
    var productionLines: [GenericProductionLine<P>] = []
    
    func produce() -> [P] {
        var newItems: [P] = []
        productionLines.forEach { newItems.append($0.produce()) }
        print("Finished Production")
        print("-------------------")
        return newItems
    }
}

// Note how we use the generic type P to ensure the production line produces the same ProdutType as the factory. We also constraint P to Product so that it must have a default initializer

var carFactory = GenericFactory<Car>()
carFactory.productionLines = [GenericProductionLine<Car>(), GenericProductionLine<Car>()]
carFactory.produce()

var chocolateFactory = GenericFactory<Chocolate>()
chocolateFactory.productionLines = [GenericProductionLine<Chocolate>(), GenericProductionLine<Chocolate>()]
chocolateFactory.produce()



//: ### Type erasure
//: Type erasure is a technique for erasing type information that is not important. The type `Any` is the ultimate type erasure. It removes all type information


let array = Array(1...10)
let set = Set(1...10)
let reversedArray = array.reversed()

//let collection = [array, set, reversedArray] // Error since they are all different types and can't group them together in a homogeneous element array

//let arrayCollection = [array, Array(set), Array(reversedArray)] // This is an OK solution but it is O(n) in time and space complexity because it makes a copy of all elements

// Swift provides a type-erased type for collections called `AnyCollection`, and it throws away type-specific information..

let collection = [AnyCollection(array), AnyCollection(set), AnyCollection(array.reversed())]

// Creating this collection is just O(1) because it wraps the original type instead of copying it
let total = collection.flatMap { $0 }.reduce(0, +)
print(total) // 165

// There are other type-erased type in Swift like AnyIterator, AnySequence, AnyHashable



//: ### Making at type erasure

protocol Pet {
    associatedtype Food
    func eat(_ food: Food)
}

enum PetFood: String {
    case dry
    case wet
}

struct Cat: Pet {
    func eat(_ food: PetFood) {
        print("Eating a \(food.rawValue) cat food.")
    }
}

struct Dog: Pet {
    func eat(_ food: PetFood) {
        print("Eating a \(food.rawValue) dog food.")
    }
}

// If we try to create a list of pets using an existential protocol, the compiler won't let us
//let pets: [Pet] = [Dog(), Cat()]

// Our goal is to construct a list of AnyPet so that we can list dogs and cats together

struct AnyPet<Food>: Pet {
    private let _eat: (Food) -> Void
    
    init<SomePet: Pet>(_ pet: SomePet) where SomePet.Food == Food {
        _eat = pet.eat(_:)
    }
    
    func eat(_ food: Food) {
        _eat(food)
    }
}

/*:
 This code is the basic formula of a type erasure. Here is what is going on
 1. The type eraser is a generic concrete type abstracted by the associated type of the generic protocol, and it conforms to the generic protocol.
 2. For each protocol method, it stores a closure to the method of the type it wraps.
 3. A generic initializer takes as input the type it is wrapping. It constrains its associated type to be the same as the type it is wrapping.
 4. To implement the protocol, it forwards calls to the type it is wrapping.
 */


let pets = [AnyPet(Dog()), AnyPet(Cat())]


//: ### Implement eraseToAnyPet
extension Pet {
    func eraseToAnyPet() -> AnyPet<Food> {
        .init(self)
    }
}

let morePets = [Dog().eraseToAnyPet(), Cat().eraseToAnyPet()]


//: ### Opaque return types
//: Swift provides a related language feature called opaque return types. It has the advantage that we don't need to create an Any*** wrapper type. Opaque return types work by making the compiler keeping track of the concrete return type but only letting the function caller use a protocol interface that it supports.

func makeValue() -> some FixedWidthInteger {
    42
}

print("Two makeValues summed", makeValue() + makeValue())
