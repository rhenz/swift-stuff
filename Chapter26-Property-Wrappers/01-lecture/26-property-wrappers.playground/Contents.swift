import UIKit

//: ### Property Wrappers
//: Property wrapper is a type that wraps a given value in order to attach additional logic to it and can be implemented using either a struct or a class by annotating it with the @propertyWrapper attribute.





//: ### Basic example

//struct Color {
//    var red: Double
//    var green: Double
//    var blue: Double
//}

// There's an implicit assumption that the values red,green and blue fall between zero and one. We could have stated that requirement as a comment, but it's much better to enlist the compiler's help. To do that, we can create a property wrapper:

@propertyWrapper
struct ZeroToOne {
    private var value: Double
    
    private static func clamped(_ input: Double) -> Double {
        min(max(input, 0), 1)
    }
    
    init(wrappedValue: Double) {
        value = Self.clamped(wrappedValue)
    }
    
    var wrappedValue: Double {
        get { value }
        set { value = Self.clamped(newValue)}
    }
}

// To use the property wrappers
struct Color {
    @ZeroToOne var red: Double
    @ZeroToOne var green: Double
    @ZeroToOne var blue: Double
}

// That is all it takes to guarantee that the values are always locked between zero and one

var superRed = Color(red: 2, green: 0, blue: 0)
print(superRed)

superRed.blue = -2.0
print(superRed)

// No matter how hard someone try, they can never get it to go outside the zero-to-one bound

// Beginning Swift 5.5, we can use property wrappers with function arguments
func printValue(@ZeroToOne _ value: Double) {
    print("The wrapped value is", value)
}

printValue(3.14)


//: ### Property values with $
//: Property values can be used to offer direct access to the unclamped value:

@propertyWrapper
struct ZeroToOneV2 {
    private var value: Double
    
    var wrappedValue: Double {
        get { min(max(value, 0), 1)}
        set { value = newValue }
    }
    
    var projectedValue: Double { value }
    
    init(wrappedValue: Double) {
        value = wrappedValue
    }
}

// In this version, the initializer and setter assign the value without clamping it. Instead, the wrappedValue getter does that clamping. This lets us use the projected value, which we can access with $, to get the raw value

func printValueV2(@ZeroToOneV2 _ value: Double) {
    print("The wrapped value is", value)
    print("The projected value is", $value)
}

printValueV2(3.14)


//: ### Adding parameters
//: Previous examples clamps the value zero-to-one, but what if we want to define a specific upper value? Like 0-100? We can do that by adding parameter

@propertyWrapper
struct ZeroTo {
    private var value: Double
    let upper: Double
    
    init(wrappedValue: Double, upper: Double) {
        value = wrappedValue
        self.upper = upper
    }
    
    var wrappedValue: Double {
        get { min(max(value, 0), upper) }
        set { value = newValue }
    }
    
    var projectedValue: Double { value }
}

func printValueV3(@ZeroTo(upper: 100) _ value: Double) {
    print("The wrapped value is", value)
    print("The projected value is", $value)
}

printValueV3(42)
printValueV3(101)


//: ### Going generic
//: Property wrapper can also be generic with respect to the wrapped value

@propertyWrapper
struct ZeroToG<Value: Numeric & Comparable> {
    private var value: Value
    let upper: Value
    init(wrappedValue: Value, upper: Value) {
        value = wrappedValue
        self.upper = upper
    }
    var wrappedValue: Value {
        get { min(max(value, 0), upper) }
        set { value = newValue }
    }
    var projectedValue: Value { value }
}


func printValueV4<T: Numeric & Comparable>(@ZeroToG(upper: 100) _ value: T) {
    print("The wrapped value is", value)
    print("The projected value is", $value)
}


let floatNum: Float = 69.9
let doubleNum: Double = 39.99999
let intNum: Int = 101
let cgFloatNum: CGFloat = 105.0

printValueV4(floatNum)
printValueV4(doubleNum)
printValueV4(intNum)
printValueV4(cgFloatNum)

