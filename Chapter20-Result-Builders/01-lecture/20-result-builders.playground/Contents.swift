import UIKit
import Foundation

/*: ### Result Builders
 
 Result builders first appeared on the scene as a feature of Apple's SwiftUI, letting you declared your user interface in a compact, easy to read way. It was expanded as a general language feature that lets you build values by combining a sequence of expression. Using result builders to define things like HTML documents and database schemas could become commonplace in the future.
 */


//: Meet NSAttributed String

//func greet(name: String) -> NSAttributedString {
//    let message = NSAttributedString(string: "Hello " + name)
//    return message
//}

//greet(name: "Daenarys Targaryen")


//: Adding Color

//func greet(name: String) -> NSAttributedString {
//    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//    let message = NSAttributedString(string: "Hello " + name, attributes: attributes)
//    return message
//}
//
//
//greet(name: "Daenarys Targaryen")

//: Adding color to specific string

//func greet(name: String) -> NSAttributedString {
//    let message = NSMutableAttributedString()
//    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//    message.append(NSAttributedString(string: "Hello "))
//    message.append(NSAttributedString(string: name, attributes: attributes))
//    return message
//}


//greet(name: "Daenarys Targaryen")

//: Adding another attributed string
func greet(name: String) -> NSAttributedString {
    let message = NSMutableAttributedString()
    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    message.append(NSAttributedString(string: "Hello "))
    message.append(NSAttributedString(string: name, attributes: attributes))
    
    let attributes2 = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
        NSAttributedString.Key.foregroundColor: UIColor.blue
    ]
    message.append(NSAttributedString(string: ", Mother of Dragons", attributes: attributes2))
    return message
}

greet(name: "Daenarys Targaryen")


//: Creating a result builder

//@resultBuilder
//enum AttributedStringBuilder {
//    static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
//        let attributedString = NSMutableAttributedString()
//        for component in components {
//            attributedString.append(component)
//        }
//        return attributedString
//    }
//}


//: Building string using result builder
//@AttributedStringBuilder
//func greetBuilder(name: String) -> NSAttributedString {
//    NSMutableAttributedString(string: "Hello ")
//    NSMutableAttributedString(string: name)
//    NSMutableAttributedString(string: ", Mother of Dragons")
//}
//
//greetBuilder(name: "Daenarys")
//: Improving readability by using extensions and type aliases


enum SpecialCharacters {
    case lineBreak
    case comma
}

@resultBuilder
enum AttributedStringBuilder {
    static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        for component in components {
            attributedString.append(component)
        }
        return attributedString
    }
    
    static func buildOptional(_ component: NSAttributedString?) -> NSAttributedString {
        component ?? NSAttributedString()
    }
    
    static func buildEither(first component: NSAttributedString) -> NSAttributedString {
        component
    }
    
    static func buildEither(second component: NSAttributedString) -> NSAttributedString {
        component
    }
    
    static func buildArray(_ components: [NSAttributedString]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        for component in components {
            attributedString.append(component)
        }
        return attributedString
    }
    
    static func buildExpression(_ expression: SpecialCharacters) -> NSAttributedString {
        switch expression {
        case .lineBreak:
            return Text("\n")
        case .comma:
            return Text(",")
        }
    }
    
    static func buildExpression(_ expression: NSAttributedString) -> NSAttributedString {
        expression
    }
}

extension NSMutableAttributedString {
    public func color(_ color: UIColor) -> NSMutableAttributedString {
        self.addAttribute(NSAttributedString.Key.foregroundColor,
                          value: color,
                          range: NSRange(location: 0, length: self.length)
        )
        return self
    }
    
    public func font(_ font: UIFont) -> NSMutableAttributedString {
        self.addAttribute(NSAttributedString.Key.font,
                          value: font,
                          range: NSRange(location: 0, length: self.length)
        )
        return self
    }
}

//@AttributedStringBuilder
//func greetBuilder(name: String, title: String) -> NSAttributedString {
//    NSMutableAttributedString(string: "Hello ")
//    NSMutableAttributedString(string: name)
//        .color(.red)
//    NSMutableAttributedString(string: ", ")
//    NSMutableAttributedString(string: title)
//        .font(.systemFont(ofSize: 20))
//        .color(.blue)
//}

greetBuilder(name: "Naruto Uzumaki", titles: ["The 7th Hokage"])

greetBuilder(name: "Naruto Uzumaki", titles: [""])

//: Using typealias
typealias Text = NSMutableAttributedString
@AttributedStringBuilder
func greetBuilder(name: String, titles: [String]) -> NSAttributedString {
    Text("Hello ")
    Text(name)
        .color(.red)
    if !titles.isEmpty {
        for title in titles {
            Text(", ")
            Text("\n")
            Text(title)
                .font(.systemFont(ofSize: 20))
                .color(.blue)
        }
    } else {
        Text(", No title")
    }
}

extension NSMutableAttributedString {
    convenience init(_ string: String) {
        self.init(string: string)
    }
}

let titles = ["Khaleesi",
              "Mhysa",
              "First of Her Name",
              "Silver Lady",
              "The Mother of Dragons"]
greetBuilder(name: "Daenerys", titles: titles)


//: Using conditional logic

