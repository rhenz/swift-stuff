import UIKit
import Darwin

/*: ### Arrays
 
 Arrays are the most common collection type in Swift. Arrays are typed, just like regular variables and constants, and store multiple values like a simple list.
 
 
 What is an array?
 An array is an ordered collection of values of the same type. The elements in the array are zero-indexed. Which means the index of the first element is 0.
 
 When are arrays useful?
 
 Arrays are useful when you want to store your items in a particular order. You may want the elements sorted, or you may need to fetch elements by index without iterating through the entire array.
 */



//: ### Creating arrays

// Using _array literal_
let evenNumbers = [2, 4, 6, 8]

// Since this array contains integers, swift infers that this is an array of Int values [Int]. If you try to add a String here, the compiler will return an error, and your code won't compile

// have to make the type explicit if you want to create empty array from the start.
var subscribers: [String] = []

// or..
var subscribersToo = [String]()


//It’s also possible to create an array with all of its values set to a default value:
let allZeros = Array(repeating: 0, count: 5) // [0, 0, 0, 0, 0]

// It’s good practice to declare arrays that aren’t going to change as constants. For example, consider this array:
let vowels = ["A", "E", "I", "O", "U"]



//: ### Accessing elements

var players = ["Alice", "Bob", "Cindy", "Dan"]

// how to check if it's empty?
players.isEmpty


// The array isn’t empty, but you need at least two players to start a game. You can get the number of players using the count property:
if players.count < 2 {
    print("We need at least two players!")
} else {
    print("Let’s start!")
}
// > Let’s start!


// How to get the first player's name? Using the _first_ property
var currentPlayer = players.first
print(currentPlayer as Any)

// It returns optional because if the array is empty, this will be nil

// Array also has _last_ property to get the last element if there's any


// Another way to get a value from an array is using `min()` method. This returns the element with the lowest value in the array
//currentPlayer = players.min()
print(currentPlayer as Any)
// > Optional("Alice")


if let currentPlayer = currentPlayer {
    print("\(currentPlayer) will start")
}

// Another way is we can use subscripting

//: ### Using subscripting
var firstPlayer = players[0]
print("First player is \(firstPlayer)")
// > First player is "Alice"

// If you try to access an array beyond its size, we get a runtime error
//var player = players[4]
// > fatal error: Index out of range


//: ### Using countable ranges to make an ArraySlice
let upcomingPlayersSlice = players[1...2]
print(upcomingPlayersSlice[1], upcomingPlayersSlice[2])
// > "Bob Cindy\n"


//: ### Checking for an element
//: using contains(_:)

func isEliminated(player: String) -> Bool {
    !players.contains(player)
}

print(isEliminated(player: "Bob"))
// > false


//: ### Modifying arrays


//: ### Appending elements
players.append("Lucas")

// Another way to append

players += ["Chabby"]
print(players)


//: ### Inserting elements
players.insert("Frank", at: 5) // Make sure you insert element within the bounds of array size, or else it will have array index out of range, frank will be inserted between Lucas and Chabby



//: ### Removing elements
var removedPlayer = players.removeLast()
print("\(removedPlayer) was removed")
// > Gina was removed


// What if we want to remove Cindy? We have to know what index her name is
removedPlayer = players.remove(at: 2)
print("\(removedPlayer) was removed")
players
// > Cindy was removed


//: ### Updating elements
print(players)
// > ["Alice", "Bob", "Dan", "Eli", "Frank"]
players[4] = "Franklin"
print(players)
// > ["Alice", "Bob", "Dan", "Eli", "Franklin"]


players[0...1] = ["Donna", "Craig", "Brian", "Anna"]
print(players)

//: ### Moving elements
let playerAnna = players.remove(at: 3)
players.insert(playerAnna, at: 0)
print(players)
// > ["Anna", "Donna", "Craig", "Brian", "Dan", "Eli", "Franklin"]

// We can also use swapAt(_:_:)
players.swapAt(1, 3)
print(players)
// > ["Anna", "Brian", "Craig", "Donna", "Dan", "Eli", "Franklin"]


// We can also sort an entire array
players.sort()
print(players)
// > ["Anna", "Brian", "Craig", "Dan", "Donna", "Eli", "Franklin"]


// If you’d like to leave the original array untouched and return a sorted copy instead, use sorted() instead of sort().


//: ### Iterating through an array
let scores = [2, 2, 8, 6, 1, 2, 1]

// remaining players
for player in players {
    print(player)
}

// if you need the index of each element you could do this.
for (index, player) in players.enumerated() {
    print("\(index + 1). \(player)")
}

// now we can use the techniques we learned here to write a function that takes an array of integers as its input and return the sum of its elements
func sumOfElements(in array: [Int]) -> Int {
    var sum = 0
    for number in array {
        sum += number
    }
    
    return sum
}

print(sumOfElements(in: scores))
players


//: ### Running time for array operations

