import SwiftUI
import ComposableArchitecture

/// TCA Reducer 프로토콜 기반 구현 시 Scope 라우팅 문제 샘플 앱
@main
struct TcaReducerMixingSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: RootFeature.State(),
                    reducer: { RootFeature() }
                )
            )
        }
    }
}
