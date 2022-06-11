import UIKit

//: 1. Make an optional String called myFavoriteSong. If you have a favorite song, set it to a string representing that song. If you have more than one favorite song or no favorite, set the optional to nil.
var myFavoriteSong: String?
myFavoriteSong = "Maybe the Night"
//myFavoriteSong = nil


//: 2. Create a constant called parsedInt and set it equal to Int("10"), which tries to parse the string 10 and convert it to an Int. Check the type of parsedInt using Option-Click. Why is it an optional?
let parsedInt = Int("10")

// Why is it an optional? Because 'Int("10")' could fail and once it fails, it will return a nil value


//: 3. Change the string being parsed in the above exercise to a non-integer (try dog, for example). What does parsedInt equal now?
let parsedString = Int("Dog")

// The word dog can't be parsed as an Integer, therefore it will return an optional without a value or nil







//:### SET 2 MINI-EXERCISES


//: 1. Using your myFavoriteSong variable from earlier, use optional binding to check if it contains a value. If it does, print out the value. If it doesn’t, print "I don’t have a favorite song."

if let unwrappedFavoriteSong = myFavoriteSong {
    print("My favorite song is \(unwrappedFavoriteSong)")
} else {
    print("No favorite song!")
}

//: 2. Change myFavoriteSong to the opposite of what it is now. If it’s nil, set it to a string; if it’s a string, set it to nil. Observe how your printed result changes
var anotherFavoriteSong: String?
//anotherFavoriteSong = "Maybe the Night"
anotherFavoriteSong = nil

if let unwrappedAnotherFavoriteSong = anotherFavoriteSong {
    print("My another favorite song is \(unwrappedAnotherFavoriteSong)")
} else {
    print("No other favorite song!")
}