//: Accessing Elements - is O(1)
//: Inserting Elements - is O(n), but if you add at the end of an array, it will take O(1), and if there isn't room, Swift will automatically make space somewhere and copy the entire array before adding the new element which will take O(n). The average case is O(1) because arrays are not full most of the time.
//: Deleting Elements - time complexity is similar with Inserting Elements, if you're removing at the end, it's O(1). Otherwise, the complexity is O(n)
//: Searching for Element - is O(n) in average.





//: ### Dictionaries
//: A dictionary is an unordered collection of pairs, where each pair comprises a _key_ and a _value_.
//: _keys_ are always unique. Same _key_ can't appear twice. But different _keys_ may point to a same value. All _keys_ must be of the same type and all _values_ must be of the same type too.
//: Dictionaries are useful when you want  to look up values by means of identifier.




//: ### Creating Dictionaries
//: The easiest way to create a dictionary is by using a _dictionary literal_

var namesAndScores = ["Anna": 2, "Brian": 2, "Craig": 8, "Donna": 6]
print(namesAndScores)

// In this example, the Swift infers the dictionary to be of type [String: Int]

namesAndScores = [:] // This is how we empty a dictionary

// To create a new empty dictionary
var pairs: [String: Int] = [:]
var pairs2 = [String: Int]()

// Creating dictionary, you can define its capacity to improve performance when you know how much data the dictionary needs to store only.
pairs.reserveCapacity(20)

//: ### Accessing values

//: Using subscripting
namesAndScores = ["Anna": 2, "Brian": 2, "Craig": 8, "Donna": 6]
print(namesAndScores["Anna"]!)

//: Using invalid key return nil
print(namesAndScores["LOL"] as Any)


//: Using properties and methods
namesAndScores.isEmpty
namesAndScores.count

//: Modifying dictionaries

// Adding pairs
var bobData = [
    "name": "Bob",
    "profession": "Card Player",
    "country": "USA"
]

//
bobData.updateValue("CA", forKey: "country")

// Shortest way
bobData["city"] = "San Francisco"

// But if these keys aren't available, this will be added as a new key-value pair in your dictionary using the same syntax above so be careful, always make sure your key is right
bobData["age"] = "31"
bobData


//: Updating Values

// We can update bob's name to bobby like this:
bobData.updateValue("Bobby", forKey: "name") // Bob


// Like i mentioned before, using key's that is not currently present in the dictionary, Swift will add this key to your dictionary.
bobData["profession"] = "Mailman"


//: Removing Pairs

bobData.removeValue(forKey: "city") // This will remove the key and value associated with _city_ key

// Another way to do this is and much shorter way
bobData["city"] = nil


//: Iterating through dictionaries

// (key, value) in namesAndScores
for (player, score) in namesAndScores {
    print("\(player) - \(score)")
}


//It’s also possible to iterate over just the keys:
for player in namesAndScores.keys {
    print("\(player),", terminator: "") // No new line
}


/*: ### Running time for dictionary operations
 
 To examine how dictionaries work, you need to understand what _hashing_ is and how it works. Hashing is the process of transforming a value -- String, Int, Double, Bool, etc -- to a numeric value, known as the _hash value_. This value can then be used to quickly look up the values in a _hash table_
 
 Swift dictionaries have a type requirement for keys. Keys must be _Hashable_, or you will get a compile error
 
 NOTE: Never save a hash value because it will be different each time you run your program.
 
 **Time complexities**:
 
 **Accessing elements** - Getting the value for a key is a constant time operation or O(1)
 
 **Inserting elements** - To insert an element, the dictionary needs to calculate the hash value of the key then store data based on that hash. These are all O(1) operation
 
 **Deleting elements** - Again, dictionary need sto calculate the hash value to know exactly where to find the element and remove it. Also O(1)
 
 **Searching for an element* - Accessing an element of dictionary has a constant time too. O(1)
 
 While all operations are much better than Arrays, remember that dictionaries is an unordered list and you can't sort it.
*/




/*: ### Sets
 
 A set is another _unordered_ collection of unique values of the same type. This is extremely useful when you want to ensure that an item doesn't appear more than once in your collection and when the order of our items is not important
 */


//: Creating sets
let setOne: Set<Int> = [1]

//: Set literals

// Set doesn't have their own literals. We use **array literals* to create a set with inital values and we have to explicitly declare it's type like:
var explicitSet: Set<Int> = [1, 2, 3, 1] // this will automatically remove the duplicates which in this is is 1

// another way to create a set is
var someSet = Set([1, 2, 3, 4, 1])


//: Accessing elements
print(someSet.contains(1)) // true
print(someSet.contains(6)) // false

//: Adding and removing elements
someSet.insert(5)

someSet.remove(5)
print(someSet)


//: ### Running time for set operations
//: Sets have very similar implementation to dictionaries, and they also require the elements to be _hashable_. The running time of all the operations is identical to those of dictionaries.
