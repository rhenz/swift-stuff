import UIKit

//: ### Mini-exercises

//: Change the value of lastName on homeOwner, then try reading fullName on both john and homeOwner. What do you observe?

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
let john = Person(firstName: "Johnny", lastName: "Appleseed")

var homeOwner = john
john.firstName = "John" // John wants to use his short name!
john.firstName // "John"
homeOwner.firstName // "John"

homeOwner.lastName = "Lucas"

// Both variables/constants that holds the same reference to a class instance will have same values.
john.fullName
homeOwner.fullName


//: Write a function memberOf(person: Person, group: [Person]) -> Bool that will return true if person can be found inside group, and false if it can not. Test it by creating two arrays of five Person objects for group and using john as the person. Put john in one of the arrays, but not in the other.

func memberOf(person: Person, group: [Person]) -> Bool {
    group.contains(where: {$0 === person})
}

let chabby = Person(firstName: "Chabby", lastName: "Lucas")
let oli = Person(firstName: "Oli", lastName: "Lucas")
let nimbus = Person(firstName: "Nimbus", lastName: "Lucas")
let hachi = Person(firstName: "Hachi", lastName: "Lucas")
let anotherJohn = Person(firstName: "Johnny", lastName: "Appleseed")

let group1 = [chabby, oli, john, nimbus, hachi]
let group2 = [chabby, oli, anotherJohn, nimbus, hachi]


memberOf(person: john, group: group1)
memberOf(person: john, group: group2)


//: Add a computed property to Student that returns the student’s Grade Point Average or GPA. A GPA is defined as the number of points earned divided by the number of credits taken. For the example above, Jane earned (9 + 16 = 25) points while taking (3 + 4 = 7) credits, making her GPA (25 / 7 = 3.57).


struct Grade {
    let letter: String
    let points: Double
    let credits: Double
}

class Student {
    var firstName: String
    var lastName: String
    var grades: [Grade] = []
    
    var credits = 0.0
    
    var gpa: Double {
        let totalGrades = grades.map { $0.points }.reduce(0, +)
        let totalCredits = grades.map { $0.credits }.reduce(0, +)
        return totalGrades / totalCredits
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
        credits += grade.credits
    }
}

var jane = Student(firstName: "Jane", lastName: "Appleseed")
var history = Grade(letter: "B", points: 9.0, credits: 3.0)
var math = Grade(letter: "A", points: 16.0, credits: 4.0)

jane.recordGrade(history)
jane.recordGrade(math)
jane.gpa
