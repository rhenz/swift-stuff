import UIKit

//: ### Memory Management
//: Swift's memory management works out of the box with little to no effort from us. Swift uses ARC(Automatic Reference Counting) for memory management. However, there are cases when ARC can't infer the proper relationship between objects and that's where we need to jump in.



//: ### Reference cycle for classes
//: Two class instances that hold a `strong reference` to eaach other will create a `strong reference cycle` that leads to `memory leak`. Because each instance keeps the other one alive and the reference counts never reaches zero.


//class Tutorial {
//    let title: String
//    var editor: Editor?
//
//    init(title: String) {
//        self.title = title
//    }
//
//    deinit {
//        print("Goodbye tutorial \(title)!")
//    }
//}

class Editor {
    let name: String
    var tutorials: [Tutorial] = []
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Goodbye editor \(name)")
    }
}


//do {
//    let tutorial = Tutorial(title: "Memory management")
//    let editor = Editor(name: "Lucas")
//
//    tutorial.editor = editor
//    editor.tutorials.append(tutorial)
//}


// although both objects go out of scope, deinitializers aren't called, and nothing prints to the console.. That's because we've created a `reference cycle` between the tutorial and its corresponding editor. We never release the objects from the memory even though we don't need them anymore.

// now we know how reference cycle happens, let's break them. `weak references` to the rescue!



//: ### Weak references
//: `Weak references` are reference that don't play any role in the ownership of an object. The great thing about using them is that they automatically detect when the underlying object has gone away. This automatic detection is why we always declare them with an optional type. They become `nil` once the reference count becomes zero.


// In our example, a `tutorial` does not always have an editor assigned, so it makes sense to model it as an optional type. Also, a tutorial doesn't own the editor, so it makes perfect sense to make it a weak reference.


//class Tutorial {
//    let title: String
//    weak var editor: Editor?
//
//    init(title: String) {
//        self.title = title
//    }
//
//    deinit {
//        print("Goodbye tutorial \(title)!")
//    }
//}

// Take note that we can't define a weak reference a constant because it will change to `nil` during runtime when the object goes away.


//: ### Unowned references
//: We have another way to break reference cycle and that is by using `unowned references`, which behave much like weak ones in that they don't change the object's reference count. However, unlike weak references, they `always` expect to have a value - we can't declare them as optionals.


//class Tutorial {
//    let title: String
//    unowned let author: Author
//    weak var editor: Editor?
//
//    init(title: String, author: Author) {
//        self.title = title
//        self.author = author
//    }
//
//    deinit {
//        print("Goodbye tutorial \(title)!")
//    }
//}


class Author {
    let name: String
    var tutorials: [Tutorial] = []
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Goodbye author \(name)")
    }
}


//do {
//    let author = Author(name: "Chabby")
//    let tutorial = Tutorial(title: "Memory management", author: author)
//    let editor = Editor(name: "Lucas")
//
//    author.tutorials.append(tutorial)
//    tutorial.editor = editor
//    editor.tutorials.append(tutorial)
//}


//: ### Reference cycles for closures
//: We learned that closures capture values from the enclosing scope. Because Swift is a safe language, closures extend the lifetime of any object they use to guarantee those objects are alive and valid. This is automatic safety is convenient, but the downside of this is we can accidentally create a `reference cycle` if we extend the lifetime of an object that itself captures the closure. Remember that `Closures` are reference types!

//class Tutorial {
//    let title: String
//    unowned let author: Author
//    weak var editor: Editor?
//
//    lazy var description: () -> String = {
//        "\(self.title) by \(self.author.name)"
//    }
//
//    init(title: String, author: Author) {
//        self.title = title
//        self.author = author
//    }
//
//    deinit {
//        print("Goodbye tutorial \(title)!")
//    }
//}



// We created another `strong reference cycle` between the `tutorial` object and the closure by capturing `self, so only the author's deinit method runs.

// We need to know and use the language feature called `capture list` to break this reference cycle.
//do {
//    let author = Author(name: "Chabby")
//    let tutorial = Tutorial(title: "Memory management", author: author)
//    print(tutorial.description())
//
//    let editor = Editor(name: "Lucas")
//
//    author.tutorials.append(tutorial)
//    tutorial.editor = editor
//    editor.tutorials.append(tutorial)
//}


//: ### Escaping closures
//: All of the closures we uses were `non-escaping`. Closure parameters are by default non-escaping because they are assumed not to be used after the function returns.

final class FunctionKeeper {
    private let function: () -> Void
    
    init(function: @escaping () -> Void) {
        self.function = function
    }
    
    func run() {
        function()
    }
    
