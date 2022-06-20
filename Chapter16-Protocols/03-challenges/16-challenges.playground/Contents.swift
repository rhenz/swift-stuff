import UIKit

//: ### Challenges

/*: ### Challenge 1: Pet shop tasks
 
 Create a collection of protocols for tasks at a pet shop with dogs, cats, fish and birds. The pet shop duties include these tasks:
 • All pets need to be fed.
 • Pets that can fly need to be caged.
 • Pets that can swim need to be put in a tank.
 • Pets that walk need exercise.
 • Tanks and cages need to be cleaned occasionally.
 
 1. Create classes or structs for each animal and adopt the appropriate protocols. Feel free to simply use a print() statement for the method implementations.
 2. Create homogeneous arrays for animals that need to be fed, caged, cleaned,
 walked, and tanked. Add the appropriate animals to these arrays. The arrays
 should be declared using the protocol as the element type, for example, var caged: [Cageable]
 3. Write a loop that will perform the proper tasks (such as feed, cage, walk) on each element of each array.
 */


// 1.
protocol Feedable {
    func feed()
}

protocol Cleanable {
    func clean()
}

protocol Litterboxable: Cleanable {
    var hasLitterbox: Bool { get set }
    func useLitterbox()
}

protocol Cageable: Cleanable {
    func cage()
}

protocol Tankable: Cleanable {
    func tank()
}

protocol Walkable {
    func walk()
}

// MARK: - Cat

struct Cat: Feedable, Litterboxable {
    
    var hasLitterbox: Bool = true
    
    func feed() {
        print("Feeding the cat..")
    }
    
    func useLitterbox() {
        print("Cat is pooping..")
    }
}

extension Cat: Cageable {
    func cage() {
        print("Putting cat in the cage..")
    }
    
    func clean() {
        var message = "Cleaning the cage"
        if hasLitterbox {
            message += " and the litterbox"
        }
        message += "..."
        print(message)
    }
}

extension Cat: Walkable {
    // Yes, cats can walked if they can and used to it
    func walk() {
        print("Walking the cat..")
    }
}


// MARK: - Dog
struct Dog: Feedable, Walkable, Cleanable {
    func feed() {
        print("Feeding the dog..")
    }
    
    func walk() {
        print("Walking the dog..")
    }
    
    func clean() {
        print("Cleaning the potty trainer..")
    }
}

struct GoldFish: Feedable, Tankable {
    func feed() {
        print("Feeding the fish..")
    }
    
    func tank() {
        print("Putting the fish in the tank..")
    }
    
    func clean() {
        print("Cleaning the fish tank..")
    }
}

struct LoveBird: Feedable, Cageable {
    func feed() {
        print("Feeding the love bird..")
    }
    
    func cage() {
        print("Putting the love bird in cage..")
    }
    
    func clean() {
        print("Cleaning the bird cage..")
    }
}

// 2
let cat = Cat()
let dog = Dog()
let goldFish = GoldFish()
let loveBird = LoveBird()

let animals: [Feedable] = [cat, dog, goldFish, loveBird]
let walkableAnimals: [Walkable] = [cat, dog]
let tankableAnimals: [Tankable] = [goldFish]
let cleaningDuties: [Cleanable] = [cat, dog, goldFish, loveBird]
let cageableAnimals: [Cageable] = [cat, loveBird]


// 3. Write a loop that will perform the proper tasks (such as feed, cage, walk) on each element of each array.

for animal in animals {
    animal.feed()
}
print("\n\n")

for walkableAnimal in walkableAnimals {
    walkableAnimal.walk()
}
print("\n\n")

for tankableAnimal in tankableAnimals {
    tankableAnimal.tank()
    tankableAnimal.clean()
}
print("\n\n")

for cleaningDuty in cleaningDuties {
    cleaningDuty.clean()
}
print("\n\n")

for cageableAnimal in cageableAnimals {
    cageableAnimal.cage()
    cageableAnimal.clean()
}
