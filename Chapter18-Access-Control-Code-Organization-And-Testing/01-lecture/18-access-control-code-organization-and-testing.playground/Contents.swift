import UIKit
import Foundation
import XCTest

//: ### Access Control, Code Organization and Testing

//: We declare Swift types with properties, methods, initializers and even other nested types. These elements make up the interface or the API(Application Programming Interface)



//: Problems introduced by lack of access control

//protocol Account {
//    associatedtype Currency
//    
//    var balance: Currency { get }
//    
//    func deposit(amount: Currency)
//    func withdraw(amount: Currency)
//}

//class BasicAccount: Account {
//    typealias Currency = Double
//
//    var balance: Currency = 0
//
//    func deposit(amount: Currency) {
//        balance += amount
//    }
//
//    func withdraw(amount: Currency) {
//        if amount <= balance {
//            balance -= amount
//        } else {
//            print("Insufficient balance")
//        }
//
//    }
//}

//: We may notice a slight issue here, the Account protocol defines a `balance` property as read-only, in other words, it only has a get requirement

//: However BasicAccount implements balance as a variable that is both readable and writeable. Now nothing can prevent other code to directly assign new values for `balance` property

let account = BasicAccount()
account.deposit(amount: 20.0)
account.withdraw(amount: 10.0)

// let's do evil things
//account.balance = 1000000.00


// Now here is where the access control shines!

//: ### Introducing access control

//class BasicAccount: Account {
//    typealias Currency = Double
//    
//    private(set) var balance: Currency = 0
//    
//    func deposit(amount: Currency) {
//        balance += amount
//    }
//    
//    func withdraw(amount: Currency) {
//        if amount <= balance {
//            balance -= amount
//        } else {
//            print("Insufficient balance")
//        }
//    }
//}

//: We can add access modifiers in front of a property, method or type declaration
// private(set) means that the setter is private within its scope, anything outside of its scope cannot modify this property

/*:
 Here is the list of access modifiers
 
 - private: Accessible only to the defining type, all nested types and extensions on that type within the same source file.
 
 - fileprivate: Accessible from anywhere within the source file in which it’s defined.
 
 - internal: Accessible from anywhere within the module in which it’s defined. This level is the default access level. If you don’t write anything, this is what you get.
 
 - public: Accessible from anywhere that imports the module.
 
 - open: The same as public, with the additional ability granted to override the code in another module.
 */

//class CheckingAccount: BasicAccount {
//    private let accountNumber = UUID().uuidString
//
//    func writeCheck(amount: Currency) -> Check? {
//        guard balance > amount else {
//            return nil
//        }
//
//        let check = Check(amount: amount, from: self)
//        withdraw(amount: check.amount)
//        return check
//    }
//
//    func deposit(_ check: Check) {
//        guard !check.cashed else {
//            return
//        }
//
//        deposit(amount: check.amount)
//        check.cash()
//    }
//
//    class Check {
//        let account: String
//        let amount: Currency
//        private(set) var cashed = false
//
//        func cash() {
//            cashed = true
//        }
//
//        init(amount: Currency, from account: CheckingAccount) {
//            self.amount = amount
//            self.account = account.accountNumber
//        }
//    }
//}


// Create a checking account for John. Deposit $300.00
let johnChecking = CheckingAccount()
johnChecking.deposit(amount: 300.00)

// Write a check for $200.00
let check = johnChecking.writeCheck(amount: 200.0)!

// Create a checking account for Jane, and deposit the check.
let janeChecking = CheckingAccount()
janeChecking.deposit(check)
janeChecking.balance // 200.00


// Try to cash the check again. Of course, it had no effect on
// Jane’s balance this time :], coz it check was cashed already.
janeChecking.deposit(check)
//janeChecking.deposit(amount: 5)
janeChecking.balance // 200.00

let anotherCheck = janeChecking.writeCheck(amount: 10)!


class SavingsAccount: BasicAccount {
    var interestRate: Double
    private let pin: Int
    
