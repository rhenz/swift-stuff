import Foundation

// MARK: - Checking Account
public class CheckingAccount: BasicAccount {
    
    // MARK: - Properties
    
    private let accountNumber = UUID().uuidString
    
    private var issuedChecks: [Int] = []
    private var currentCheck = 1
    
    // MARK: - Init
    
    public override init() { }
    
    // MARK: - Methods
    
    public func writeCheck(amount: Currency) -> Check? {
        guard balance > amount else {
            return nil
        }
        
        let check = Check(amount: amount, from: self)
        withdraw(amount: check.amount)
        return check
    }
    
    public func deposit(_ check: Check) {
        guard !check.cashed else {
            return
        }
        
        deposit(amount: check.amount)
        check.cash()
    }
    
    // MARK: - Check
    
    public class Check {
        
        // MARK: - Properties
        
        let account: String
        let amount: Currency
        private(set) var cashed = false
        
        // MARK: - Methods
        
        func cash() {
            cashed = true
        }
        
        fileprivate init(amount: Currency, from account: CheckingAccount) {
            self.amount = amount
            self.account = account.accountNumber
        }
    }
}

// MARK: -

private extension CheckingAccount {
    func inspectForFraud(with checkNumber: Int) -> Bool {
        issuedChecks.contains(checkNumber)
    }
    
    func nextNumber() -> Int {
        let next = currentCheck
        currentCheck += 1
        return next
    }
}

// This extensions is marked private. A private extension implicitly denotes all of its members as private. These fraud protection tools are features of CheckingAccount only - you don't want other code incrementing the currentCheck number. Plus putting these two methods together also connects two related, cohesive methods. It's clear to yourself and anyone else maintaining the code that these two are cohesive and help sove a common task




