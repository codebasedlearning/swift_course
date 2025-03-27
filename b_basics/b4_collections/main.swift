// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import Foundation


/// print function intro
func introduce(topic: String) { print("\n\n\(topic)\n\(String(repeating: "=", count: topic.count))\n") }


/**
 In general, you need to know the basic collection types, their most common operations, and their complexity. We start with arrays.
 
 Arrays are similar to C++ vectors or Java ArrayList. They manage dynamic memory, can grow or shrink. The 'let' just makes it read-only, but under the hood it is such a structure.
 */
func usingArrays() {
    introduce(topic: "Arrays")
    
    var numbers = [1, 2, 3, 4, 5]
    print(" 1| array: \(numbers)")
    
    numbers.append(6)
    numbers.insert(0, at: 0)
    print(" 2| insert: \(numbers)")
    
    print(" 3| first: \(numbers.first!), last: \(numbers.last!)")

    numbers.removeLast()
    numbers.remove(at: 0)
    print(" 4| removed: \(numbers)")
    
    if let index = numbers.firstIndex(of: 3) {
        print(" 5| index of 3: \(index)")
    }

    print(" 6| one by one:", terminator: "")
    for number in numbers {
        print(" \(number)", terminator: "")
    }
    print()

    print(" 7| using indices:", terminator: "")
    for i in numbers.indices {
        print(" \(numbers[i])", terminator: "")
    }
    print()
    
    print(" 8| by index:", terminator: "")
    for i in 0..<numbers.count {
        print(" \(numbers[i])", terminator: "")
    }
    print()

    print(" 9| combined: \(numbers + [7, 8, 9])")

    print("10| even: \(numbers.filter { $0 % 2 == 0 })")

    print("11| squared: \(numbers.map { $0 * $0 })")            // new array

    print("12| sum: \(numbers.reduce(0, +))")                   // apply op to elements pairwise, repeat

    print("13| sorted: \(numbers.sorted { $0>$1 })")            // sort
    
    // preview generics
    let reals: Array<Double>
    reals = [0, 1.1, 2.2]
    print("14| reals: \(reals)")
}


/**
 Same for sets. Remember, that an element only exists once.
 
 Excluded
  - set functions set1.op(set2): union, intersection, subtracting, symmetricDifference
 */
func usingSets() {
    introduce(topic: "Sets")
        
    var primes: Set = [2, 3, 5, 7]
    print(" 1| set: \(primes)")
    
    primes.insert(5)
    primes.insert(11)
    print(" 2| insert: \(primes)")

    primes.remove(2)
    print(" 3| remove: \(primes)")
    
    if primes.contains(3) {
        print(" 4| 3 is prime")
    }

    print(" 5| one by one:", terminator: "")
    for number in primes {
        print(" \(number)", terminator: "")
    }
    print()
}


/**
 And again for dictionaries.
 */
func usingDictionaries() {
    introduce(topic: "Dictionaries")
    
    var codes = ["US": "United States", "FR": "France", "JP": "Japan"]
    print(" 1| dictionary: \(codes)")
    
    codes["GB"] = "United Kingdom"          // new element
    codes["US"] = "USA"                     // new value
    print(" 2| add or update: \(codes)")
    
    codes["JP"] = nil
    print(" 3| removed: \(codes)")
    
    if let name = codes["FR"] {
        print(" 4| found FR: \(name)")
    }

    print(" 5| one by one:", terminator: "")
    for (short, country) in codes {
        print(" \(short): \(country)", terminator: "")
    }
    print()

    let shorts = Array(codes.keys)
    let countries = Array(codes.values)
    print(" 6| shorts: \(shorts)")
    print("    countries: \(countries)")

    print(" 7| filtered: \(codes.filter { $0.key < "K" })")
}

usingArrays()
usingSets()
usingDictionaries()
