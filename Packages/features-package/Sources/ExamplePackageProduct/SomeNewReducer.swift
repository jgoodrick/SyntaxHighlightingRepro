
import Architecture

public struct ExamplePackageProductStruct {
    public init() {}
}

@Reducer
struct SomeNewReducer: Reducer {
    struct State {}
    enum Action { case task }
    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
