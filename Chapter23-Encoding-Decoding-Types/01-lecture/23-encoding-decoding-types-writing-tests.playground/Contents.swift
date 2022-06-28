import UIKit
import XCTest


//: ### Writing tests for the Encoder and Decoder

//: If we change our encoder and forget to update the decoder (or vice versa), we might get nasty errors at runtime. To avoid this situation, we can write unit tests to ensure we never break the encoding or decoding logic

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

extension Employee: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(favoriteToy?.name, forKey: .gift)
    }
}

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

struct Toy: Codable {
    var name: String
}


class EncoderDecoderTests: XCTestCase {
    var jsonEncoder: JSONEncoder!
    var jsonDecoder: JSONDecoder!
    
    var toy1: Toy!
    var employee1: Employee!
    
    override func setUpWithError() throws {
        jsonEncoder = JSONEncoder()
        jsonDecoder = JSONDecoder()
        toy1 = Toy(name: "Teddy Bear")
        employee1 = Employee(name: "John Appleseed", id: 7, favoriteToy: toy1)
    }
    
    func test_encoder() {
        let jsonData = try? jsonEncoder.encode(employee1)
        XCTAssertNotNil(jsonData, "Encoding failed")
        let jsonString = String(data: jsonData!, encoding: .utf8)!
        XCTAssertEqual(jsonString, "{\"name\":\"John Appleseed\", \"gift\":\"Teddy Bear\",\"employeeId\":7}")
    }
    
    
    func testDecoder() {
        let jsonData = try! jsonEncoder.encode(employee1)
        let employee2 = try? jsonDecoder.decode(Employee.self, from:
                                                    jsonData)
        
        XCTAssertNotNil(employee2)
        
        XCTAssertEqual(employee1.name, employee2!.name)
        XCTAssertEqual(employee1.id, employee2!.id)
        XCTAssertEqual(employee1.favoriteToy?.name, employee2?.favoriteToy?.name)
    }
}

EncoderDecoderTests.defaultTestSuite.run()
