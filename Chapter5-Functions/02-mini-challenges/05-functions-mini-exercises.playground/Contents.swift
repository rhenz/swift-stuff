import UIKit


//: 1. Write a function named printFullName that takes two strings called firstName and lastName. The function should print out the full name defined as firstName + " " + lastName. Use it to print out your own full name.
func printFullName(firstName: String, lastName: String) {
    print(firstName + " " + lastName)
}
printFullName(firstName: "John", lastName: "Lucas")

//: 2. Change the declaration of printFullName to have no external name for either parameter.
func printFullName(_ firstName: String, _ lastName: String) {
    print(firstName + " " + lastName)
}
printFullName("John", "Lucas")

//: 3. Write a function named calculateFullName that returns the full name as a string. Use it to store your own full name in a constant.
func calculateFullName() -> String {
    "John Lucas"
}
let fullName: String = calculateFullName()

//: 4. Change calculateFullName to return a tuple containing both the full name and the length of the name. You can find a string’s length by using the count property. Use this function to determine the length of your own full name.
func calculateFullName() -> (fullName: String, nameCharactersCount: Int) {
    ("John Lucas", "John Lucas".count)
}
let (fullNameStr, count) = calculateFullName()
print(fullNameStr, count, separator: "\n")
