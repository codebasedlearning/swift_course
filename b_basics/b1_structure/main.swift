// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

// a line comment

/*
 * Block comment, can be /* nested */
 */


print("Swift-Course -> 'Welcome!'")         // print function
print("-------------------------"); print() // semicolons for multiple separate statements

print(" 1| A single line.")                 // number '1|' helps to associate output with code line

print(" 2| More text", terminator: "")      // call with second parameter for end-of-line-string
print(" - rest of line.")

print(" 3| Expressions: 42+1=\(42+1)")      // string interpolation: \(expression)
print()

print(" 4| Enter text: ", terminator: "")

let line = readLine() ?? "-"                // nil-coalescing operator, if nil then '-'
print("04| Text '\(line)'")


/*
 More
  - You don’t traditionally define a main function like you do in some other languages. Instead, Swift uses a special file named 'main.swift' as the entry point for the program (there are more options, but not today).
 */
