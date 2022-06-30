import UIKit

//: ### Protocol-Oriented Programming
//: Apple declared Swift to be the first protocol-oriented programming language. This is because of the `protocol extensions`. Extending protocols is the key to an entirely new style of programming

// POP emphasizes coding protocols instead of specific classes, structs or enums.


//: ### Introducing protocol extensions

extension String {
    func shout() {
        print(uppercased())
    }
}

"Swift is pretty cool".shout()

// On this example, we can extend any type, including ones that we didn't write ourselves, and we can have any number of extensions on a type

protocol TeamRecord {
    var wins: Int { get }
    var losses: Int { get }
    var winningPercentage: Double { get }
}

extension TeamRecord {
    var gamesPlayed: Int {
        wins + losses
    }
}

// Now we can write simple types that adopt to TeamRecord and use gamesPlayed computed property without reimplementing it


struct BaseballRecord: TeamRecord {
    var wins: Int
    var losses: Int
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses)
    }
}

let sanFranciscoSwifts = BaseballRecord(wins: 10, losses: 5)
sanFranciscoSwifts.gamesPlayed


//: ### Default implemnetations
//: A Protocol defines a contract for any type that adopts it. If a protocol defines a method or a property, any type that adopts the protocol must implement that method or property


//struct BasketballRecord: TeamRecord {
//    var wins: Int
//    var losses: Int
//    let seasonLength = 82
//
//    var winningPercentage: Double {
//        Double(wins) / Double(wins + losses)
//    }
//}


// Both BasketballRecord and BaseballRecord have identical implementation of winningPercentage. Most probably, all TeamRecord types will implement this property the same way, that could lead to a lot of repititive code.

// We can create a default implementation to prevent code repititions
extension TeamRecord {
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses)
    }
}


struct BasketballRecord: TeamRecord {
    var wins: Int
    var losses: Int
    let seasonLength = 82
}

let minneapolisFunctors = BasketballRecord(wins: 60, losses: 22)
minneapolisFunctors.winningPercentage


//: ### Understanding protocol extension dispatch

protocol WinLoss {
    var wins: Int { get }
    var losses: Int { get }
//    var winningPercentage: Double { get }
}

extension WinLoss {
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses)
    }
}

// Now lets adopt to this
struct CricketRecord: WinLoss {
    var wins: Int
    var losses: Int
    var draws: Int
    
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses + draws)
    }
}

let miamiTuples = CricketRecord(wins: 8, losses: 7, draws: 1)
let winLoss: WinLoss = miamiTuples

miamiTuples.winningPercentage // 0.5
winLoss.winningPercentage // 0.53333....

// Even if miamTuples and winLoss contain the same instance, we see different results. The result is because static dispatch chooses an implementation based on the compile-time type: CricketRecord for miamiTuples and WinLoss for winLoss


//: ### Type constraints
//: Swift lets us write extensions for certain adopting types. Using a type constraint on a protocol extension, we are able to use methods and property from that type

protocol PostSeasonEligible {
    var minimumWinsForPlayoffs: Int { get }
}

extension TeamRecord where Self: PostSeasonEligible {
    var isPlayoffEligible: Bool {
        wins > minimumWinsForPlayoffs
    }
}

// We have new protocol PostSeasonEligible, that defines a property of minimumWinsForPlayoffs. Inside the extension of TeamRecord, we have a type constraint on `where Self: PostSeasonEligible` that will apply also the extension to all adopters of TeamRecord that also adopt PostSeasonEligible


// Applying the type constraint to the TeamRecord extension means that within the extension, self is known to be both a TeamRecord and PostSeasonEligible. That means we can use property and methods defined on both of those types


//: ### Protocol-oriented benefits

//: Programming to Interfaces, not implementation, we can apply code contracts to any type - even those that doesn't support inheritance.



