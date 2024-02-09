
import ExampleFrameworkTarget
import SwiftUI

@main
struct ExamplesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello world!")
    }
}

#Preview {
    ContentView()
}
