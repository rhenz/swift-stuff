import UIKit

//:### Optionals
//: A special Swift data type that can represent a value and the absence of that value(nil)



//:### Introducing nil
//: Sometimes it is useful to represent the absence of a value. Imagine a scenario when we need to refer to a `Person`, we may want to store the person's *firstName*, *middleName*, *lastName* and *occupation*. But not everyone has a *middleName* and *occupation*. So we need to handle the absence of these values. We can do this with `Optionals`


//: Without knowing optionals, this is how we may represent this
/*:
 ```
 var firstName = "John
 var middleName = ""
 var lastName = "Lucas"
 var occupation = ""
 ```
 
 It's much better if we represent these values as optionals. Optionals are much better solution for this instead of just using empty string.
 */


//: ### Sentinel values
//: values representing a special condition such as the absence of a value is known as a _sentinel value_, or simply a special value. That is what our empty string in previous example would be.




//: ### Introducing optionals
//: Optionals are Swift's solution to the problem of representing both a value and the absence of a value. An optional is allowed to hold either a value or _nil_.



//: how to declare an optional type?
var errorCode: Int?

//: the only difference between this and the usual declaration is the _question mark_ at the end of the type.

// Setting the value is so simple
errorCode = 100
errorCode = nil


//: ### Unwrapping optionals
var result: Int? = 30
//print(result) // This prints Optional(30)


// What happens if we try to do Addition with Optional int? It won't work!
//let sum = result + 1 // Int? must be unwrapped to a value of an Integer



//: ### Force Unwrapping
var authorName: String? = "John Lucas"
var authorAge: Int? = 30

// There are two ways we can use to unwrap these optionals. The first is know as FORCE UNWRAPPING
var unwrappedAuthorName = authorName!
print("Author is \(unwrappedAuthorName)")


// But what happens if we use FORCE UNWRAPPING with an Optional who's value is nil?
//authorAge = nil
//authorAge! // Error! We should use FORCE UNWRAPPING sparringly


// There's a away to unwrap an optional with FORCE UNWRAPPING
if authorAge != nil {
    print("Author age is \(authorAge!)")
} else {
    print("No age")
}

// The code is now safe, but it's far from perfect. This is not a smart practice in handling optionals. We can do optional binding way to unwrap optionals safely.

//: ### Optional binding
//: optional binding lets you safely access the value inside an optional

if let unwrappedAuthorAge = authorAge {
    print("The author age is \(unwrappedAuthorAge)")
} else {
    print("No age")
}


//: ### Introducing guard
//: guard statement is another useful and powerful swift feature. A guard statement is as simple as using an if...else statement. Swift guard is defined as a statement that is used to transfer program control out of a scope if one or more conditions aren't met. You can also use it like if-let, that constant will be available all throughout the scope if all the conditions are met.


func guardMyCastle(name: String?) {
    guard let castleName = name else {
        print("No castle")
        return // must always return
    }
    
    print("Your castle is called \(castleName)")
}


//: Another example
func calculateNumberOfSides(shape: String) -> Int? {
    switch shape {
    case "Triangle":
        return 3
    case "Square":
        return 4
    case "Rectangle":
        return 4
    case "Pentagon":
        return 5
    case "Hexagon":
        return 6
    default:
        return nil
    }
}

// Use this function like
func maybePrintSides(shape: String) {
    let sides = calculateNumberOfSides(shape: shape)
    
    if let sides = sides {
        print("A \(shape) has \(sides) sides.")
    } else {
        print("I don’t know the number of sides for \(shape).")
    }
}

// There's nothing wrong with this implementation, however we could write this using guard, which could make our code more readable and nicer.
// When our code becomes more and more complex, we'll see it used extensively in Swift code.
func maybePrintSides2(shape: String) {
    guard let sides = calculateNumberOfSides(shape: shape) else {
        print("I don’t know the number of sides for \(shape).")
        return
    }
    
    print("A \(shape) has \(sides) sides.")
}


//: ### Nil coalescing
//: Another way to unwrap optional. But you only use this if you want to use a default value for Optionals like:

var optionalInt: Int? = nil
var mustHaveResultNoMatterWhat = optionalInt ?? 0 // If this is nil, mustHaveResultNoMatterWhat will be zero/0
