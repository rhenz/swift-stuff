import UIKit

//: ### Mini-exercises
class Cat {
   var name: String
   
   init(name: String) {
      self.name = name
   }
}

class Dog {
   var name: String
   
   init(name: String) {
      self.name = name
   }
}

class Keeper<Animal> {
   var name: String
   var morningCare: Animal
   var afternoonCare: Animal
   
   init(name: String, morningCare: Animal, afternoonCare: Animal) {
      self.name = name
      self.morningCare = morningCare
      self.afternoonCare = afternoonCare
   }
}

//: • Try instantiating another Keeper but this time for dogs.
let john = Keeper(name: "John", morningCare: Dog(name: "Hachi"), afternoonCare: Dog(name: "Brownie"))

//: • What would happen if you tried to instantiate a Keeper with a dog in the morning and a cat in the afternoon?
//let john = Keeper(name: "John", morningCare: Dog(name: "Hachi"), afternoonCare: Cat(name: "Chabby"))
// Error! Conflicting arguments to generic parameter 'Animal' (Dog vs Cat)

//: • What happens if you try to instantiate a Keeper but for strings?
let angel = Keeper(name: "Angel", morningCare: "Chabby", afternoonCare: "Oli")

// We can instantiate Keeper generic type as long as the generic parameter are of same type.
