import UIKit

//: ### Encoding & Decoding Types

//: Converting types to a stream of bytes ready to be transported, this process is call `encoding`, also known as `serialization`

//: The reverse process of turning data into an instance is called `decoding`, also known as `deserialization`



// Imagine we have an instance we want to write to a file. The instance itself cannot be written as-is to the file, so we need to encode it into another representation such as a stream of bites

// Employee Type --> Encoder() --> <....aasdiw22da...>


// Once the data is encoded and saved to a file, we can turn it back into an instance whenever we want by using a `decoder`

// <....aasdiw22da...> --> Decoder() -> Employee Type



//: ### Encodable and Decodable protocols

/*: The `Encodable` protocol expresses that a type can convert itself into another representation. It declares a single method

 ```
 func encode(to: Encoder) throws
 ```
 
 
 The compiler automatically generates this for us if all the stored properties of a particular type conform to `Encodable`
 
 The `Decodable` protocol express that a type can create itself from another representation. It declares just a single initializer
 
 ```
 init(from decoder: Decoder) throws
 ```
 
 Again, the compiler will make this initializer for us if all stored properties conform to `Decodable`.
 */



//: ### What is Codable?

/*: `Codable` is a protocol that a type can conform to, which means it can be encoded and decoded. It's an alias for the `Encodable` and `Decodable` protocols
 
 ```
 typealias Codable = Encodable & Decodable
 ```

*/


//: ### Automatic encoding and decoding
//: Many of Swift's standard types are codable out of the box. Int, String, Date, Array and many other types. If you want your own type to be `codable`, the simplest way to do it is by conforming to `Codable` protocol and ensuring that all of its properties are also codable

//struct Employee: Codable {
//    var name: String
//    var id: Int
//    var favoriteToy: Toy?
//}
//
//struct Toy: Codable {
//    var name: String
//}


//: ### Encoding and decoding custom types
// We can encode to or decode from several representations, such as XML or a Property List and of course JSON.



//: ### JSONEncoder and JSONDecoder

let toy = Toy(name: "Teddy Bear")
let employee1 = Employee(name: "John Lucas", id: 1, favoriteToy: toy)


// Let's say Lucas' birthday is coming up, and we want to give him his favorite toy as a gift. We need to send this data to the Gift Department. Before we can do that, we need to encode it like:

let jsonEncoder = JSONEncoder()
let jsonData = try jsonEncoder.encode(employee1)

print(jsonData)

// You'll see that Xcode omits the data and only provides the number of bytes in jsonData.

// If we want to create a readable version of this JSON as a string, we can use the String initializer:

//let jsonString = String(data: jsonData, encoding: .utf8)!
//print(jsonString)

// Now we can send jsonData or jsonString over to the Gift Department using their own special gift API

// If we want to decode the JSON data back into an instance, we need to use JSONDecoder
//let jsonDecoder = JSONDecoder()
//let employee2 = try jsonDecoder.decode(Employee.self, from: jsonData)

//: ### Renaming properties with CodingKeys
// Let's say that the gift department API requires that the employee ID appear as employeeId instead of id. Luckily, Swift provides a solution to this kind of problem

//: ### CodingKey protocol and CodingKeys enum
// The `CodingKeys` enum, which conform to `CodingKey` protocol, lets us rename specific properties if the serialized format doesn't match the API requirements


//struct Employee: Codable {
//    var name: String
//    var id: Int
//    var favoriteToy: Toy?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "employeeId"
//        case name
//        case favoriteToy
//    }
//}

struct Toy: Codable {
    var name: String
}

// By default, the compiler creates this enumeration, but when we need to rename a key, we need to implement it ourselves.


//: ### Manual encoding and decoding
// e.g. We try to send the data over to the Gift Department, and again the data gets rejected. This time they claim that the information of the gift you want to send to the employee should not be inside a nested type, but rather as a property called `gift`. So the JSON should look like this
//  { "employeeId": 7, "name": "John Appleseed", "gift": "Teddy Bear" }

// In this case, we can't use `CodingKeys` since we need to alter the structure of the JSON and not just rename properties. We need to write our own encoding and decoding logic.

//: ### The encode function
// It might sound complicated, but it's pretty simple. First, update the `CodingKeys` to use the key `gift` instead of `favoriteToy`

// First is we need to update the `CodingKeys` to use the key `gift` instead of `favoriteToy`:

// Then we need to remove Employee's conformance to `Codable` protocol
struct Employee {
    var name: String
    var id: Int
    var favoriteToy: Toy?
    
    enum CodingKeys: String, CodingKey {
        case id = "employeeId"
        case name
        case gift // update
    }
}

// and add an extension that will conform to `Encodable` and implement the `encode(to:) throws` function

//extension Employee: Encodable {
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(id, forKey: .id)
//        try container.encode(favoriteToy?.name, forKey: .gift)
//    }
//}

// First, we get the `container` of the encoder back, giving us a view into the encoder's storage that we can access with keys. Note how we choose which properties to encode for which keys. Importantly, we flatten `favoriteToy?.name` down to the `.gift` key. We will get the following error for now
// 'Employee' does not conform to expected type 'Decodable'
// That is become we have a code above that decodes the jsonData into Employee instance again.


// If we try to print the jsonSTring again, this is what we will get now.
//let jsonString = String(data: jsonData, encoding: .utf8)!
//print(jsonString)

//: ### The decode function

// Once the data arrives at the gift department, it needs to be converted to an instance in the department's system. Clearly, the gift department needs a decoder.

//extension Employee: Decodable {
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decode(String.self, forKey: .name)
//        id = try values.decode(Int.self, forKey: .id)
//
//        if let gift = try values.decode(String?.self, forKey: .gift) {
//            favoriteToy = Toy(name: gift)
//        }
//    }
//}

// ### encodeIfPresent and decodeIfPresent
// It turns out not all employees have a favorite toy. In this case, the encode method could create a JSON that has a null value
// {"name":"John Appleseed","gift":null,"employeeId":7}

// In order to fix this, we can use `encodeIfPresent` so the encode method will look like:

extension Employee: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(favoriteToy?.name, forKey: .gift)
    }
}
let employee2 = Employee(name: "Chabby", id: 2, favoriteToy: nil)
let jsonData2 = try! JSONEncoder().encode(employee2)

let jsonString2 = String(data: jsonData2, encoding: .utf8)!
print(jsonString2)

// Now the JSON won't contain `gift` key if the employee does not have a favorite toy.

// Next update the decoder using decodeIfPresent

extension Employee: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
        
        if let gift = try values.decodeIfPresent(String.self, forKey: .gift) {
            favoriteToy = Toy(name: gift)
        }
    }
}


let decodedJsonData = try? JSONDecoder().decode(Employee.self, from: jsonData2)
print(decodedJsonData as Any)




