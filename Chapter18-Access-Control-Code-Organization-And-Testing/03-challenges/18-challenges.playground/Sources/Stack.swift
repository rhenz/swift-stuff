import Foundation

public struct Stack<Element> {
    private var elements: [Element] = []
    
    public var count: Int {
        elements.count
    }
    
    public init() { }
    
    public func peek() -> Element? {
        elements.last
    }
    
    public mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    public mutating func pop() -> Element? {
        if count == 0 {
            return nil
        }
        
        return elements.removeLast()
    }
}


extension Stack: CustomStringConvertible {
    public var description: String {
        """
        ---  top  ----
        \(elements.map { "\($0)" }.reversed().joined(separator: "\n") )
        --- bottom ---
        """
    }
}

