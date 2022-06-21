import UIKit

//: ### Generics


//: ### Values defined by other values
//: Suppose we are running a pet shop that sells only dogs and cats, and we want to model the business here in Swift playgrounds. To start, we define a type, PetKind, that can hold two possible values corresponding to the two kinds of pets that we sell.


enum PetKind {
   case cat
   case dog
}

// Now suppose we want to model the animals and the employees, the pet keeps who look after them. Our employees are highly specialized. Some keeps only look after cats, and others only dogs. We define a KeeperKind type like:

struct KeeperKind {
   var keeperOf: PetKind
}

// The we can initalize a catKeep and dogKeeper like:
let catKeeper = KeeperKind(keeperOf: .cat)
let dogKeeper = KeeperKind(keeperOf: .dog)

// There are two points to note about how we are modeling our shop.

// 1. We are representing the different kinds of pets and keepers by varying the values of types. There's only one type for pet kinds - PetKind - and one type for keeper of kinds - KeeperKind. Different kinds of pets are represented only by distinct values of the PetKind type, just as different kinds of keepers are represented by distinct values of the KeeperKind type.

// 2. One range of possible values determines another range of possible values. Specifically, the range of possible KeeperKind values mirrors the range of possible PetKind values. If our store started selling birds, we simply add a bird member to the PetKind enums and immediately be able to initialize a value describing a bird keeper, KeeperKind(keeperOf: .bird). And if we started selling a hundred kinds of pets, we immediately be able to represent a hundred different kind of keepers. In contrats, we could have defined a second unrelated enumeration instead of KeeperKind

enum EnumKeeperKind {
   case catKeeper
   case dogKeeper
}

// In this case, nothing would enforce this releationship except our diligence in always updating one type to mirror the other. If we added PetKind.snake but forgot to add EnumKeeperKind.snakeKeeper, then things would get out of whack.

// But with KeeperKind, we explicitly established the relationship via a property of type PetKind. Every possible PetKind value implies a corresponding KeeperKind value. Or we could say, the set of potential PetKind values defines the set of possible KeeperKind values.

/*:
 To summarize, we can depict the relationship like
 
 ```
 PetKind values                         KeeperKind values
 --------------                         -----------------
 .cat                                   KeeperKind(keeperOf: .cat)
 .dog                                   KeeperKind(keeperOf: .dog)
 .etc                                   KeeperKind(keeperOf: .etc)
 ```
 */


//: ### Types defined by other types
//: The model above fundamentally works by varying the values of types. Now consider another w ay to model the pet-to-keeper system - by varying the types themselves.

//: Suppose that instead of defining a single type PetKind representing all kidns of pets, we chose to define a distinct type for every kind of pet we sell.

//: Distinct types are plausible choice if we are working in an object-oriented style, where we model the pets' behaviors with different methods for each pet. They we will have the following

//class Cat { }
//class Dog { }

// Now how do we represent the corresponding kinds of keepers? We could simply write the following:
class KeeperForCats { }
class KeeperForDogs { }

// But that's no good. This approach has exactly the same problem as manually defining a parallel enum of KeeperKind values - it relies on you to enforce the required domain relationship of one kind of keeper for every kind of pet

// What we like is a way to declare a relationship just like the one we established for values

// We like to declare that every possible pet type implies the existence of a corresponding keeper type, a correspondence that we depict:

/*:
 ```
 PetKind types                          Keeper types
 --------------                         -----------------
 Cat                                    Keeper(of Cat...)
 Dog                                    Keeper(of Dog...)
 etc.                                   etc.
 ```
 */

//: We like to establish that for every possible pet type that there's a corresponding Keeper type. But we don't want to do this manually. We want a way to automatically define a set of new types for all the keepers.

//: Automatic type generations is the problem that _generics_ solve!




//: ### Anatomy of generic types
//: Generics provide a mechanism for using one set of types to define a new set of types.
//: In our example, we define a generic type for keepers, like:

//class Keeper<Animal> { }
/*:
 This definition immediately defines all the corresponding keeper types as desired
 
 ```
 Pet types                              Keeper types
 --------------                         -----------------
 Cat                                    Keeper<Cat>
 Dog                                    Keeper<Dog>
 ```
 */

// We can verify these types are real by creating values of them like:

//var aCatKeeper = Keeper<Cat>(name: "Chabby")

// What's going on here? First, Keeper is the name of a generic type. We might say that a generic types isn't a type at all. It's more like a recipe for making real types or _concrete types_. One sign of this is the error we get if we try to instantiate it in isolation:
//var aKapper = Keeper() // Error

// One we provide the required type parameter, as in Keeper<Cat>, the generic Keeper becomes a new concrete type. Keeper<Cat> is different from Keeper<Dog>, even though they started from the same generic type. These resulting concrete types are called *specialization* of the generic type.


