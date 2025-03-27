// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

// import the Foundation framework, which provides essential classes and functionalities that are not part of the core Swift language
import Foundation


/// print function intro (docstring, see 'Quick help')
func introduce(topic: String) { print("\n\n\(topic)\n\(String(repeating: "=", count: topic.count))\n") }


/**
 Also a docstring (less common).

 Swift is strongly typed, i.e. the type of every variable is known at compile time and the compiler checks the types of variables and expressions to ensure they are used correctly.
 
 Type inference allows the compiler to deduce the type of a variable from the context, e.g. at initialization.
 
 var means mutable
  - You can reassign the variable.
  - You can mutate it if it’s a struct or class that allows mutation.
 
 let instead of const
  - let means you can’t reassign the variable.
  - For structs, it’s fully immutable.
  - For classes, the reference is fixed, but the object can still change.
  - Swift doesn’t do const fields like C++ — immutability depends on value vs reference types.
 
 Excluded
  - Float - similar to Double
 */
func usingVarAndLet() {
    introduce(topic: "Variables")
    
    var n = 23                              // variable of type Int, type inference from right side
    var m: Int = 24                         // type Int is explicitly given (type annotation); there are also UInt, Int32 etc.
    print(" 1| n=\(n), m=\(m)")             // number '1' helps to associate output with code line

    n = 42                                  // var: n mutable
    m = 1_000_000                           // sometimes more readable
    print(" 2| n=\(n), m=\(m)")

    var k: Int                              // ok, but you cannot use it (missing initialization)
    // print(" 3| k=\(k)")
    k = 99
    print(" 3| k=\(k)")                     // now you can use it

    var s = "some string"                   // type String
    let c: Character = "!"                  // let: initialized once; char: no single quotes

    s += " - extended"                      // mutable; more on strings later
    s.append(c)
    print(" 4| s='\(s)'")

    let pi = 3.14                           // can only be initialized once
    let intPi = Int(pi)                     // conversion, use Type(value) as cast
    print(" 5| pi=\(pi), intPi=\(intPi)")
    
    let b = true                            // or false
    print(" 6| b=\(b)")
    
    let a = [1, 2, 3]                       // array, not fixed size, like std::vector or ArrayList
    print(" 7| a=\(a)")
    // a = [4, 5]                           // the reference is fixed
    // a[1] = 22                            // nope - because of 'let'
    // a.append(44)                         // same
}


/**
 Basic string ops.
 
 Multiline string literal includes all of the lines between its opening and closing quotation marks (without the lines with the quotation marks) and without the leading whitespace
 */
func usingStringsPartI() {
    introduce(topic: "Strings - Part I")

    let s = "one string"                    // standard string
    let rs = #"a raw string, no escaped chars \n \t ..."#       //  literal within extended delimiters
    print(" 1| s='\(s)', rs='\(rs)'")

    let ls = """
    multiline string
        second line
    third line
    """
    print(" 2| ls='\(ls)'")

    let exclamationMark: Character = "!"
    let helloChars: [Character] = ["H", "e", "l", "l", "o", exclamationMark]
    let hello = String(helloChars)
    print(" 3| hello='\(hello)'")
    
    // some member functions and operations on digits
    let digits = "0123456789"
    print(" 4| digits='\(digits)', empty? \(digits.isEmpty)" +
          ", count=\(digits.count), twice='\(digits+digits)'")
    
    // extended grapheme clusters, be careful with adding chars (see Café)
    let s1 = "HiHo" + String(exclamationMark)
    let s2 = "Cafe" + "\u{301}"
    print(" 5| s1='\(s1)', count: \(s1.count)," +
             " s2='\(s2)', count: \(s2.count)")
}

/**
 Using tuples and deconstruction.
 
 Note the named entries, like an anonymous type in C#.
 */
