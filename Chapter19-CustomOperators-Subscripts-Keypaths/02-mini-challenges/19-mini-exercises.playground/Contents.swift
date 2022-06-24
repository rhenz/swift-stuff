import UIKit


//: ### Mini-exercises

/*: 1. Implement a custom multiplication operator for strings so that the following code works:
 
 ```
let baseString = "abc"
let times = 5
var multipliedString = baseString ** times
 ```
*/


infix operator **

func **(baseString: String, times: Int) -> String {
    precondition(times > 0)
    var result = ""
    
    for _ in 1...times {
        result += baseString
    }
    
    return result
}

let baseString = "abc"
let times = 5
var multipliedString = baseString ** times

/*: 2. Implement the corresponding multiplication assignment operator so that the following code runs without errors:
 
 multipliedString **= times
*/
infix operator **=
func **=(lhs: inout String, rhs: Int) {
    precondition(times > 0)
    lhs = lhs ** rhs
}

multipliedString **= times
multipliedString
