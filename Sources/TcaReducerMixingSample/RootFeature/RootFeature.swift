import ComposableArchitecture

/// TCA Reducer 프로토콜 기반 구현 시 Scope 라우팅 문제 재현
/// Reducer 프로토콜로 구현하고 body에서 Scope와 Reduce를 조합하면
/// Scope를 통한 액션 라우팅이 동작하지 않는 문제
struct RootFeature: Reducer {
    struct State: Equatable {
        var counter = 0  // RootFeature 자신의 counter
        var new = NewCounterFeature.State()  // Scope로 연결된 하위 Feature
    }

    @CasePathable
    enum Action {
        // RootFeature 자신의 액션들
        case rootIncrement
        case rootDecrement
        case rootReset

        // 하위 Feature 액션 (Scope를 통해 라우팅되어야 함)
        case new(NewCounterFeature.Action)
    }

    var body: some ReducerOf<Self> {
        // Scope를 통한 하위 Feature 연결
        // 이론적으로는 .new 액션을 NewCounterFeature로 라우팅해야 함
        Scope(state: \.new, action: \.new) {
            NewCounterFeature()
        }

        // Reduce 클로저: RootFeature 자신의 로직 처리
        // .new 액션은 return .none으로 Scope에 전달되어야 하지만,
        // 실제로는 라우팅이 동작하지 않음 (Preview와 실제 앱 모두)
        Reduce { state, action in
            self.reduce(into: &state, action: action)
        }
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        // RootFeature 자신의 counter 로직 - Reduce 클로저에서 직접 처리
        case .rootIncrement:
            state.counter += 1
            print("[Root] action: increment, counter: \(state.counter)")
            return .none

        case .rootDecrement:
            state.counter -= 1
            print("[Root] action: decrement, counter: \(state.counter)")
            return .none

        case .rootReset:
            state.counter = 0
            print("[Root] action: reset, counter: \(state.counter)")
            return .none

        // .new 액션은 Scope로 전달되어야 하지만,
        // return .none으로 넘겨도 실제로는 라우팅이 동작하지 않음
        case .new:
            return .none
        }
    }
}
