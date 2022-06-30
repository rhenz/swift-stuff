import UIKit

/*: ### Challenge 1: Create a generic property wrapper for CopyOnWrite
 Consider the property wrapper CopyOnWriteColor, which you defined earlier in this chapter. It lets you wrap any variable of type Color. It manages the sharing of an underlying storage type, Bucket, which owns a single Color instance. Thanks to structural sharing, multiple CopyOnWriteColor instances might share the same Bucket instance — thus sharing its Color instance and saving memory.
 
 To implement the copy-on-write logic, what matters about Bucket is not its domain semantics, like isRefilled, but just that it’s a reference type. You only used it as a box for Color.
 
 Since property wrappers can be generic, try your hand at defining a generic copy- on-write property wrapper type, CopyOnWrite. Instead of being able to wrap only Color values, it should be generic over any value semantic that it wraps. Instead of using a dedicated storage type like Bucket, it should provide its own box type to act as storage.
 
 Your challenge: Write the definition for this generic type, CopyOnWrite, and use it in an example to verify that the wrapped properties preserve the value semantics of the original type.
 */

private class StorageBox<StoredValue> {
    var value: StoredValue
    
    init(_ value: StoredValue) {
        self.value = value
    }
}

@propertyWrapper
struct CopyOnWrite<T> {
    
    private var storage: StorageBox<T>
    
    init(wrappedValue: T) {
        self.storage = StorageBox(wrappedValue)
    }
    
    var wrappedValue: T {
        get {
            print("GET")
            return storage.value
        }
        set {
            if isKnownUniquelyReferenced(&storage) {
                storage.value = newValue
            } else {
                storage = StorageBox(newValue)
            }
        }
    }
}

struct Err {
    @CopyOnWrite var a = 5
}

var x = Err()
var y = x
print(x.a)
print(y.a)

x.a = 10
print(x.a)
print(y.a)

y.a = 20
print(x.a)
print(y.a)
