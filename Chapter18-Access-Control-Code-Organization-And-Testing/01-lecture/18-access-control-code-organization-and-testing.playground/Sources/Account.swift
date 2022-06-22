import Foundation

// MARK: -

public protocol Account {
    
    // MARK: - Properties
    
    associatedtype Currency
    var balance: Currency { get }
    
    // MARK: - Methods
    
    func deposit(amount: Currency)
    func withdraw(amount: Currency)
}



// MARK: -

public typealias Currency = Double
open class BasicAccount: Account {
    
    // MARK: - Properties
    
    public private(set) var balance: Currency = 0.0
    
    // MARK: - Init
    
    public init() { }
    
    // MARK: - Methods
    
    public func deposit(amount: Currency) {
        balance += amount
    }
    
    public func withdraw(amount: Currency) {
        if amount <= balance {
            balance -= amount
        } else {
            print("Insufficient balance")
        }
    }
}
