import UIKit


//: ### Properties

struct Car {
    let make: String
    let color: String
}


//: The values inside a structure are called properties. The two properties of `Car` are *stored properties*, which means they store actual string values for each instance of `Car`



//: Some properties calculate values rather than store them. In other words, there's no actual memory allocated for them; instead, they get calculated on-the-fly each time you access them. Naturally, these are called *computed properties*



//: ### Stored properties

//: Imagine we are building an address book. Usually we define a `Contact` struct like this:

struct Contact {
    var fullName: String
    var emailAddress: String
}

//: `Contact` structure has stored properties `fullName` and `emailAddress`. We did not assign initial value coz we plan to assign these values upon initialization. After all, the values will be different for each instance of `Contact`



//: Remember that Swift automatically creates an initializer for us based on the properties we define in our structure; the *memberwise initializer*

var person = Contact(fullName: "John Lucas", emailAddress: "lucas@mypersonalemail.com")

// We can access the individual properties using the *dot notation*
person.fullName // John Lucas
person.emailAddress // lucas@mypersonalemail.com

//: We can modify/update/assign values to properties as long as they are defined as variables and parents instance is stored in a variable. Meaning, both the property and the structure containing the property must be declared with `var` instead of let

person.fullName = "Chabby"
person.fullName

// We can prevent a value from changing by defining the property as a constant using `let`

struct Contact2 {
    var fullName: String
    let emailAddress: String
}

var person2 = Contact2(fullName: "Chabby", emailAddress: "chabby@mypersonalemail.com")
//person2.emailAddress = "changeemail@yahoo.com" // cannot assign new value here even if the Contact instance is stored in a variable.


//: ### Default values
//: If we can make a reasonable assumption about the value of a property when the type is initialized, we can give that property a default value


// It doesn't make sense to create a default name or email address for a contact, but imagine you add a new property relationship to indicate what kind of contact it is. So any contact you create, its relationship property will have a value of "Friend" unless we change its value

struct Contact3 {
    var fullName: String
    var emailAddress: String
    var relationship = "Friend"
}

// Swift is smart enough to notice which property has a default value and it will create a memberwise initializer with parameters also defaulted.

var person3 = Contact3(fullName: "Some Name", emailAddress: "someemail@gmail.com")
var person4 = Contact3(fullName: "Another Name", emailAddress: "anothername@gmail.com", relationship: "Family")


//: ### Computed Properties
//: Most of the time, properties are stored data, but some properties can just be computed, which means they perform a calculation before return a value

// A stored property can be a constant or a variable, but a computed property must be defined as variable

// Computed properties must also include a type because the compiler needs to know what to expect as a return value

struct TV {
    var height: Double
    var width: Double
    
    var diagonal: Int {
        get {
            let result = (height * height +
                          width * width).squareRoot().rounded()
            return Int(result)
        }
        set {
            let ratioWidth = 16.0
            let ratioHeight = 9.0
            let ratioDiagonal = (ratioWidth * ratioWidth +
                                 ratioHeight * ratioHeight).squareRoot()
            height = Double(newValue) * ratioHeight / ratioDiagonal
            width = height * ratioWidth / ratioHeight
        }
    }
}

var tv = TV(height: 53.93, width: 95.87)
tv.diagonal // 110


//: ### Getter and setter
//: It is also possible to create a *read-wrote computed property* with two code blocks: a getter and a setter


//: ### Type properties
//: A type itself may need properties that are COMMON accross all instances. These properties are called *type properties*

//: Imagine we are building a game with many levels. Each level has a few attributes or stored properties
//: We can use a type property to store the game's progress as the player unlocks each level. A type property is declared with the modifier *static*

//struct Level {
//    static var highestLevel = 1
//    let id: Int
//    var boss: String
//    var unlocked: Bool
//}

let level1 = Level(id: 1, boss: "Chameleon", unlocked: true)
let level2 = Level(id: 2, boss: "Squid", unlocked: false)
let level3 = Level(id: 3, boss: "Chupacabra", unlocked: false)
let level4 = Level(id: 4, boss: "Yeti", unlocked: false)

// To access the highest level:
Level.highestLevel = 2


//: ### Property observers
//:  For our *Level* implementation, it would be useful to automatically set the *highestLevel* when the player unlocks a new one. For that, we need a way to listen to property changes and with that, we need a *property observes* that get called before and after property changes

//: willSet - an observer that is called when a property is about to be changed

//: didSet - an observer that is called after a property has been changed.


struct Level {
    static var highestLevel = 1
    let id: Int
    var boss: String
    var unlocked: Bool {
        didSet {
            if unlocked && id > Self.highestLevel {
                Self.highestLevel = id
            }
        }
    }
}

// Now, when the player unlocks a new level, it will update the *highestLevel* type property if  the level is a new high.


//: Keep in mind that willSet and didSet observers are not called when a property is set during initialization; they only get called when you assign a new value to a fully initialized instance. That means property observers are only useful for variable properties since constant properties are only set during initialization.

//: ### Limiting a variable
//: we can also use property observers to limit the value of a variable. Say we had a light bulb that could only support a maximum current flowing through its filament.

struct LightBulb {
    static let maxCurrent = 40
    
    var current = 0 {
        didSet {
            if current > Self.maxCurrent {
                print("Current is too high, falling back to previous setting")
                current = oldValue
            }
        }
    }
}

//: So in this example, if you set the current exceeding its maxCurrent value, it will revert back to its old value.

var light = LightBulb()
light.current = 50
light.current // 0
light.current = 40
light.current // 40
light.current = 100
light.current // 40


//: ### Lazy properties
//: We may want to slow things down until we need the property. So if we have a property that may take some time to calculate we can use a *lazy stored property*. This one is useful for such things as downloading a user's profile picture or making a serious calculation


struct Circle {
    lazy var pi = {
        ((4.0 * atan(1.0 / 5.0)) - atan(1.0 / 239.0)) * 4.0
    }()
    
    var radius = 0.0
    var circumference: Double {
        mutating get {
            pi * radius * 2
        }
    }
    init(radius: Double) {
        self.radius = radius
    }
}

var circle = Circle(radius: 5) // got a circle, pi has not been run
circle.circumference // 31.42

