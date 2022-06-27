import UIKit
/* start

//: ### Error Handling



//: ### Failable Initializers
//: failable initializer is a way to initialize a type that has a return type of optional to recognize the risk of failure, and the return will be nil if initialization fails


struct PetHouse {
    let squareFeet: Int
    
    init?(squareFeet: Int) {
        if squareFeet < 1 {
            return nil
        }
        
        self.squareFeet = squareFeet
    }
}


let tooSmall = PetHouse(squareFeet: 0) // nil
let house = PetHouse(squareFeet: 1) // Optional Pet House

// To make a failable initializer, we simply name it `init?(...)` and return nil if it fails. Using a failable initializer, we can guarantee that our instance has the corrent attributes, or it will never exist


//: ### Optional Chaining
class Toy {
    enum Kind {
        case ball, zombie, bone, mouse, snake
    }
    
    enum Sound {
        case squeak, bell
    }
    
    let kind: Kind
    let color: String
    var sound: Sound?
    init(kind: Kind, color: String, sound: Sound? = nil) {
        self.kind = kind
        self.color = color
        self.sound = sound
    }
}

class Pet {
    enum Kind {
        case dog, cat, guineaPig
    }
    
    let name: String
    let kind: Kind
    let favoriteToy: Toy?
    
    init(name: String, kind: Kind, favoriteToy: Toy? = nil) {
        self.name = name
        self.kind = kind
        self.favoriteToy = favoriteToy
    }
}

class Person {
    let pet: Pet?
    
    init(pet: Pet? = nil) {
        self.pet = pet
    }
}

let janie = Person(pet: Pet(name: "Delia", kind: .dog,
                            favoriteToy: Toy(kind: .ball,
                                             color: "Purple", sound: .bell)))
let tammy = Person(pet: Pet(name: "Evil Cat Overlord",
                            kind: .cat, favoriteToy: Toy(kind: .mouse,
                                                         color: "Orange")))
let lucas = Person(pet: Pet(name: "Chabby The RBF Cat",
                            kind: .cat, favoriteToy: Toy(kind: .snake,
                                                         color: "Green")))
let felipe = Person()

// We may want to check a person that have a pet with favorite toy that makes a sound, we will use `optional chaining` to do that!

if let sound = janie.pet?.favoriteToy?.sound {
    print("Sound \(sound)")
} else {
    print("No sound.")
}


if let sound = tammy.pet?.favoriteToy?.sound {
    print("Sound \(sound).")
} else {
    print("No sound.")
}
if let sound = felipe.pet?.favoriteToy?.sound {
    print("Sound \(sound).")
} else {
    print("No sound.")
}

// We may find it repititive to do the task of looking for person with a pet that has a toy with a sound. We will use map and compactMap for this problem


//: ### Map and compactMap
let team = [janie, tammy, felipe, lucas]

// Want to get all the pet names of the team array?

let petNames = team.map { $0.pet?.name }
petNames // petNames has a type [String?]

// Let's print the pet names
for pet in petNames {
    print(pet as Any)
}


// Yikes, printing all the pet names is not good. There's a prefix of "Optional" coz not all team members has a pet, and the petNames has a type [String?] so it is expected that there could be a nil value inside this array

// What can we do to print non-nil values?


// Using Optional pattern (pattern matching)
for case let petName? in petNames {
    print(petName)
}

// Or instead of using map to get all the pet names, we can use compactMap to remove nil values in array
let noNilPetNames = team.compactMap { $0.pet?.name }

for pet in noNilPetNames {
    print(pet)
}



//: ### Error Protocol
//: Swift includes `Error` protocol, which forms the basis of the error-handling architecture. Any type that conforms to this protocol represents an error.

enum BakeryError: Error {
case tooFew(numberOnHand: Int), doNotSell, wrongFlavor
case inventory, noPower
}

class Pastry {
    let flavor: String
    var numberOnHand: Int
    
    init(flavor: String, numberOnHand: Int) {
        self.flavor = flavor
        self.numberOnHand = numberOnHand
    }
}


// The error protocol tells the compiler that this enumeration represents errors that we can throw.

//: ### Throwing errors
//: So what does our program do with these errors? It throws them! That's the actual terminology we'll see: `throwing` errors then `catching` them

class Bakery {
    var itemsForSale = [
        "Cookie": Pastry(flavor: "ChocolateChip", numberOnHand: 20),
        "PopTart": Pastry(flavor: "WildBerry", numberOnHand: 13),
        "Donut" : Pastry(flavor: "Sprinkles", numberOnHand: 24),
        "HandPie": Pastry(flavor: "Cherry", numberOnHand: 6)
    ]
    
    func open(_ now: Bool = Bool.random()) throws -> Bool {
        guard now else {
            throw Bool.random() ? BakeryError.inventory
            : BakeryError.noPower
        }
        return now }
    
    func orderPastry(item: String,
                     amountRequested: Int,
                     flavor: String)  throws  -> Int {
        guard let pastry = itemsForSale[item] else {
            throw BakeryError.doNotSell
        }
        guard flavor == pastry.flavor else {
            throw BakeryError.wrongFlavor
        }
        guard amountRequested <= pastry.numberOnHand else {
            throw BakeryError.tooFew(numberOnHand:
                                        pastry.numberOnHand)
        }
        pastry.numberOnHand -= amountRequested
        return pastry.numberOnHand
    }
}


// This code wont compile because the functions throw errors and we have to catch those
//let bakery = Bakery()
//bakery.open()
//bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")


//: ### Handling errors

let bakery = Bakery()
do {
    try bakery.open()
    try bakery.orderPastry(item: "Albatross",
                           amountRequested: 1,
                           flavor: "AlbatrossFlavor")
} catch BakeryError.inventory, BakeryError.noPower {
    print("Sorry, the bakery is now closed.")
} catch BakeryError.doNotSell {
    print("Sorry, but we don’t sell this item.")
} catch BakeryError.wrongFlavor {
    print("Sorry, but we don’t carry this flavor.")
} catch BakeryError.tooFew {
    print("Sorry, we don’t have enough items to fulfill your order.")
}


// Code that can throw errors must always be inside a `do` block, which creates a new scope. And we have to add the keyword `try` before calling these functions that throws an error


// There might be a time that we are not looking at the detailed error, we can use `try?` for that

//: ### Not looking at the detailed error

let open = try? bakery.open(false)
let remaining = try? bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")

// This code is short and concise but we don't get any details of the errors we get, instead it returns `nil` if the function throws an error

//: ### Stopping your program on an error

// Way 1:
do {
    try bakery.open(true)
    try bakery.orderPastry(item: "Cookie",
                           amountRequested: 1,
                           flavor: "ChocolateChip")
} catch {
    fatalError()
}

// Way 2: much shorter way to write above and does the same thing
try! bakery.open(true)
try! bakery.orderPastry(item: "Cookie", amountRequested: 1,
                        flavor: "ChocolateChip")

// But do know that this pattern will make our app crash

*/ // end


