
//@_exported import AthleteKitFeatures
import Architecture

@Reducer
struct Thing: Reducer {
    struct State {}
    enum Action { case task }
    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
