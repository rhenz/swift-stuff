import UIKit


//: ### Advance Classes


//: ### Introducing Inheritance

struct Grade {
    var letter: Character
    var points: Double
    var credits: Double
}

class Person {
    var firstName: String
    var lastName: String
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

// Example of inheritance, since student is a Person as well, student inherits the initializer and properties of Person class
//class Student: Person {
//    var grades: [Grade] = []
//
//    func recordGrade(_ grade: Grade) {
//        grades.append(grade)
//    }
//}

// Now we can create `Student` objects that have all the properties and methods of a `Person`
let john = Person(firstName: "John", lastName: "Appleseed")
let jane = Student(firstName: "Jane", lastName: "Appleseed")

//: A class inheriting from another class is known as `subclass`. The class it inherits is known as `superclass` or `base class`

/*
class BandMember: Student {
    
    var minimumPracticeTime = 2
    
    required init(firstName: String, lastName: String) {
        super.init(firstName: firstName, lastName: lastName)
    }
}

class OboePlayer: BandMember {
    // This is an example of an override, which we’ll cover soon.
    override var minimumPracticeTime: Int {
        get {
            super.minimumPracticeTime * 2
        }
        set {
            super.minimumPracticeTime = newValue / 2
        }
    }
    
    required init(firstName: String, lastName: String) {
        super.init(firstName: firstName, lastName: lastName)
    }
}
*/

//: ### Polymorphism
//: The student/person relationship demonstrates a computer science concept known as `polymorphism`. Polymorphism is a programming language's ability to treat an object differently based on context


//: An OboePlayer is, of course, an OboePlayer, but it's also a Person. Because it derives from `Person` we could use an `OboePlayer` object anywhere you'd use a `Person` object.

func phonebookName(_ person: Person) -> String {
    "\(person.lastName), \(person.firstName)"
}

//let person = Person(firstName: "Chabby", lastName: "Lucas")
//let oboePlayer = OboePlayer(firstName: "Nimbus", lastName: "Lucas")

//phonebookName(person)
//phonebookName(oboePlayer)



//: ### Runtime hierarchy checks
//var hallMonitor = Student(firstName: "Jill", lastName: "Bananapeel")
//hallMonitor = oboePlayer

// because hallMonitor is defined as a Student, the compiler wont allow you to attempt calling properties or methods for a more derived type

// Fortunately, Swift provides the `as` casting-operator to treat a property or a variable as another type:

// as: Cast to a specific type that is known at compile-time to success, such as casting to a supertype
// as?: An optional downcast (to a subtype). If the downcast fails, the result of the expression will be nil
// as!: A forced downcast. If the downcast fails, the program will crash. Use this rarely, and only when you are certain the cast will never fail

//oboePlayer as Student
//(oboePlayer as Student).minimumPracticeTime // ERROR: No longer a band member!
//hallMonitor as? BandMember
//(hallMonitor as? BandMember)?.minimumPracticeTime // 4 (optional)
//hallMonitor as! BandMember // Careful! Failure would lead to a runtime crash.
//(hallMonitor as! BandMember).minimumPracticeTime // 4 (force unwrapped)

/*
if let hallMonitor = hallMonitor as? BandMember {
    print("This hall monitor is a band member and practices at least \(hallMonitor.minimumPracticeTime) hours per week.")
}*/


//: You may be wondering under what contexts you would use the `as` operator by itself. Any object contains all the properties and methods of its parent class, so what use is casting it to something it already is?
//: Swift has a strong type system, and the interpretation of a specific type can affect static dispatch, aka the process of deciding which operation to use at compile-time.

/*
func afterClassActivity(for student: Student) -> String {
    "Goes home"
}

func afterClassActivity(for student: BandMember) -> String {
    "Goes to practice"
}
*/

//afterClassActivity(for: oboePlayer) // Goes to practice!
//afterClassActivity(for: oboePlayer as Student) // Goes home!


//: inheritance, methods and overrides
//class StudentAthlete: Student {
//    var failedClasses: [Grade] = []
//
//    override func recordGrade(_ grade: Grade) {
//        var newFailedClasses: [Grade] = []
//        for grade in grades {
//            if grade.letter == "F" {
//                newFailedClasses.append(grade)
//            }
//        }
//        failedClasses = newFailedClasses
//        super.recordGrade(grade) // this will cause problem in this context, it won't catch the last added grade in `grades`. It's a good practice to always call super first when overriding.
//    }
//}

//let studentAthlete = StudentAthlete(firstName: "Chabby", lastName: "Lucas")
//studentAthlete.recordGrade(Grade(letter: "A", points: 20, credits: 3))
//print(studentAthlete.grades)
//
//studentAthlete.recordGrade(Grade(letter: "F", points: 0, credits: 3))
//print(studentAthlete.grades)
//print(studentAthlete.failedClasses)


//: Introducing super
//: You may have also noticed the line `super.recordGrade(grade)` in the override method. The super keyword is similar to self, except it will invoke the method in the nearest implementing superclass. In this example it will call the recordGrade defined in Student class



//: ### Preventing inheritance
//: Sometimes we want to disallow subclasses of a particular class. Swift provides a `final` keyword for that

//final class FinalStudent: Person { }
//class FinalStudentAthlente: FinalStudent { } //errror!


//: We can also use `final` keyword with functions that we do not want to be overridden.

// There are benefits to initially marking any new class you write as `final`. This keyword tells the compiler it doesn't need to look for any more subclasses, which can shorten compile-time, and it also requires you to be very explicit when deciding to subclass a class previously marked `final`



//:  ### Required and convenience initializers

//: We already know it's possible to have multiple initializers in a class, which means we could potentially call any of those initializers from a subclass
//: Subclasses of Student could potentially rely on the Student-based initializer when they call super.init. Additionally, the subclasses might not even provide a method to initialize with first and last names.
//: You might decide the first and last name-based initializer is important enough that you want it to be available to all subclasses.
//: Swift supports this through the language feature known as *required initializers*.

class Student {
    let firstName: String
    let lastName: String
    var grades: [Grade] = []
    
    required init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    convenience init(transfer: Student) {
        self.init(firstName: transfer.firstName, lastName: transfer.lastName)
    }
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
}


class StudentAthlete: Student {
    var failedClasses: [Grade] = []
    var sports: [String] = []
    
    required init(firstName: String, lastName: String) {
        self.sports = []
        super.init(firstName: firstName, lastName: lastName)
    }
    
    override func recordGrade(_ grade: Grade) {
        var newFailedClasses: [Grade] = []
        for grade in grades {
            if grade.letter == "F" {
                newFailedClasses.append(grade)
            }
        }
        failedClasses = newFailedClasses
        super.recordGrade(grade) // this will cause problem in this context, it won't catch the last added grade in `grades`. It's a good practice to always call super first when overriding.
    }
}


//: We can also mark an initializer as a `convenience` initializer
