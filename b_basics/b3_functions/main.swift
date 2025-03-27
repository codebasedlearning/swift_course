// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev


/// print function intro
func introduce(topic: String) { print("\n\n\(topic)\n\(String(repeating: "=", count: topic.count))\n") }


/**
 Parameters not only have a name but also a 'label'. This greatly improves readability. Choose your naming so that calling a function with arguments reads like a command or a statement.
 '_' usually stands for: 'not used' (discard). When used as a label, you can call the function without, e.g. sin(3.14).
 */
func usingArgumentLabels() {
    introduce(topic: "Argument Labels")
 
    // local functions
    func twice1(number: Int) -> Int {       //  argument label same as parameter name
        return number+number
    }

    func twice2(of number: Int) -> Int {    //  argument label 'of', parameter name 'number'
        return number+number
    }

    func twice3(_ number: Int) -> Int {     // no argument label
        return number+number
    }

    let n = 23
    let n1 = twice1(number: n)              // 'number' is mandatory
    let n2 = twice2(of: n)                  // 'of' is mandatory
    let n3 = twice3(n)                      // without label (technically you can use '_')
    print(" 1| n=\(n), n1=\(n1), n2=\(n2), n3=\(n3)")
}

/**
 Factory functions with defaults.
 */
func usingDefaultArguments() {
    introduce(topic: "Default Arguments")
    
    // this way params are optional
    func createInt(fromText s: String? = nil,
                   fromNumber d: Double? = nil,
                   withDefault defValue: Int = -1) -> Int {
        
        if let stringValue = s, let intValue = Int(stringValue) {
            return intValue
        } else if let doubleValue = d {
            return Int(doubleValue)
        }
        return defValue
    }
    
    // cmp that to twice
    let m1 = createInt(fromText: "12")
    let m2 = createInt(fromNumber: 3.14)
    let m3 = createInt(fromText: "12a", withDefault: 42)
    print(" 1| m1=\(m1), m2=\(m2), m3=\(m3)")
}

/**
 Functions that accept zero or more values of a certain type — aka, a non-fixed number of arguments.
 */
func usingVariadicParameters() {
    introduce(topic: "Variadic Parameters")
    
    // Type... (variadic parameters)
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total = 0.0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }

    let mean = arithmeticMean(1, 2, 3, 4, 5)
    print(" 1| mean=\(mean)")
}


/**
 Working with functions as entities.
 
 Excluded
  - in-out params
  - capture self in classes
  - lazy evaluation, @autoclosure
 */
func usingFunctions() {
    introduce(topic: "Functions")
  
    func myAdd(_ a: Int, _ b: Int) -> Int { return a + b }

    func myMul(_ a: Int, _ b: Int) -> Int { return a * b }

    // 'ops' is a function
    func myApply(_ a: Int, _ b: Int, _ ops: (Int, Int) -> Int) -> Int { return ops(a, b) }

    var myOps: (Int, Int) -> Int = myAdd    // function type
    
    let a=2, b=3
    print(" 1| a=\(a), b=\(b)")
    
    let k1 = myOps(a,b)                     // calling myAdd via myOps
    myOps = myMul
    let k2 = myOps(a,b)                     // now myMul
    print(" 2| +: k1=\(k1), *: k2=\(k2)")

    let k3 = myApply(a,b,myOps)             // a function as argument
    let k4 = myApply(a,b,{ $0*$1 })         // a lambda or closure with shorthand argument names
    let k5 = myApply(a,b) { $0*$1 }         // (preview) trailing lambda or closure
    print(" 3| *: k3=\(k3), k4=\(k4), k5=\(k5)")
    
    var base = 11
    
    // nested function with access to context, i.e. local vars
    func localScaledMul(_ a: Int, _ b: Int) -> Int { return base*a*b }
    
    // capture 'base' by value or by reference?
    base = 5
    let ab = localScaledMul(a,b)
    print(" 4| ab=\(ab)")
    
    // functions returning functions
    func makeIncrementer(from start: Int, by amount: Int) -> () -> Int {
        var runningTotal = start
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer                  // returns a closure, pro?
    }
    
    let incrementByTen = makeIncrementer(from: 100, by: 10)
    let i1 = incrementByTen()
    let i2 = incrementByTen()
    print(" 5| i1=\(i1), i2=\(i2)")
    
    // extra mark if a closure lives longer
    // this is an array of closures, stored outside any call
    var completionHandlers: [() -> Void] = []
    
    func loadPictureAgain(completion: @escaping () -> Void) {
        completionHandlers.append(completion)
        // [...] do something
        // completion escapes the function in the sense that it lives longer
    }
}


/**
 Using closures (lambdas), also as last parameter, aka trailing closure/lambda.
 
 Swift says
  - Global functions are closures that have a name and don’t capture any values.
  - Nested functions are closures that have a name and can capture values from their enclosing function.
  - Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
 */
func usingClosures() {
    introduce(topic: "Closures")
    
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]   // array
    print(" 1| names=\(names)")
    
    func backward(_ s1: String, _ s2: String) -> Bool { return s1 > s2 }
    
    let reversedNames1 = names.sorted(by: backward)             // pro/con?
    print(" 2| reversedNames1=\(reversedNames1)")
    
    let reversedNames2 = names.sorted(by: { (s1: String, s2: String) -> Bool in
        return s1 > s2
    })                                                          // a function as an argument
    print(" 3| reversedNames2=\(reversedNames2)")
    
    let reversedNames3 = names.sorted { s1, s2 in s1 > s2 }     // infering types from context, outside
    print(" 4| reversedNames3=\(reversedNames3)")
    
    let reversedNames4 = names.sorted { $0 > $1 }               // with shorthand argument names
    print(" 5| reversedNames4=\(reversedNames4)")
    
    let reversedNames5 = names.sorted(by: >)                    // special operator methods like >
    print(" 6| reversedNames5=\(reversedNames5)")
    
    // remaining args can still be given by func(a,b) { lambda }
    func loadPicture(from server: String,
                     onCompletion: (String) -> Void,
                     onFailure: () -> Void) {
    //        if let picture = download("photo.jpg", from: server) {
    //            onCompletion(picture)
    //        } else {
    //            onFailure()
    //        }
    }
    
    // multiple closures
    loadPicture(from: "www.adobe.com") { picture in
        // ...
    } onFailure: {
        // ...
    }
}

usingArgumentLabels()
usingDefaultArguments()
usingVariadicParameters()
usingFunctions()
usingClosures()
