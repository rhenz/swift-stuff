import UIKit

//: ### Mini Exercises

                                              
//: Do you have a television or a computer monitor? Measure the height and width, plug it into a TV struct, and see if the diagonal measurement matches what you think it is.

struct TV {
    var height: Double // Inches
    var width: Double // Inches
    
    /// Inches
    var diagonal: Int {
        let result = (height * height + width * width).squareRoot().rounded()
        return Int(result)
    }
}

var mySonyTV = TV(height: 21.4409, width: 37.189)
mySonyTV.diagonal // 43inch


//: In the light bulb example, the bulb goes back to a successful setting if the current gets too high. In real life, that wouldn’t work, and the bulb would burn out!Your task is to rewrite the structure so that the bulb turns off before the current burns it out.
//: Hint: You’ll need to use the willSet observer that gets called before value is changed. The value that is about to be set is available in the constant newValue. The trick is that you can’t change this newValue, and it will still be set, so you’ll have to go beyond adding a willSet observer. :]

struct LightBulb {
    static let maxCurrent = 40
    var isOn = false
    
    var current = 0 {
        willSet {
            if newValue > Self.maxCurrent {
                print("Turning off your light bulb before t he current burns it out")
                isOn = false
            }
        }
        
        didSet {
            if current > Self.maxCurrent {
                current = oldValue
            }
        }
    }
}

var light = LightBulb()

// Let's turn on the light
light.isOn = true

// Adjusting the current
light.current = 20

// Check current
light.current

// Adjust the current to unexpected value
light.current = 50

// Check current
light.current

// Check if light is on
light.isOn



struct Circle {
//    lazy var pi = {
//        ((4.0 * atan(1.0 / 5.0)) - atan(1.0 / 239.0)) * 4.0
//    }()
    
    var radius = 0.0
    var circumference: Double {
        mutating get {
            Double.pi * radius * 2
        }
    }
    
//    init(radius: Double) {
//        self.radius = radius
//    }
}

//: 1. Remove the lazy stored property pi. Use the value of pi from the Swift standard library instead.
var circle = Circle(radius: 5) // got a circle, pi has not been run
circle.circumference // 31.42

//: 2. Remove the initializer. Since radius is the only stored property now, you can rely on the automatically included initializer.
