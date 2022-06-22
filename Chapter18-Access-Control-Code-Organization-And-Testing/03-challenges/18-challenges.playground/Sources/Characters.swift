import Foundation


public enum GameCharacterType {
    case elf, giant, wizard
}

public protocol GameCharacter: AnyObject {
    var name: String { get }
    var hitPoints: Int { get set }
    var attackPoints: Int { get }
}


public struct GameCharacterFactory {
    public static func make(ofType type: GameCharacterType) -> GameCharacter {
        switch type {
        case .elf:
            return Elf(name: "Elf")
        case .giant:
            return Giant(name: "Giant")
        case .wizard:
            return Wizard(name: "Wizard")
        }
    }
}

public func battle(of char1: GameCharacter, and char2: GameCharacter) {
    
    char2.hitPoints -= char1.attackPoints
    
    if char2.hitPoints <= 0 {
        print("\(char2.name) is defeated!")
        return
    }
    
    char1.hitPoints -= char2.attackPoints
    
    if char1.hitPoints <= 0 {
        print("\(char2.name) is defeated!")
    } else {
        print("Both are still alive!")
    }
}

class Elf: GameCharacter {
    var name: String
    var hitPoints: Int = 3
    var attackPoints: Int { 10 }
    
    init(name: String) {
        self.name = name
    }
}

class Wizard: GameCharacter {
    var name: String
    var hitPoints: Int = 5
    var attackPoints: Int { 5 }
    
    init(name: String) {
        self.name = name
    }
}

class Giant: GameCharacter {
    var name: String
    var hitPoints: Int = 10
    var attackPoints: Int { 3 }
    
    init(name: String) {
        self.name = name
    }
}