func usingTuples() {
    introduce(topic: "Tuples")

    let http404Error = (404, "Not Found")   // a tuple
    print(" 1| http404Error=\(http404Error)")
    print(" 2| access: .0=\(http404Error.0), .1=\(http404Error.1)")

    // deconstructing a tuple, use '_' to explicitly not name an entry
    let (statusCode, statusMessage) = http404Error
    let (justTheStatusCode, _) = http404Error
    print(" 3| statusCode=\(statusCode), statusMessage=\(statusMessage)")
    print(" 4| justTheStatusCode=\(justTheStatusCode)")
    
    // name it, if you like
    let http200Status = (statusCode: 200, description: "OK")
    print(" 5| statusCode=\(http200Status.statusCode), description=\(http200Status.description)")
    
    // use case: combined return value, also named
    func f() -> (a: Int, b: Int) {          // preview: local function
        return (a:1, b:2)
    }
    let g = f()
    print(" 6| g.a=\(g.a), g.b=\(g.b)")

    // tuple decomposition (let and var)
    let (n, b) = (1, true)
    // let (n, b): (Int, Bool) = (1, true)  // with types, if you have to
    print(" 7| n=\(n), b=\(b)")
}


/**
 Working with ranges, closed and open.
 
 Note: In general, a closed range might not be indexable, so Swift doesn’t pretend t have an endIndex.
 In particular, an index need not always be an integer!
 
 Excluded
  - stride
 */
func usingRanges() {
    introduce(topic: "Ranges")

    // a closed range
    let rg1 = 2...5
    print(" 1| rg1=\(rg1), count: \(rg1.count)" +
          ", lowerBound: \(rg1.lowerBound), upperBound: \(rg1.upperBound)" +
          ", startIndex: \(rg1.startIndex), endIndex: \(rg1.endIndex)")

    print(" 2| entries:", terminator: "")
    for i in rg1 {
        print(" \(i)", terminator: "")
    }
    print()

    // an open range
    let rg2 = 2..<5
    print(" 3| rg2=\(rg2), count: \(rg2.count)" +
          ", lowerBound: \(rg2.lowerBound), upperBound: \(rg2.upperBound)" +
          ", startIndex: \(rg2.startIndex), endIndex: \(rg2.endIndex)")
    
    print(" 4| entries:", terminator: "")
    for i in rg2 {
        print(" \(i)", terminator: "")
    }
    print()
    
    // partial range, there is also a ...10, but no count or upperBound
    let rg3 = 10...
    print(" 5| rg3=\(rg3), count: -" +
          ", lowerBound: \(rg3.lowerBound), upperBound: -" +
          ", startIndex: -, endIndex: -")
    
    print(" 6| entries:", terminator: "")
    for i in rg3 {
        print(" \(i)", terminator: "")
        if i==15 { break }
    }
    print()
}


/**
 Working with optional, nil-coalescing operators and optional binding.
 
 A problem in many programming languages that use references are those that are not initialised or point to nothing, aka Null, nullptr, nil, None, etc.
 Basically the idea is to distinguish between situations where a reference can be null and those where it cannot. And most importantly, not at runtime, but at compile time.
 So there are types that are always initialised and types that can be 'nil' in swift, called 'optionals' ('Type?'). Compare this with Java or C# or Kotlin, for instance.
 */
func usingOptionals() {
    introduce(topic: "Optionals")
    
    // optional, i.e. Int or nil, and we need to work with...
    var responseCode: Int? = 404
    
    // nil-coalescing-operator ??: take value of responseCode if not nil, otherwise -1
    let code = responseCode ?? -1

    // print(" 1| responseCode=\(responseCode), code=\(code)")  // warning because of debug description
    print(" 1| responseCode=\(responseCode ?? -1), code=\(code)")

    // responseCode = nil
    // (preview) 'if' with optional binding, inside 'rc' is not optional anymore
    if let rc = responseCode {
        print(" 2| rc=\(rc)")
    }
    
    // you can force unwrapping with '!'... be sure about that
    print(" 3| responseCode!=\(responseCode!)")
    
    let s42 = Int("42")                     // being optional is not always obvious
    print(" 4| s42=\(s42 ?? -1)")
}


/**
 Computed properties on top-level?
 
 Usually used in classes, but also works outside 'sometimes'. Setter is optional. If not given, property is read-only.
 
 See some use cases.
 */
