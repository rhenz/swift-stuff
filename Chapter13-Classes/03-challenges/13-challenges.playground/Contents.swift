import UIKit

//: ### Challenges

/*: ### Challenge 1: Movie lists
 
 Imagine you’re writing a movie-viewing app in Swift. Users can create lists of movies and share those lists with other users. Create a User and a List class that uses reference semantics to help maintain lists between users.
 • User: Has a method addList(_:) that adds the given list to a dictionary of List objects (using the name as a key), and list(forName:) -> List? that returns the List for the provided name.
 • List: Contains a name and an array of movie titles. A print method will print all the movies in the list.
 • Create jane and john users and have them create and share lists. Have both jane and john modify the same list and call print from both users. Are all the changes reflected?
 • What happens when you implement the same with structs? What problems do you run into?
 
 */

class User {
    
    var name: String
    var movieLists: [String: List] = [:]
    
    init(name: String) {
        self.name = name
    }
    
    func addList(_ list: List) {
        movieLists[list.name] = list
    }
    
    func list(forName name: String) -> List? {
        movieLists[name]
    }
}

class List {
    let name: String
    public var movieTitles: [String] = []
    
    init(name: String) {
        self.name = name
    }
}

extension List: CustomStringConvertible {
    public var description: String {
        """
        Movie List of \(name):
        \(movieTitles.joined(separator: "\n"))
        \n
        """
    }
}


let jane = User(name: "Jane")
let john = User(name: "John")
var movieList = List(name: "FaveList")

jane.addList(movieList)
john.addList(movieList)

// Add Jane's favorites
jane.list(forName: movieList.name)?.movieTitles.append("Superman")
jane.list(forName: movieList.name)?.movieTitles.append("Batman")

// Add John's favorites
john.list(forName: movieList.name)?.movieTitles.append("Spiderman")

// Now lets see their list
print(john.list(forName: movieList.name) as Any)
print(jane.list(forName: movieList.name) as Any)

// Check if list reference to same instace
john.list(forName: movieList.name) === jane.list(forName: movieList.name)


// What happens when we implement the same with structs? What problems do we run to?
/*
  1. Both users won't be able to share lists easily if we use structs
  2. If anyone of the users updates a shared list from another user, the update won't be reflected to the another user.
  3. We have to implicitly declare the addList func as mutating func
 */


/*: ### Challenge 2: T-shirt store
 
 Your challenge here is to build a set of objects to support a T-shirt store. Decide if each object should be a class or a struct and why.
 • TShirt: Represents a shirt style you can buy. Each TShirt has a size, color, price, and an optional image on the front.
 • User: A registered user of the t-shirt store app. A user has a name, email, and a ShoppingCart (see below).
 • Address: Represents a shipping address and contains the name, street, city, and zip code.
 • ShoppingCart: Holds a current order, which is composed of an array of TShirt that the User wants to buy, as well as a method to calculate the total cost. Additionally, there is an Address that represents where the order will be shipped.
 */

// Decided to just use a struct here coz it's just a simple data about a shirt. It doesn't represent a REAL shirt.
struct TShirt {
    var size: Int
    var color: String
    var price: Double
    var image: String?
}

// Decided to use a class in defining a User because all users are unique and it represents a real person.
class TUser {
    var name: String
    var email: String
    var shoppingCart: ShoppingCart
    
    init(name: String, email: String, shoppingCart: ShoppingCart) {
        self.name = name
        self.email = email
        self.shoppingCart = shoppingCart
    }
}

// Decided to use a class here as well because we are going to use this with the User class and there should only be one instance of a Shopping cart. Using a class makes it easier to share a single ShoppingCart object between multiple components of the app
class ShoppingCart {
    var currentOrders: [TShirt]
    var shippingAddress: Address
    
    init(currentOrders: [TShirt], shippingAddress: Address) {
        self.currentOrders = currentOrders
        self.shippingAddress = shippingAddress
    }
    
    func totalCost() -> Double {
        currentOrders.map{ $0.price }.reduce(0, +)
    }
}

// Address is just a simple data which can be represented as a struct
struct Address {
    var name: String
    var street: String
    var city: String
    var zipCode: Int
}
