import UIKit

//: ### Mini-exercises

//: Write a default implementation on CustomStringConvertible that will simply remind you to implement description by returning Remember to implement CustomStringConvertible!.
//: Once you have your default implementation, you can write code like this:

extension CustomStringConvertible {
    var description: String {
        "Remember to implement CustomStringConvertible!"
    }
}

struct MyStruct: CustomStringConvertible { }
print(MyStruct())



//: Write a default implementation on CustomStringConvertible that will print the win/loss record in Wins - Losses format for any TeamRecord type. For instance, if a team is 10 and 5, it should return 10 - 5.
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

extension TeamRecord {
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses)
    }
}

extension CustomStringConvertible where Self: TeamRecord {
    var description: String {
        "\(wins) - \(losses)"
    }
}


struct Basketball: TeamRecord, CustomStringConvertible {
    var wins: Int
    var losses: Int
}

let bball = Basketball(wins: 10, losses: 9)
bball.winningPercentage
bball.gamesPlayed
print(bball)
