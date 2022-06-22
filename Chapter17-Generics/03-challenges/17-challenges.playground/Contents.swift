import UIKit

//: ### Challenges


/*: ### Challenge 1: Build a collection
 Consider the pet and keeper example from earlier in the chapter:
 
 
 ```
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
 ```
 
 Imagine that instead of looking after only two animals, every keeper looks after a changing number of animals throughout the day. It could be one, two, or ten animals per keeper instead of just morning and afternoon ones. You’d have to do things like the following:
 
 ```
 let christine = Keeper<Cat>(name: "Christine")
 christine.lookAfter(someCat)
 christine.lookAfter(anotherCat)
 ```
 
 You’d want access to the count of animals for a keeper like christine.countAnimals and to access the 51st animal via a zero-based index like christine.animalAtIndex(50).
 
 Of course, you’re describing your old friend, the array type, Array<Element>!
 
 Your challenge is to update the Keeper type to have this kind of interface. You’ll probably want to include a private array inside Keeper and then provide methods and properties on Keeper to allow outside access to the array.
 */


class Cat: Pet {
   var name: String
   init(name: String) {
      self.name = name
   }
}

class Dog: Pet {
   var name: String
   init(name: String) {
      self.name = name
   }
}

protocol Pet {
   var name: String { get }
}

class Keeper<Animal: Pet> {
   var name: String
   
//   var morningCare: Animal
//   var afternoonCare: Animal
   private var animals: [Animal] = []
   
   public var countAnimals: Int {
      animals.count
   }
   
   init(name: String) {
      self.name = name
   }
   
   public func lookAfter(_ animal: Animal) {
      animals.append(animal)
   }
   
   public func animalAtIndex(_ index: Int) -> Animal {
      animals[index]
      
   }
   
   public func last() {
      print("POTA")
      print(animals.last)
   }
}

let christine = Keeper<Cat>(name: "Christine")
let chabby = Cat(name: "Chabby")
let oli = Cat(name: "Oli")

christine.lookAfter(chabby)
christine.lookAfter(oli)
christine.last()


christine.countAnimals

christine.animalAtIndex(0)