func usingComputedProperties() {
    introduce(topic: "Computed Properties")
    
    // this is a getter
    var today: String {
        DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
    }
    print(" 1| today=\(today)")
    
    //    var today: String {
    //        get {
    //            DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
    //        }
    //    }
    //
    
    // just for the syntax; this just works in scripts outside of a struct or class;
    // see 'minutes' as some sort of a backing field, a place to store the value
    var minutes = 210
    var hours: Double {
        get { print(" a|   get hours"); return Double(minutes) / 60.0 }
        set { print(" b|   set hours, minutes old=\(minutes), new=\(newValue)"); minutes = Int(newValue * 60.0) }
    }
    print(" 2| minutes=\(minutes), hours=\(hours)")
    hours = 2.5
    print(" 3| minutes=\(minutes), hours=\(hours)")
}


/**
 More string functions.
 
 Note, that the index does not have to be a simple int. Because of character encoding, indexing a string is a bit tedious.
 The reason ist, that a string is not just a collection of bytes or Unicode scalars — it’s a collection of grapheme clusters, which can vary wildly in length and encoding.
 
 Excluded
  - string! type
 */
func usingStringsPartII() {
    introduce(topic: "Strings - Part II")
    
    let text = "Hello, Swift World!"

    print(" 1| text empty? \(text.isEmpty)")

    print(" 2| Concatenation: '\(text + "!!")'")

    print(" 3| Example uppercase: '\(text.uppercased())'")
    
    let trimmed = ("  "+text+"  \n").trimmingCharacters(in: .whitespacesAndNewlines)
    print(" 4| trimmed: '\(trimmed)'")
    
    // finds and returns the range of the first occurrence
    if let range = text.range(of: "Swift") {
        let replaced = text.replacingCharacters(in: range, with: "SwiftUI")
        print(" 5| replaced: '\(replaced)'")
    }

    let answer = text.contains("Swift") ? "Yes" : "No"
    print(" 6| contains 'Swift'? \(answer)")

    let words = text.split(separator: " ")
    print(" 7| words in '\(text)': \(words)")

    if let firstChar = text.first {
        print(" 8| first char: '\(firstChar)'")
    }
    
    // remember: a String.Index is only valid for the specific string it came from
    
    var mutableText = text

    if let index = mutableText.firstIndex(of: ",") {
        mutableText.insert(contentsOf: " wonderful", at: mutableText.index(after: index))
        print(" 9| insert after ',': \(mutableText)")
    }

    if let index = mutableText.firstIndex(of: "!") {
        mutableText.remove(at: index)
        print("10| after removal: '\(mutableText)'")
    }
    
    // (preview) 'if', double 'let'; it is like a logical &&, so both must be non-nil
    if let startIndex = text.firstIndex(of: "S"), let endIndex = text.firstIndex(of: "t") {
        let range = startIndex...endIndex
        let substring = text[range]
        print("11| extracted: '\(substring)'")
    }
    
    let tenthCharIndex = text.index(text.startIndex, offsetBy: 9)
    let tenthChar = text[tenthCharIndex]
    print("12| 10'th char: '\(tenthChar)'")

    let text5 = String(text.prefix(5))
    print("13| as chars:", terminator: "")
    for c in text5 {
        print(" '\(c)", terminator: "")
    }
    print("\n14| as chars with indeces:", terminator: "")
    
    for (i, c) in text5.enumerated() {
        print(" ('\(c)',\(i))", terminator: "")
    }
    
    print("\n15| as chars by index:", terminator: "")
    var currentIndex = text5.startIndex
    while currentIndex < text5.endIndex {
        let c = text5[currentIndex]
        print(" '\(c)'", terminator: "")
        currentIndex = text5.index(after: currentIndex)
    }

    // note, this is just a layer, it consumes no further memory
    print("\n16| as chars, reversed:", terminator: "")
    for c in text5.reversed() {
        print(" '\(c)", terminator: "")
    }
    print()
}

usingVarAndLet()
usingStringsPartI()
usingTuples()
usingRanges()
usingOptionals()
usingComputedProperties()
usingStringsPartII()
