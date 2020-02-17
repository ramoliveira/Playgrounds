import Foundation
import PlaygroundSupport

class Animal {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

class Human: Animal {
    func code() {
        print("Typing away...")
    }
}

class Fish: Animal {
    func breatheUnderWater() {
        print("Breathing under water.")
    }
}

let ramon = Human("Ramon")
let jack = Human("Jack Black")
let nemo = Fish("Nemo")

let neighbours = [ramon, jack, nemo]
let neighbour1 = neighbours.first

// IS is used for typed checking
if let neighbour = neighbours.first {
    if neighbour is Human {
        print("First neighbour is a Human")
    }
}

func findNemo(from animals: [Animal]) {
    for animal in animals {
        if animal is Fish {
            print(animal.name)
            // Force downcasting
            let fish = animal as! Fish
            fish.breatheUnderWater()
        }
    }
}

findNemo(from: neighbours)

/*
    Forced Downcast
    father to son
    In this case: Animal to Fish
 */

// But there is a problem

//let fish = neighbours[1] as! Fish // No warnings before compiling

/*
    After compiling:
    Could not cast value of type '__lldb_expr_13.Human' (0x12ed83188) to '__lldb_expr_13.Fish' (0x12ed83240). */

// Let's turn this fish in an optional

let fishTryAgain = neighbours[1] as? Fish
fishTryAgain?.breatheUnderWater()

// OR

if let fishTA = neighbours[1] as? Fish {
    fishTA.breatheUnderWater()
}

// UpCast

// Always works!

let fishUpCast = neighbours[2] as Animal

let number = 2

let any: [Any] = [ramon, jack, nemo, number]

let any2: [AnyObject] = [ramon, jack, nemo]

PlaygroundPage.current.finishExecution()
