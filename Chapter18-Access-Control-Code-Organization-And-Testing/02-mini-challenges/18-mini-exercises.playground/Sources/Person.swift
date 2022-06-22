import Foundation

public struct Person {
    public private(set) var first: String
    public private(set) var last: String
    
    public var fullName: String {
        "\(first) \(last)"
    }
    
    public init(first: String, last: String) {
        self.first = first
        self.last = last
    }
}