//: ### Using type parameters
//: usually, though, we want to do something with type parameters. Suppose we want to keep better track of individuals. First, we enrich our type definitions to include identififers, such as names. Adding it lets every value represent the identity of an individual animal or keeper
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

//class Keeper<Animal> {
//   var name: String
//
//   init(name: String) {
//      self.name = name
//   }
//}

// Let's say we want to track which keeper looks after which animals. Suppose every keeper is reponsible for one animal in the morning and another in the afternoon. We can express this by adding properties for the morning and afternoon animals. But what type should those properties have?

//class Keeper<Animal> {
//   var name: String
//   var morningCare: Animal
//   var afternoonCare: Animal
//
//   init(name: String, morningCare: Animal, afternoonCare: Animal) {
//      self.name = name
//      self.morningCare = morningCare
//      self.afternoonCare = afternoonCare
//   }
//}

// Using Animal in the body of the generic type definition above, we can express that the morning and afternoon animals must be the kind of animal the keeper knows best. Just as function parameters become constants to use within the body of your function definition, you can use type parameters such as Animal throughout your type definitions. You can use the type parameter anywhere in the definition of Keeper<Animal> for stored properties, computed properties, method signatures and nested types

// Now when we instantiate a Keeper, Swift will make sure, at compile-time, that the morning and after types are the same:

let lucas = Keeper(name: "Lucas", morningCare: Cat(name: "Chabby"), afternoonCare: Cat(name: "Oli"))

// Here, the keeper Lucas manages the cat Chabby in the morning and the cat Oli in the afternoon. The type of lucas is Keeper<Cat>. Note that we did not have to specify a value for the type parameter. Because we used instances of Cat as the values for morningCare and afternoonCare, Swift knows the type of lucas should be Keeper<Cat>



//: ### Type constraints
//: In our definition of Keeper, the identifier Animal serves as a type parameter named placeholder for some concrete type we supply later


//: This is much like the paramter name cat in an ordinary function like func feed(cat: Cat) { }. But when calling this function we can't simply pass any argument to the function. We can only pass values of type Cat.

//: However, at present, we could offer any type for Animal, even something nonsensically unlike an animal, like a String or Int. Being able to use anything is no good. What we like is a mechanism more closely analogous to a function parameter. We want a feature that lets us restrict what kind of types are allowed in the type parameter. In Swift, we do this with various kinds of _type constraints_

//: A simple kind of type constraint applies directly to a type parameter, and it looks like this:

class Keeper<Animal: Pet> {
   var name: String
   var morningCare: Animal
   var afternoonCare: Animal
   
   init(name: String, morningCare: Animal, afternoonCare: Animal) {
      self.name = name
      self.morningCare = morningCare
      self.afternoonCare = afternoonCare
   }
}
//: Here, the constraint : Pet requires that the type assigned to Animal must be a subclass of Pet, if Pet is a class, or must implement the Pet protocol if Pet is a protocol. For instance, to comply with the constraint established by the revised Keeper definition, we could redefine Cat and other animals to implement Pet, or we could retro-actively model conformance to the protocol by using an extension

protocol Pet {
   var name: String { get }
}

extension Cat: Pet { }
extension Dog: Pet { }

// This code works because Cat and Dog already implement a name stored property

//: In addition to such simple type constraints, we can define more complex type constraints using a generic where clause. We can use a where clause in definition of free functions, types, member functions, protocols, and even extensions

extension Array where Element: Cat {
   func meow() {
      forEach { print("\($0.name) says Meow!") }
   }
}


//: We can even specify that a type should conform to some protocol only if it meets certain constraints. Suppose that anything that can meow is a Meowable. We could write that every Array isMeowable if its elements are as follows



protocol Meowable {
   func meow()
}

extension Cat: Meowable {
   func meow() {
      print("\(self.name) says meow!")
   }
}


extension Array: Meowable where Element: Meowable {
   func meow() {
      forEach { $0.meow() }
   }
}

// This code demonstrates conditional conformance, a subtle but powerful mechanism of composition




//: ### Generic function parameters
//: Functions can be generic as well. A function's type parameter list comes after the function name. We can then use the generic parameters in the rest of the definition. This function takes two arguments and swaps their order:

func swapped<T, U>(_ x: T, _ y: U) -> (U, T) {
   (y, x)
}

swapped(33, "Jay")

// A generic function definition demonstrates a confusing aspect of the synxtax: having both type parameters and function parameters. You have both the generic parameter list of type parameters <T, U> and the list of function parameters.




/*: ### Key Points
 
 • Generics are everywhere in Swift: optionals, arrays, dictionaries, other collection structures, and most basic operators like + and ==.
 • Generics express systematic variation at the level of types via type parameters that range over possible concrete types.
 • Generics are like functions for the compiler. They are evaluated at compile-time and result in new types, which are specializations of the generic type.
 • A generic type is not a real type on its own, but more like a recipe, program, or template for defining new types.
 • Swift provides a rich system of type constraints, which lets you specify what types are allowed for various type parameters.
 */

