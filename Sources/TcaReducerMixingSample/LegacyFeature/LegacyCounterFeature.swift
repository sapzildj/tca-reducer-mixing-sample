import ComposableArchitecture

/// Reducer 프로토콜 기반으로 구현된 카운터 Feature
/// (현재 샘플에서는 사용하지 않지만 참고용으로 남겨둠)
struct LegacyCounterFeature: Reducer {
    struct State: Equatable {
        var count = 0
    }

    enum Action {
        case increment
        case decrement
        case reset
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .increment:
            state.count += 1
            print("[Legacy] action: increment, count: \(state.count)")
            return .none

        case .decrement:
            state.count -= 1
            print("[Legacy] action: decrement, count: \(state.count)")
            return .none

        case .reset:
            state.count = 0
            print("[Legacy] action: reset, count: \(state.count)")
            return .none
        }
    }
}
