import UIKit

//: ### Classes
//: classes are named types just like structures, they can also have properties and methods. The *key difference* between them is that `classes` are reference types while `structures` are value types.



//: ### Creating classes

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

let lucas = Person(firstName: "John", lastName: "Lucas")

//: As we will notice, defining a class is similar with its struct counterpart. We can also see some difference. The class above should define an initializers that sets both of its properties. So unlike struct, class doesn't have a memberwise initializer which means we must provide our own initializer with classes.




//: ### Reference types
//: instance of a structure is an immutable value, while instance of a class is a mutable object. Classes are `reference types`, so a variable of a class type doesn't store an actual instance -- it stores a `reference` to a location in memory that store that instance


class SimplePerson {
    var name: String
    init(name: String) {
        self.name = name
    }
}

var var1 = SimplePerson(name: "Chabby")
var var2 = var1

// var1 and var2 references to the same place in mememory

var1.name = "Lucas"

var1.name
var2.name

// We'll notice now that if we update var1, var2 gets affected too coz both of them references to same class instance. That is why classes are called `reference types`



//: ### The heap vs stack

//: When we create a reference type using class, the system often stores the actual instance in a region of memory known as `heap` that has a dynamic lifetime. Instances of value types typically reside in a region of memory called `stack` that lives only as long as the current scope


//: Both `heap` and `stack` have essential roles in the execution of any program. Here's a general understanding how they work:


//: ### Stack
//: The system uses the `stack` to store anything on the immediate thread of execution; it's tightly managed and optimized by the CPU. A function allocates stack variables on entry and deallocates them on exit

//: ### Heap
//: The system uses the `heap` to store instances of reference types. The heap is generally a large pool of memory from which the system can request and dynamically allocate memory blocks. Lifetime is flexible and dynamic


//: The `heap` doesn't automatically deallocates as the stack does; addtional work is required.

/*:
 • When you create an instance of a class, your code requests a block of memory on the heap to store the instance itself; that’s the first name and last name inside the instance on the right side of the diagram. It stores the address of that memory in your named variable on the stack; that’s the reference stored on the left side of the diagram.
 
 • When you create an instance of a struct (that is not part of an instance of a class), the instance itself is stored on the stack, and the heap is never involved.
 */





//: ### Working with references


var homeOwner = lucas
lucas.firstName = "Luke" // Lucas wants to use his nickname
lucas.firstName // "Luke"
homeOwner.firstName // "Luke"


//: ### Object identity
//: Comparing variables/constants that has a class instance reference, one way you might think to compare if they have same property value like their firstName, but what if coincidentally they just have the firstName? That might cause some problem.

//: In swift, we have  === operator that lets us check if the identity of one object is equal to the identity of another

lucas === homeOwner

// This operator compares the memory address of two references.

let imposterLucas = Person(firstName: "Lucas",
                           lastName: "Lul")
lucas === homeOwner // true
lucas === imposterLucas // false
imposterLucas === homeOwner // false

// Assignment of existing variables changes the instances the variables reference.
homeOwner = imposterLucas
lucas === homeOwner // false
homeOwner = lucas
lucas === homeOwner // true


//: ### Methods and mutability
struct Grade {
    let letter: String
    let points: Double
    let credits: Double
}
class Student {
    var firstName: String
    var lastName: String
    var grades: [Grade] = []
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
}
let jane = Student(firstName: "Jane", lastName: "Appleseed")
let history = Grade(letter: "B", points: 9.0, credits: 3.0)
var math = Grade(letter: "A", points: 16.0, credits: 4.0)
jane.recordGrade(history)
jane.recordGrade(math)


/*:
 Note that recordGrade(_:) can mutate the array grades by adding more values to the end. The keyword ’ mutating ’ is not required because it mutates the underlying object and not the reference itself.
 If you had tried this with a struct, you’d have wound up with a compiler error because structures methods are, by default, immutable and can’t change any of its properties.
 */


//: ### Mutability and constants
//: We may be wondering how we could mofiy jane's grades even though it was defined as a constant. When we define a constant, the value of the constant cannot be changed. As previously mentioned, WE HAVE TO REMEMBER that, with REFERENCE TYPES, the value is a `reference`

// Doing this will cause an error if we try to change the value of reference in jane
//jane = Student(firstName: "John", lastName: "Lucas") // jane is constant, and we can't change the reference, but we can update the values of the class instance that this reference points to


// In any case the `jane` is a variable
var jane1 = Student(firstName: "Jane", lastName: "Appleseed")

// we can update the reference
jane1 = Student(firstName: "Chabby", lastName: "Lucas")

// Since nothing would be referencing to the original `jane1` object, its memory would be freed to use elsewhere



//: ### Understanding state and side effects

jane.credits

// The teacher made a mistake; math  has 5 credits
math = Grade(letter: "A", points: 20.0, credits: 5.0)
jane.recordGrade(math)

jane.credits



/*:
 Because class instances are mutable, you need to be careful about unexpected behavior around shared references.
 
 While confusing in a small example, mutability and state could be highly jarring as classes grow in size and complexity.
 
 Situations like this would be much more common with a Student class that scales to 20 stored properties and has ten methods.
 */



//: ### Extending a class using an extension
//: Classes can use extension keyword to add methods and computed properties, but not stored properties

extension Student {
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

jane.fullName


//: ### When to use a class versus a struct?

/*:
 values vs objects
 
 An object is an instance of a reference type, and such instances have identity meaning that every object is unique. Two objects may not be equal simply because they hold the same state. Hence, you use === to see if objects refer to the same place in memory. In contrast, instances of value types, which are values, are considered equal if they are the same value.
 
 For example: A delivery range is a value, so you implement it as a struct. A student is an object, so you implement it as a class. In non-technical terms, no two students are considered equal, even if they have the same name!
*/

/*:
 speed
 
 Speed considerations are a thing, as structs rely on the faster stack while classes rely on the slower heap. If you’ll have many more instances (hundreds and greater), or if these instances will only exist in memory for a short time — lean towards using a struct. If your instance will have a longer lifecycle in memory, or if you’ll create relatively few instances, then class instances on the heap shouldn’t create much overhead.
 
 For instance, you’d use a struct to calculate the total distance of a running route using many GPS-based waypoints, such as the Location struct you used in Chapter 10, “Structures”. You’ll create many waypoints, but they’ll be quickly created and destroyed as you modify the route.
 
 You could use a class for an object to store route history, as there would be only one object of this per user, and you'd likely use the same history object for the user's lifetime.
 */


/*:
 minimalist approach
 
 Another approach is to use only what you need. If your data will never change or you need a simple data store, then use structures. If you need to update your data and you need it to contain logic to update its own state, then use a class. Often, it’s best to begin with a struct. If you need the added capabilities of a class sometime later, you just convert the struct to a class.
 */



//: ### Structures vs classes

/*:
 *STRUCTURES*
 - useful for representing values
 - implicit copying of value
 - becomes completely immutable when declared with let
 - fast memory allocation(stack)
 
 *CLASSES*
 - useful for representing objects with an identity
 - implicit sharing of objects
 - internals can remain mutable even when declared with `let`
 - slower memory allocation (heap)
 */
