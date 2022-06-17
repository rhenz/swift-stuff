import UIKit

//: ### Mini-exercise


//: What’s different in the two-phase initialization in the base class Person compared to the others?


// the Person class is a base class and it is not required to call an initializer in a superclass.


//: Create two more convenience initializers on Student. Which other initializers are you able to call?

// The convenience initializers are able to call the other convenience initializers in addition to the designated initializer


//: Modify the Student class to have the ability to record the student’s name to a list of graduates. Add the name of the student to the list when the object is deallocated.
struct Grade {
    var letter: Character
    var points: Double
    var credits: Double
}

class Student {
    let firstName: String
    let lastName: String
    var grades: [Grade] = []
    
    static var graduates: [String] = []
    
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
    
    deinit {
        Student.graduates.append("\(lastName), \(firstName)")
    }
}
