import UIKit

//: 1. Create a constant array called names that contains some names as strings. Any names will do — make sure there are more than three. Now use reduce to create a string that is the concatenation of each name in the array.

let names = ["Lucas", "Chabby", "Oli", "Nimbus"]
let combinedNames = names.reduce("") {
    $0 + $1
}
print(combinedNames)

//: 2. Using the same names array, first filter the array to contain only names longer than four characters, and then create the same concatenation of names as in the above exercise. (Hint: You can chain these operations together.)
let combinedNamesForNamesMoreThan4Characters = names.filter{$0.count > 4}.reduce("", +)
print(combinedNamesForNamesMoreThan4Characters)


//: 3. Create a constant dictionary called namesAndAges containing some names as strings mapped to ages as integers. Now use filter to create a dictionary containing only people under the age of 18.
let namesAndAges = ["Lucas": 1, "Oli": 5, "Nimbus": 20, "Chabby": 3]
let namesAndAgesWhosAgeUnder18 = namesAndAges.filter{ $0.value < 18 }
print(namesAndAgesWhosAgeUnder18)



//:4. Using the same namesAndAges dictionary, filter out the adults (those 18 or older) and then use map to convert to an array containing just the names (i.e., drop the ages).
let namesAndAgesWhosAgeAbove18 = namesAndAges.filter { $0.value > 18 }
print(namesAndAgesWhosAgeAbove18)