    deinit {
        print("Function keeper is deinitialized")
    }
}

// What happens here is that the stored property `function` keeps a reference to a closure. We pass a closure on initialization. Because it is going to put it into a stored property and keep using it after init(function:) returns, it must be marked as @escaping.. The `run()` method executes the `function` stored property.


let name = "Lucas"
var f = FunctionKeeper {
    print("Hello, \(name)")
}

f.run()

// This creates a FunctionKeeper object and prints "Hello, Lucas". The escaping closure extends the lifetime of the name variable by capturing it so it's available when `run()` executes.


//: ### Capture lists
//: `Capture lists` are a language feature to help us control exactly how a closure extends a lifetime of instances it references. Capture lists are lists of variables captured by a closure and appear at the beginning of the closure before any arguments

var counter = 0
var g = {
    print(counter)
}
counter = 1
g()

counter = 0
g = {[c = counter] in
    print(c)
}
counter = 1
g()


counter = 0
g = {[counter] in
    print(counter)
}
counter = 1
g()


// The `g()` closure also prints 0 in this case because `counter` is a shadowed copy.

// When dealing with objects, remember that `constant` has a different meaning for reference types. A capture list will cause the closure to capture and store the current `reference` stored inside the capture variable with reference types. Changes made to the object through this reference will still be visible outside of the closure.


//: ### Unowned self
//: The closure that determines the tutorial's description captures a strong reference of `self` and creates a reference cycle. Since the closure doesn't exist after releasing the `tutorial` object from memory, self will never be nil, so we can change the strong reference to an unowned one using capture list

//class Tutorial {
//    let title: String
//    unowned let author: Author
//    weak var editor: Editor?
//
//    lazy var description: () -> String = { [unowned self] in
//        "\(self.title) by \(self.author.name)"
//    }
//
//    init(title: String, author: Author) {
//        self.title = title
//        self.author = author
//    }
//
//    deinit {
//        print("Goodbye tutorial \(title)!")
//    }
//}

// Capturing `self` as unowned makes `self` a weak reference. So the closure won't hold a strong reference to captured `self` and  that `self` will get deallocated which in this example is the `Tutorial` object. No more reference cycle! Personally, I don't use unowned as it may potentially crash our app if we aren't sure that the instance we declare unowned will always be available for the whole lifespan of its owner, so I use `weak capturing` always just to be safe. The only tradeoff for that is that captured object becomes optional type and we can always handle that inside that closure if we don't want those "?" question marks or optional handlings

do {
    let author = Author(name: "Chabby")
    let tutorial = Tutorial(title: "Memory management", author: author)
    print(tutorial.description())
    
    let editor = Editor(name: "Lucas")
    
    author.tutorials.append(tutorial)
    tutorial.editor = editor
    editor.tutorials.append(tutorial)
}


//: ### Weak self
//: Here comes the weak capturing. There are times when we can't capture `self` or any instance as unowned reference, because it might become nil.


let tutorialDescription: () -> String
do {
    let author = Author(name: "Cosmin")
    let tutorial = Tutorial(title: "Memory management",
                            author: author)
    tutorialDescription = tutorial.description
}
print(tutorialDescription())

// The above code crashes our playground because we deallocate tutorial and author at the end of the do statement. Let's change unowned to weak in the capture list of description

//class Tutorial {
//    let title: String
//    unowned let author: Author
//    weak var editor: Editor?
//
//    lazy var description: () -> String = { [weak self] in
//        "\(self?.title) by \(self?.author.name)"
//    }
//
//    init(title: String, author: Author) {
//        self.title = title
//        self.author = author
//    }
//
//    deinit {
//        print("Goodbye tutorial \(title)!")
//    }
//}

// Now the code will produce "nil by nil"

// [weak self] means that the closrue will not extend the lifetime of self. If the underlying object representing self goes away, it gets set to nil. The code doesn't crash anymore but does generate a warning which we can fix.


//: ### The weak-strong pattern
//: The `weak-strong pattern` also does not extend the lifetime of `self` but converts the weak reference to a strong one after it enters the closure

class Tutorial {
    let title: String
    unowned let author: Author
    weak var editor: Editor?
    
    lazy var description: () -> String = { [weak self] in
        guard let self = self else {
            return "The tutorial is no longer available"
        }
        return "\(self.title) by \(self.author.name)"
    }
    
    init(title: String, author: Author) {
        self.title = title
        self.author = author
    }
    
    deinit {
        print("Goodbye tutorial \(title)!")
    }
}

// Guard makes `self` strong if it is not nil, so it's guaranteed to live until the end of the closure. We print a suitable message if `self` is nil this time, and the previous warning is gone.
