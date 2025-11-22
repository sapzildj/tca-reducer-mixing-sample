import ComposableArchitecture

/// @Reducer 매크로 기반으로 구현된 카운터 Feature
/// RootFeature에서 Scope를 통해 연결되는 하위 Feature
@Reducer
struct NewCounterFeature {
    struct State: Equatable {
        var count = 0
    }

    enum Action {
        case increment
        case decrement
        case reset
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .increment:
                state.count += 1
                print("[New] action: increment, count: \(state.count)")
                return .none

            case .decrement:
                state.count -= 1
                print("[New] action: decrement, count: \(state.count)")
                return .none

            case .reset:
                state.count = 0
                print("[New] action: reset, count: \(state.count)")
                return .none
            }
        }
    }
}
