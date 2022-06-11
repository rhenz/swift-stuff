import UIKit

//: ### Mini-Exercise
//: Use firstIndex(of:) to determine the position of the element "Dan" in players.
 
var players = ["Anna", "Brian", "Craig", "Dan", "Donna", "Franklin", "Lucas"]

if let danIndex = players.firstIndex(of: "Dan") {
    print(players[danIndex])
}

    
//: Write a for-in loop that prints the players’ names and scores.
let scores = [2, 2, 8, 6, 1, 2, 1]

for i in 0...players.count-1 {
    print("Player: \(players[i])")
    print("Score: \(scores[i])")
}



//: Write a function that prints a given player’s city and state.
var bobData = [
  "name": "Bob",
  "profession": "Card Player",
  "country": "USA",
  "city": "San Francisco"
]

func printPlayerCityAndState(player: [String: String]) {
    print("Player's City is \(player["name"]!)")
    print("Player's State is \(player["city"]!)")
}
printPlayerCityAndState(player: bobData)
