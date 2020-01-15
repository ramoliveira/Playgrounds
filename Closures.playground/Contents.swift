import UIKit
import PlaygroundSupport

//MARK: - Introduction

func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
}

func add(no1: Int, no2: Int) -> Int {
    return no1 + no2
}

func multiply(no1: Int, no2: Int) -> Int {
    return no1 * no2
}

// The simpler way to call the function as a parameter

calculator(n1: 2, n2: 3, operation: add(no1:no2:))
calculator(n1: 3, n2: 4, operation: multiply(no1:no2:))

// OR, shorter caller of the function

calculator(n1: 2, n2: 3, operation: add)
calculator(n1: 3, n2: 4, operation: multiply)

// Using as it was like a completion handler

calculator(n1: 4, n2: 5) { (no1: Int, no2: Int) -> Int in
    return no1 * no2
}

// Without specifies parameter's type

calculator(n1: 5, n2: 6) { (no1, no2) -> Int in
    return no1 * no2
}

// Without specifies parameter's type AND return's type

calculator(n1: 6, n2: 7) { (no1, no2) in
    return no1 * no2
}

// Without return statement AND do not specifies parameter's type AND return's type

calculator(n1: 7, n2: 8) { (no1, no2) in
    no1 * no2
}

// OR, shorter version, all written in 1 line of code

calculator(n1: 8, n2: 9) { (no1, no2) in no1 * no2}

// Annonymous Parameter Names

calculator(n1: 10, n2: 11) {$0 * $1}

//MARK: - Why does it matters?

// So, do you want to add 1 to every single number in the array
var array = [6, 2, 7, 8, 1, 3, 4, 5]

// The common way is: do a for-loop
for i in 0..<array.count {
    array[i] += 1
}

print("Array: \(array)")

// Through map function
array = [6, 2, 7, 8, 1, 3, 4, 5]

print("Array: \(array.map {$0 + 1})")

// Passing a function as a parameter to the map function
func addOne(no1: Int) -> Int {
    return no1 + 1
}

print("Array: \(array.map(addOne(no1:)))")

// Turning the Int array into a String array

let newArray = array.map {"\($0)"}

print("New Array: \(newArray)")

PlaygroundPage.current.finishExecution()
