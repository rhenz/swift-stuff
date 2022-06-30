import UIKit

//: ### Value Types & Reference Types
//: Swift supports two kinds of types which are `value types` and `reference types`. Structs and enums are value types, while classes and functions are reference types and they differ in behavior. The behavior we've come to expect from value types is the result of `value semantics`


//: ### Value types vs. Reference types
//: Value and reference types differ in their `assignment behavior`, which is just a name for what Swift does whenever we assign a value to a variable.


//: ### Reference types
//: Reference types use `assign-by-reference`. When a variable is of a reference type, assining an instance to the variable sets that variable to refer to that instance. If another variable was already referring to that instance, then both variables post-assignment refer to the same instance(also reference count increases). Since both variables point to the same instance, we can use one of the variable to change that instance and the change's effect on the other.


struct Color: CustomStringConvertible {
    var red, green, blue: Double
    var description: String {
        "r: \(red) g: \(green) b: \(blue)"
    }
}

// Preset colors
extension Color {
    static var black = Color(red: 0, green: 0, blue: 0)
    static var white = Color(red: 1, green: 1, blue: 1)
    static var blue  = Color(red: 0, green: 0, blue: 1)
    static var green = Color(red: 0, green: 1, blue: 0)
    // more ...
}


// Paint bucket abstraction
class Bucket {
    var color: Color
    var isRefilled = false
    init(color: Color) {
        self.color = color
    }
    func refill() {
        isRefilled = true
    }
}

let azurePaint = Bucket(color: .blue)
let wallBluePaint = azurePaint
wallBluePaint.isRefilled // false initially
azurePaint.refill()
wallBluePaint.isRefilled // true, unsurprisingly

// When we call the azurePaint.refill(), we also refill wallBluePaint because the two variables points to the same `Bucket` instance


//: ### Value types
//: Value types use `assign-by-copy`. Assigning an instance to a variable of a value type copies the instance and sets the variable to hold that new instance. So after every assignment, a variable contains an instance which it owns all to itself.

extension Color {
    mutating func darken() {
        red *= 0.9; green *= 0.9; blue *= 0.9
    }
}

var azure = Color.blue
var wallBlue = azure
azure
wallBlue.darken()
azure //unaffected from wallBlue changes


//: ### Defining value semantics
//: What's nice about primitive value types like Color or Int is not the assign-by-copy behavior itself, but rather the guarantee this behavior it creates. The guarantee is that the only way to affect a variable's value is through THAT variable itself. If a type promises that, then the type supports `value semantics`

//: One benefit of value semantics is that they aid `local reasoning`. To determine how a variable got its value, we only need to consider the history of interactions with that variable.

//: ### When to prefer value semantics?
//: Value semantics are appropriate for representing inert, descriptive data. While reference semantics are suitable for representing distinct items in our program or the world.


// Even Person is a class/reference type. It shows that this type has value semantics since the type is immutable, all property are constant
class Person {
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}




