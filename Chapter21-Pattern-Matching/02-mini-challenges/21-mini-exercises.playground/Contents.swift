import UIKit

//: ### Mini-exercises


//: Given the population of a group, write a switch statement that prints out a comment for different group sizes: single, a few, several and many.

let group1 = (population: 1, name: "Group 1")
let group2 = (population: 5, name: "Group 2")
let group3 = (population: 20, name: "Group 3")
let group4 = (population: 200, name: "Group 4")


func processGroup(group: (population: Int, name: String)) -> String {
    
    let single = 1
    let few = 2...19
    let several = 20...50
    let many = 51...
    
    switch group {
    case (single, _):
        return "\(group.name) has a single person only."
    case (few, _):
        return "\(group.name) has few people."
    case (several, _):
        return "\(group.name) has several people."
    case (many, _):
        return "\(group.name) has many people."
        
    default:
        return "\(group.name) has a number of person beyond our imagination"
    }
}

processGroup(group: group1)
processGroup(group: group2)
processGroup(group: group3)
processGroup(group: group4)


//: In Chapter 15, “Enumerations”, you learned that an optional is an enumeration under the hood. An optional is either .some(value) or .none. You just learned how to extract associated values from optionals.

/*:
 Given the following array of optionals, print the names that are not nil with a for loop:
 
 ```
 let names: [String?] = ["Michelle", nil, "Brandon", "Christine", nil, "David"]
 ```
 */

let names: [String?] = ["Michelle", nil, "Brandon", "Christine", nil, "David"]

for name in names {
    switch name {
    case .some(let name):
        print("\(name)")
    case .none:
        // Do nothing
        break
    }
}
