import UIKit

//: ### Mini-Exercises



//: 1. Create a struct Person in a new Sources file. This struct should have first, last and fullName properties readable but not writable by the playground.

var lucas = Person(first: "John", last: "Lucas")
//lucas.first = "Test" // Error

//: 2. Create a similar type, except make it a class and call it ClassyPerson. In the playground, subclass ClassyPerson with class Doctor and make a doctor’s fullName print the prefix "Dr.".

class Doctor: ClassyPerson {
    override var fullName: String {
        "Dr. \(super.fullName)"
    }
}

let doctorLucas = Doctor(first: "John", last: "Lucas")
doctorLucas.fullName
