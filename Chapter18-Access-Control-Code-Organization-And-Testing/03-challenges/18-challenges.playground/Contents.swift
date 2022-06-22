import UIKit
import os

//: ### Challenges

/*: ### Challenge 1: Singleton pattern
 
 A singleton is a design pattern that restricts the instantiation of a class to one object.
 Use access modifiers to create a singleton class Logger. This Logger should:
 
 • Provide shared, public, global access to the single Logger object.
 
 • Not be able to be instantiated by consuming code.
 
 • Have a method log() that will print a string to the console.
 
 */

Logger.shared.log("Hello, World!")



/*: ### Challenge 2: Stack
 Declare a generic type Stack. A stack is a LIFO (last-in-first-out) data structure that supports the following operations:
 
 • peek: returns the top element on the stack without removing it. Returns nil if the stack is empty.
 
 • push: adds an element on top of the stack.
 
 • pop: returns and removes the top element on the stack. Returns nil if the stack is empty.
 
 • count: returns the size of the stack.
 
 Ensure that these operations are the only exposed interface. In other words, additional properties or methods needed to implement the type should not be visible.
 */


var stack = Stack<Int>()

stack.push(3)
print(stack)

stack.push(5)
stack.push(10)
print(stack)



/*: ### Challenge 3: Character battle
 
 Utilize something called a static factory method to create a game of Wizards vs. Elves vs. Giants.
 Add a file Characters.swift in the Sources folder of your playground.
 To begin:
 
 • Create an enum GameCharacterType that defines values for elf, giant and wizard.
 
 • Create a protocol GameCharacter that inherits from AnyObject and has properties name, hitPoints and attackPoints. Implement this protocol for every character type.
 
 • Create a struct GameCharacterFactory with a single static method make(ofType: GameCharacterType) -> GameCharacter.
 
 • Create a global function battle that pits two characters against each other — with the first character striking first! If a character reaches 0 hit points, they have lost.
 
 Hints:
 • The playground should not be able to see the concrete types that implement
 
 GameCharacter.
 • Elves have 3 hit points and 10 attack points. Wizards have 5 hit points and 5 attack
 points. Giants have 10 hit points and 3 attack points.
 
 • The playground should know none of the above!
 
 In your playground, you should use the following scenario as a test case:
 */

let elf = GameCharacterFactory.make(ofType: .elf)
let giant = GameCharacterFactory.make(ofType: .giant)
let wizard = GameCharacterFactory.make(ofType: .wizard)

battle(of: elf, and: giant)
battle(of: wizard, and: giant)
battle(of: wizard, and: elf)
