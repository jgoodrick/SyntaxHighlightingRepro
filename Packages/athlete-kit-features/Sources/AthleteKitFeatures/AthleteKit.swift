
import Architecture
import ComposableArchitecture
import TaggedValues

let thing = SomeArchitecturalComponent()

@Reducer
struct AthleteKit: Reducer {
    
    @ObservableState
    struct State: Equatable {
        public init() {}
        let id: TaggedID<Self> = .init(rawValue: .init())
    }
    
    enum Action {
        case task
    }
    
    var body: some Reducer<State, Action> {
        Reduce<State, Action> { state, action in
            switch action {
            case .task:
                return .none
            }
        }
    }
}

