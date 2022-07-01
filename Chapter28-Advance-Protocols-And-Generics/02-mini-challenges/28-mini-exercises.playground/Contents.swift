import UIKit


/*: ### Mini-exercises
 Here’s a little challenge for you. Try to see if you can do the following two things:
 1. Instead of supplying the factory with production lines through the property
 productionLines, the factory can increase its production lines.
 
 2. Instead of the factory creating the products and doing nothing with them, the
 factory should store the items in a warehouse instead.
 */
protocol Product {
    init()
}

protocol ProductionLine {
    associatedtype ProductType
    func produce() -> ProductType
}

protocol Factory {
    associatedtype ProductType
    var warehouse: [ProductType] { get }
    
    func produce()
    func addProductionLine()
}

struct GenericProductionLine<P: Product>: ProductionLine {
    func produce() -> P {
        P()
    }
}

class GenericFactory<P: Product>: Factory {
    var warehouse: [P] = []
    private var productionLines: [GenericProductionLine<P>] = []
    
    func produce() {
        var newItems: [P] = []
        productionLines.forEach { newItems.append($0.produce()) }
        print("Finished Production")
        print("-------------------")
        warehouse.append(contentsOf: newItems)
    }
    
    func addProductionLine() {
        productionLines.append(GenericProductionLine<P>())
    }
}

struct Car: Product {
    init() {
        print("Producing one awesome Car 🚘")
    }
}

var carFactory = GenericFactory<Car>()
carFactory.addProductionLine()
carFactory.addProductionLine()
carFactory.addProductionLine()
carFactory.produce()

carFactory.warehouse.count
carFactory.produce()

carFactory.warehouse.count