    @available(*, deprecated, message: "Use init(interestRate:pin:) instead")
    init(interestRate: Double) {
        self.interestRate = interestRate
        self.pin = 0
    }
    
    init(interestRate: Double, pin: Int) {
        self.interestRate = interestRate
        self.pin = pin
    }
    
    @available(*, deprecated, message: "Use processInterest(pin:) instead")
    func processInterest() {
        let interest = balance * interestRate
        deposit(amount: interest)
    }
    
    func processInterest(pin: Int) {
        if pin == self.pin {
            let interest = balance * interestRate
            deposit(amount: interest)
        }
    }
}


//: ### Organizing code into extensions
//: Swift features such as access modifiers, when used with `extensions`, can help us organize our code and promote good software design.

//: ### Extensions by behavior
//: An effective strategy in Swift is to organize your code into extensions by BEHAVIOR. You can even apply access modifiers to extensions themselves, which will help you categorize entire code sections as public, internal or private.



//: ### Extension by protocol conformance
//: It's a good practice to organize our extensions based on protocol conformance.

extension CheckingAccount: CustomStringConvertible {
    public var description: String {
        "Checking Balance: $\(balance)"
    }
}


//: ### available()

// We added a new layer of security in our SavingsAccount class. However, after you send this updated code to the bank, you get angry phone calls. The bank's code now doesn't compile because it was using your old SavingAccount class

// To prevent breaking code that uses the old implementation, we need to deprecate the code rather than replacing it. Luckily, Swift has built-in support for this


let sAccount = SavingsAccount(interestRate: 1.04)
sAccount.processInterest()


//: ### Opaque return types
//: Imagine we need to create a public API for users of your banking library. You're required to make a function called createAccount that creates a new account and returns it. One of the requirements of this API is to hide implementation details so that clients are encourage to write generic code. It means that we shouldn't expose the type of account we are creating, be it BasicAccount,CheckingAccount or SavingsAccount. Instead we will return `some` instance that conforms to the protocol `Account`

func createAccount() -> some Account {
    CheckingAccount()
}

let x = createAccount()
print(x)


//: ### Testing

//: Tests should cover the core functionality of our code and some edge cases. The acronym FIRST describes a concise set of criteria for useful unit tests. Those criteria are:
/*:
 - Fast: Test should run quickly
 - Independent/Isolated: Tests should not share state
 - Repeatable: You should obtain the same results every time you run a test.
 - Self-validating: Tests should be fully automated, and the output should be either "pass" or "fail"
 - Timely: Ideally, write tests before writing the code they test (Test-Driven Development)
 */


// Adding tests to a test class is easy, just add a function that starts with the word `test`, takes no arguments and returns nothing
class BankingTests: XCTestCase {
    func test_something() {
        
    }
    
    //: ### XCTAssert
    //: XCTAssert functions ensure your tests meet certain conditions.
    func test_newAccountBalanceIsZero() {
        let checkingAccount = CheckingAccount()
        XCTAssertEqual(checkingAccount.balance, 0)
    }
    
    func test_checkOverBudgetFails() {
        let checkingAccount = CheckingAccount()
        let check = checkingAccount.writeCheck(amount: 100)
        XCTAssertNil(check)
    }
    
    //: XCTFail and XCTSkip
    //: If certain pre-condition isnt met, we can opt to fail the test. For example, suppose we are writing a test to verify an API that's only available on iOS 14 and above. In that case, we can fail the test for iOS Simulators running older versions with an informative message
    
    //    func test_newAPI() {
    //        guard #available(iOS 14, *) else {
    //            XCTFail("Only available in iOS 14 and above")
    //            return
    //        }
    //    }
    
    //: Alternatively, instead of failing the test, we can skip it.
    func testNewAPI() throws {
        guard #available(iOS 14, *) else {
            throw XCTSkip("Only available in iOS 14 and above")
        }
        // perform test
    }
}








BankingTests.defaultTestSuite.run()
