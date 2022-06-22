import Foundation

public class Logger {
    private init() { }
    
    public static let shared = Logger()
    
    public func log(_ string: String) {
        print(string)
    }
}

