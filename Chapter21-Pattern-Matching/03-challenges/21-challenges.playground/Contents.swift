import UIKit

//: ### Challenges


/*: ### Challenge 1: Carded
 
 Given this code, write an if statement that shows an error if the user is not yet 21 years old:
 
 ```
 enum FormField {
   case firstName(String)
   case lastName(String)
   case emailAddress(String)
   case age(Int)
 }
 let minimumAge = 21
 let submittedAge = FormField.age(22)
 ```
 */

enum FormField {
    case firstName(String)
    case lastName(String)
    case emailAddress(String)
    case age(Int)
}

let minimumAge = 21
let submittedAge = FormField.age(19)

if case .age(let age) = submittedAge, age < minimumAge {
    print("User is not yet \(minimumAge) years old")
} else {
    print("Welcome!!")
}



/*: ### Challenge 2: Planets with liquid water
 
 Given this code, find the planets with liquid water using a for loop:
 
 ```
 enum CelestialBody {
   case star
   case planet(liquidWater: Bool)
   case comet
 }
 let telescopeCensus = [
   CelestialBody.star,
   .planet(liquidWater: false),
   .planet(liquidWater: true),
   .planet(liquidWater: true),
   .comet
 ]
 ```
 */

enum CelestialBody {
    case star
    case planet(liquidWater: Bool)
    case comet
}

let telescopeCensus = [
    CelestialBody.star,
    .planet(liquidWater: false),
    .planet(liquidWater: true),
    .planet(liquidWater: true),
    .comet
]

for case .planet(let hasWater) in telescopeCensus where hasWater {
    print("Has Water")
}

/*: ### Challenge 3: Find the year
 
 Given this code, find the albums that were released in 1974 with a for loop:
 
 ```
 let queenAlbums = [
   ("A Night at the Opera", 1974),
   ("Sheer Heart Attack", 1974),
   ("Jazz", 1978),
   ("The Game", 1980)
 ]
 ```
 */
let queenAlbums = [
    ("A Night at the Opera", 1974),
    ("Sheer Heart Attack", 1974),
    ("Jazz", 1978),
    ("The Game", 1980)
]

print("Printing all albums that were released in 1974...")
for album in queenAlbums {
    switch album {
    case (let x, 1974):
        print("\(x) was released in 1974")
    default: break
    }
}

for case (let albumName, 1974) in queenAlbums {
    print("\(albumName) was release in 1974")
}


/*: ### Challenge 4: Where in the world
 
 Given the following code, write a switch statement that will print out whether the monument is located in the northern hemisphere, the southern hemisphere, or on the equator.
 
 ```
 let coordinates = (lat: 37.334890, long: -122.009000)
 ```
 */

let coordinates = (lat: 37.334890, long: -122.009000)


switch coordinates {
case let (x, _) where x > 0:
    print("Located in Northern Hemisphere")
case let (x, _) where x < 0:
    print("Located in Southern Hemisphere")
case let (x, _) where x == 0:
    print("Located on the Equator!")
default:
    print("Unknown hemisphere")
}





/*: ### Key points
 • A pattern represents the structure of a value.
 • Pattern matching can help you write more readable code than the alternative logical conditions.
 • Pattern matching is the only way to extract associated values from enumeration values.
 */
