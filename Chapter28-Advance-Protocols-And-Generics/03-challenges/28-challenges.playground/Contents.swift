import UIKit

//: ### Challenges



/*: ## Challenge 1: Robot vehicle builder
 Using protocols, define a robot that makes vehicle toys.
 • Each robot can assemble a different number of pieces per minute. For example, Robot-A can assemble ten pieces per minute, while Robot-B can assemble five.
 • Each robot type is only able to build a single type of toy.
 • Each toy type has a price value.
 • Each toy type has a different number of pieces. You tell the robot how long it should operate, and it will provide the finished toys.
 • Add a method to tell the robot how many toys to build. It will build them and say how much time it needed.
 */

protocol VehicleToy {
    static var numberOfPieces: Int { get }
    
    init()
}

protocol RobotBuilder {
    associatedtype ToyType where ToyType: VehicleToy
    var piecesPerMinute: Int { get }
    
    func operate(durationInMinutes: Int) -> [ToyType]
    func operate(newItems: Int) -> (Int, [ToyType])
}

extension RobotBuilder {
    func operate(newItems: Int) -> (Int, [ToyType]) {
        let totalPieces = newItems * ToyType.numberOfPieces
        let operationTime = totalPieces / piecesPerMinute
        
        var newToys: [ToyType] = []
        for _ in 0..<newItems {
            newToys.append(ToyType())
        }
        
        return (operationTime, newToys)
    }
    
    func operate(durationInMinutes: Int) -> [ToyType] {
        let numberOfToys = (durationInMinutes * piecesPerMinute) / ToyType.numberOfPieces
        return operate(newItems: numberOfToys).1
    }
}



/*: ### Challenge 2: Toy train builder
 Declare a function that constructs robots that make toy trains.
 • A train has 75 Pieces.
 • A train robot can assemble 500 pieces per minute.
 • Use an opaque return type to hide the type of robot you return.
 */

struct TrainToy: VehicleToy {
    static var numberOfPieces = 75
}

struct TrainRobot: RobotBuilder {
    typealias ToyType = TrainToy
    var piecesPerMinute = 500
}

func makeToyBuilder() -> some RobotBuilder {
    TrainRobot()
}


/*: ### Challenge 3: Monster truck toy
 Create a monster truck toy that has 120 pieces and a robot to make this toy. The robot is less sophisticated and can only assemble 200 pieces per minute. Next, change the makeToyBuilder() function to return this new robot.
 */

struct MonsterTruckToy: VehicleToy {
    static var numberOfPieces: Int = 120
}

struct MonsterTruckRobot: RobotBuilder {
    typealias ToyType = MonsterTruckToy
    var piecesPerMinute: Int = 200
}

func makeToyBuilderV2() -> some RobotBuilder {
    MonsterTruckRobot()
}

makeToyBuilderV2()

/*: ### Challenge 4: Shop robot
 Define a shop that uses a robot to make the toy that this shop will sell.
 • This shop should have two inventories: a display and a warehouse.
 • There’s a limit to the number of items on display, but there’s no limit on the warehouse’s size.
 • In the morning of every day, the warehouse fills its display.
 • Each customer buys an average of 1.5 toys.
 • If the shop needs the robot, rent the robot and operate it for the duration required.
 • To reduce the operations’ running costs, the robot is set to only work when the warehouse contents are less than the display’s size. The robot should produce enough toys so that the inventory is twice the size of the display.
 • The shop has a startDay(numberOfVisitors: Int) method. This method will first fill the display from the inventory, then sell items from the display based on the number of customers and finally produce new toys, if needed.
 */

class Shop {
    var displayList: [VehicleToy] = []
    var warehouseList: [VehicleToy] = []
    let displaySize = 100
    
    private func fillDisplay() {
        if displayList.count < displaySize {
            var difference = displaySize - displayList.count
            if difference > warehouseList.count {
                difference = warehouseList.count
            }
            
            let itemsToAdd = warehouseList[0..<difference]
            displayList.append(contentsOf: itemsToAdd)
            warehouseList.removeFirst(difference)
        }
    }
    
    private func shipToys(count: Int) -> Int {
        let actualSales = count > displayList.count ? displayList.count : count
        displayList.removeFirst(actualSales)
        
        return actualSales
    }
    
    func startDay(numberOfVisitors: Int) {
        
        fillDisplay()
        
        let potentialSales = Double(numberOfVisitors) * 1.5
        let actualSales = shipToys(count: Int(potentialSales))
        
        print("Potential sales today were: \(potentialSales)")
        print("Actual sales today were: \(actualSales)")
        
        print("Current warehouse has \(warehouseList.count) items")
        print("Current display has \(displayList.count) items")
        
        if warehouseList.count < displaySize {
            let itemsToConstruct = (displaySize * 2) - warehouseList.count
            let robot = makeToyBuilder()
            let (operationalDuration, newItems) = robot.operate(newItems: itemsToConstruct)
            
            warehouseList.append(contentsOf: newItems)
            
            print("Robot was rented today and operated for: \(operationalDuration) minutes")
        } else {
            print("Robot was not needed today")
        }
        print("-------- End of Day --------")
    }
}


let shop = Shop()
shop.startDay(numberOfVisitors: 50)
shop.startDay(numberOfVisitors: 100)
shop.startDay(numberOfVisitors: 10)
shop.startDay(numberOfVisitors: 5)