//: ### Advanced error handling


// Sample project. PugBot

enum Direction {
    case left, right, forward
}

enum PugBotError: Error {
    case invalidMove(found: Direction, expected: Direction)
    case endOfPath
}


class PugBot {
    let name: String
    let correctPath: [Direction]
    private var currentStepInPath = 0
    
    
    init(name: String, correctPath: [Direction]) {
        self.correctPath = correctPath
        self.name = name
    }
    
    func move(_ direction: Direction) throws {
        guard currentStepInPath < correctPath.count else {
            throw PugBotError.endOfPath
        }
        let nextDirection = correctPath[currentStepInPath]
        guard nextDirection == direction else {
            throw PugBotError.invalidMove(found: direction,
                                          expected: nextDirection)
        }
        currentStepInPath += 1
    }
    
    func reset() {
        currentStepInPath = 0
    }
}


let pug = PugBot(name: "Pug",
                 correctPath:
                    [.forward, .left, .forward, .right])

func goHome() throws {
    try pug.move(.forward)
    try pug.move(.left)
    try pug.move(.forward)
    try pug.move(.right)
}

do {
    try goHome()
} catch {
    print("PugBot failed to get home.")
}

//: ### Handling multiple errors
func moveSafely(_ movement: () throws -> ()) -> String {
    do {
        try movement()
        return "Completed operation successfully."
    } catch PugBotError.invalidMove(let found, let expected) {
        return "The PugBot was supposed to move \(expected), but moved \(found) instead."
    } catch PugBotError.endOfPath {
        return "The PugBot tried to move past the end of the path."
    } catch {
        return "An unknown error occurred."
    }
}

pug.reset()
moveSafely(goHome)
pug.reset()
moveSafely {
    try pug.move(.forward)
    try pug.move(.left)
    try pug.move(.forward)
    try pug.move(.right)
}


//: ### Rethrows
//: A function that takes a throwing closure as a parameter has to choose: either catch every error or be a throwing function.

func perform(times: Int, movement: () throws -> ()) rethrows {
    for _ in 1...times {
        try movement()
    }
}

func perform2(times: Int, movement: () throws -> ()) {
    for _ in 1...times {
        try? movement()
    }
}

// Notice the rethrows here. This function does not handle errors like `moveSafely(_:). Instead, it leaves error handling to the function's caller, such as `goHome()`. The above function uses `rethrows` to indicate that it will on rethrow error thrown by the closure passed into it, and it will never throw error of its own


//: ### Throwable properties

// WE can throw errors from `read-only` computed properties:

class Person {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

enum PersonError: Error {
    case noName, noAge, noData
}

extension Person {
    var data: String {
        get throws {
            guard !name.isEmpty else {throw PersonError.noName}
            guard age > 0 else {throw PersonError.noAge}
            return "\(name) is \(age) years old."
        }
    }
}
let me = Person(name: "Cosmin", age: 36)

me.name = ""
do {
    try me.data
} catch {
    print(error)
}

me.age = -36
do {
    try me.data
} catch {
    print(error)
}

me.name = "Cosmin"
do {
    try me.data
} catch {
    print(error)
}


me.age = 36
do {
    try me.data
} catch {
    print(error)
}


//: ### Throwable subscripts
extension Person {
    subscript(key: String) -> String {
        get throws {
            switch key {
            case "name": return name
            case "age": return "\(age)"
            default: throw PersonError.noData
            }
        }
    }
}

do {
    try me["name"] // "Cosmin"
} catch {
    print(error)
}
do {
    try me["age"] // "36"
} catch {
    print(error)
}
do {
    try me["gender"]
} catch {
    print(error) // "noData"
}
