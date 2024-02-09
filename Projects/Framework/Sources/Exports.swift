
import ComposableArchitecture

@Reducer
struct Thing: Reducer {
    struct State {}
    enum Action { case task }
    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
