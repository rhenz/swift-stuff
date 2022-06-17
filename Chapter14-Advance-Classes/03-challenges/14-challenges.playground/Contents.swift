import UIKit

//: ### Challenges

/*: ### Challenge 1: Initialization order
 Create three simple classes called A, B, and C where C inherits from B and B inherits from A. In each class initializer, call print("I’m <X>!") both before and after super.init(). Create an instance of C called c. What order do you see each print() called in?
 */

// See challenge #2 implementation

/*: ### Challenge 2: Deinitialization order
 Implement deinit for each class. Create your instance c inside of a do { } scope, causing the reference count to go to zero when it exits the scope. Which order do the classes deinitialize?
 */

class A {
    init() {
        print("I'm A(1)!")
    }
    
    deinit {
        print("Deallocating A")
    }
}

class B: A {
    override init() {
        print("I'm B(1)!")
        super.init()
        print("I'm B(2)!")
    }
    
    deinit {
        print("Deallocating B")
    }
}

class C: B {
    override init() {
        print("I'm C(1)!")
        super.init()
        print("I'm C(2)!")
    }
    
    deinit {
        print("Deallocating C")
    }
}

do {
    let _ = C()
}


/*: ### Challenge 3: Type casting
 Cast the instance of type C to an instance of type A. Which casting operation do you use and why?
 */

let cInstance = C()
let castA = cInstance as A

// The `as` keyword is used because `C` is a subtype of `A`. It's like upcasting, when downcasting we use `as?`

/*: ### Challenge 4: To subclass or not
 Create a subclass of StudentAthlete called StudentBaseballPlayer and include properties for position, number, and battingAverage. What are the benefits and drawbacks of subclassing StudentAthlete in this scenario?
 */

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct Grade {
    let letter: String
    let points: Double
}

class Student: Person {
    var grades: [Grade] = []
}

class StudentAthlete: Student {
  var sports: [String] = []
}

class StudentBaseballPlayer: StudentAthlete {
    var position: String = ""
    var number: Int = 0
    var battingAverage: Double = 0
}

/*
 
Benefits:
 
- One benefits is that we don't need to rewrite the properties of the classes it inherits from. We get that all for free.
- Type relationship with superclasses. StudentBaseballPlayer is a Student
 
 Drawbacks:
 
 - Initializer that gets bigger and bigger
 - `sports` is a bit awkward in the context of StudentBaseballPlayer coz we know that he's a baseball player already
 - It's getting to deep and could be difficult to understand the hierarchy.
 
*/

