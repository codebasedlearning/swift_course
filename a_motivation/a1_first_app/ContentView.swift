// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

/*
 Here we have a similar structure to 'App' and 'body', but with 'View'. 'View' is the base protocol that all visible UI components conform to.
 
 SwiftUI builds its UI programmatically using a declarative syntax, i.e. instead of telling the system how to build and update the UI step by step (imperative), you just describe what the UI should look like for a given state.
 
 So while you could think of View as the “base” of all SwiftUI things, it’s not like an object-oriented base class. It’s more like:
 - A capability: “You can be rendered”
 - A contract: “Give me a 'body' and I’ll show you on screen”
 
 'VStack' stacks its children vertically. But on a language level this is a 'trailing closure/lambda syntax' returning a (combined) result-view, i.e. if the last parameter is a closure, you can pull it out of the parentheses. Inside the {} a view hierarchy is built, kind of like creating a virtual DOM or layout tree.
 
 We can also observe 'named parameters' and 'enums' (.large, .tint, .vertical, etc.).
 
 Finally, we have 'chaining', i.e. calling member functions chained on an instance.
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .padding(.vertical, 16)
            Text("Hello, iOS Course!")
        }
        .padding()
    }
}
